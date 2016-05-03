From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: [PATCH v4 0/6] ASoC: fsl_ssi: Fixing various channel
	slips and bad samples insertions
Date: Tue,  3 May 2016 14:13:54 +0200
Message-ID: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 098C92658ED
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2016 14:14:08 +0200 (CEST)
Received: by mail-wm0-f41.google.com with SMTP id g17so35393214wme.1
 for <alsa-devel@alsa-project.org>; Tue, 03 May 2016 05:14:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, festevam@gmail.com, caleb@crome.org
Cc: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

Version 4:
- rebase on top of v4.6-rcX + alsa-broonie/for-next.
- The only change with v3 concerns the patch 6/6, since CCSR_SSI_SOR is now already included in 
  the list of volatile registers. 

Version 3:
- rebase + fix + test on top of linux 4.4 + 'for-next'

Version 2:
- fixing a missing patch 
- checkpatch.pl
- ... well, learning how to send a patchset. Sorry. 


Bugs are detected and fixed on a imx6sl platform with linux 4.4 + 'for-next' branch, where 2 SSI interfaces are used. 
SSI3 configured as a master of the bus, SSI2 as a slave.
Similar tests were done on a imx6solo platform by Caleb Crome (He will propose a patch concerning fifo depth to fix DMA xrun at highest bitrates)


Various loopback scenario are tested:
* scenario 1: SSI3 (master) with TXD to RXD loopback

	         |
	         |---> TXD  --\
	SSI3     |<--- RXD  --/
	(master) |---> SYNC
	         |---> BCLK
	         |
	
* scenario 2: SSI3 connected to SSI2
	         |
	         |---> TXD  --------\
	SSI3     |<--- RXD  -----\  |
	(master) |---> SYNC --\  |  |
	         |---> BCLK   |  |  |
	         |       |    |  |  |
	         |       |    |  |  |
	         |<--- BCLK   |  |  |
	SSI2     |<--- SYNC --/  |  |
	(slave)  |---> TXD ------/  |
	         |<--- RXD  --------/
	         |



A test software (called atest) was developed and available. [1]
It basically generate/check specials frames with S16_LE sequence samples
       NNN0, NNN1, NNN2 ... NNNC     with NNN = frame number, and C the number of channels-1



Patch 1: 
	Limitation fix. Prerequisite to use the fsl_ssi driver with up to 32 channels / slots

Patch 2: 
	Bug fix. Prerequisite to setup a relative high bitclk for our tests in 8ch / 16bits / 48kHz

Patch 3:
	Simply save a 'dev' reference inside ssi_private for dev_err() purpose.
	(ssi_private is only available in lot of places, and 
	 ssi_private->pdev is deprecated and NULL indeed)

Patch 4: 
	Fix playback samples being dropped because the TX fifo was not ready at 
	the time the DMA starts filling (only in case where playback is started AFTER the capture)

	Detected in loopback scenario 1, with following script (> 80 % of reproducibility)
	$ atest -D SSI3 -c 8 -r 48000 capture play
	dbg: set period size: 960
	dbg: SSI3: capture_start
	dbg: SSI3: playback_start
	err: invalid frame after 1 null frames
	err:   0000 0000 0013 0014 0015 0016 0017 0020 
	dbg: SIGINT
	total number of sequence errors: 21119
	
	here we see that samples 0000 0001 ... 0012 are not present in the output.
	In addition, this the number of samples dropped is not a multiple of 
	the number of channel, we have a a channel slip.


Patch 5: 
	This is the Caleb Crome's case [2], where the SSI starts to generate samples while 
	the TX FIFO is not filled by the DMA yet. Void samples can be inserted before DMA streaming.

	Detected in loopback scenario 2, with following script (reproducibility < 1%)
	$ atest -D SSI3 -c 8 -r 48000 capture &
	$ sleep 0.2
	$ atest -d 1 -D SSI2 -c 8 -r 48000 play
	dbg: SSI3: capture_start
	dbg: set period size: 960
	dbg: SSI2: playback_start
	dbg: start a 1 seconds duration timer
	err: invalid frame after 11568 null frames
	err:   0000 0010 0011 0012 0013 0014 0015 0016 
	err:   0017 0020 0021 0022 0023 0024 0025 0026 



Patch 6: 
	Deals with Capture restart whereas Playback is still running
	(or the opposite, Playback restart whereas Capture is till running).
	
	Capture restart whereas Playback case is detected in 
	loopback scenario 1 (reproducibility 100%). 
	A playback session is running in background, and 
	2 consecutive Captures are performed. 
	The first is fine, the second fails.
	
	We see at the 2nd capture startup that we receive 15 samples
	still pending in the RX FIFO from the previous capture session.
	=> We are receiving invalid samples + slips the channels
	
	$ atest -D SSI3 -c 8 -r 48000 play &
	dbg: SSI3: playback_start
	$ atest -d 1 -D SSI3 -c 8 -r 48000 capture
	dbg: SSI3: capture_start
	dbg: start a 1 seconds duration timer
	warn: Valid frame after 1 null frames
	warn:   3a90 3a91 3a92 3a93 3a94 3a95 3a96 3a97 
	total number of sequence errors: 0
	
	$ atest -I 5 -d 1 -D SSI3 -c 8 -r 48000 capture  # restart the capture
	dbg: SSI3: capture_start
	dbg: start a 1 seconds duration timer
	err: invalid frame after 1 null frames
	err:   8dd6 8dd7 8de0 8de1 8de2 8de3 8de4 8de5 
	err:   8de6 8de7 8df0 8df1 8df2 8df3 8df4 c0c0 
	err:   c0c1 c0c2 c0c3 c0c4 c0c5 c0c6 c0c7 c0d0 
	err:   c0d1 c0d2 c0d3 c0d4 c0d5 c0d6 c0d7 c0e0 
	err:   c0e1 c0e2 c0e3 c0e4 c0e5 c0e6 c0e7 c0f0 


	Playback restart whereas Capture case is also detected with
	loopback scenario 1 (reproducibility 100%), capturing continuously,
	and playing by periods of time.
	
	$ atest -a -D SSI3 -c 8 -r 48000 capture play -r 1000,200
	dbg: SSI3: capture_start
	dbg: SSI3: playback_start
	dbg: SSI3: will stop every 1000 ms during 200 ms
	warn: Valid frame after 4 null frames
	warn:   0010 0011 0012 0013 0014 0015 0016 0017 
	warn: SSI3: PT_W4_STOP
	warn: SSI3: PT_W4_RESTART
	err: invalid frame after 1602 null frames
	err:   eaa1 eaa2 eaa3 eaa4 eaa5 eaa6 eaa7 eab0 
	err:   eab1 eab2 eab3 eab4 5810 5811 5812 5813 
	dbg: stop on first error
	total number of sequence errors: 143

	
	
	Both cases are resolved by using the mostly undocumented SOR.RX_CLR and 
	SOR TX_CLR (we can find the documentation in IMX51 reference manual 
	at section 56.3.3.15).
	
	
Arnaud



[1] https://github.com/amouiche/atest
[2] http://mailman.alsa-project.org/pipermail/alsa-devel/2015-October/099221.html

Arnaud Mouiche (6):
  ASoC: fsl_ssi: Real hardware channels max number is 32
  ASoC: fsl_ssi: The IPG/5 limitation concerns the bitclk, not the
    sysclk.
  ASoC: fsl_ssi: Save a dev reference for dev_err() purpose.
  ASoC: fsl_ssi: Fix samples being dropped at Playback startup
  ASoC: fsl_ssi: Fix channel slipping in Playback at startup
  ASoC: fsl_ssi: Fix channel slipping on capture (or playback) restart
    in full duplex.

 sound/soc/fsl/fsl_ssi.c | 80 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 69 insertions(+), 11 deletions(-)

-- 
1.9.1
