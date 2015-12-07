From: "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
Subject: Re: [PATCH v2 0/6] ASoC: fsl_ssi: Fixing various
 channel slips and bad samples insertions
Date: Mon, 7 Dec 2015 13:41:21 +0100
Message-ID: <56657E71.1030405@invoxia.com>
References: <1448550341-11765-1-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 37948265512
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 13:41:23 +0100 (CET)
Received: by wmvv187 with SMTP id v187so164450859wmv.1
 for <alsa-devel@alsa-project.org>; Mon, 07 Dec 2015 04:41:22 -0800 (PST)
In-Reply-To: <1448550341-11765-1-git-send-email-arnaud.mouiche@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>, Roberto Fichera <kernel@tekno-soft.it>, Markus Pargmann <mpa@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi all.

Yes, Caleb and I are working on issues when dealing with N channels, N > =

2, but everyone can experience those issues with N=3D2.
It is true that a Left/Right switching on audio in not tragic for most =

users, but I think is will be good if this kind of channel switch can be =

definitely fixed by the patches I propose.

Here is a very basic test to demonstrate a 2 channels classical scenario =

that everyone can experience on a imx6 SOC.

   #!/bin/sh

   amixer set PCM 100%,0%
   arecord -D hw:0,0 -c 2 -r 48000 -f S16_LE  /tmp/foo.wav </dev/null &
   pid=3D$!
   speaker-test -t sine -D hw:0,0 -r 48000 -c 2 -l 1
   kill $pid

what is done:
- Right channel is muted at the codec level (so if we try to play =

something on the right channel only, nothing is heard).
- We start recording (arecord)
- then we start a tone generation (speaker-test), starting by the left =

channel during few first seconds.

what is expected:
- We should hear the tone on left channel right after speaker-test starts.

what is experienced:
- 50% of the time, we don't here anything, until speaker-test switch to =

the right meaning Left and Right channels are switched.

Regards,
Arnaud




Le 26/11/2015 16:05, Arnaud Mouiche a =E9crit :
> This series of patch is an attempt to fix the fsl_ssi driver to use it in=
 TDM mode (DSP A or B) with a large number of channels/slots.
>
> Version 2:
> - fixing a missing patch
> - checkpatch.pl
> - ... well, learning how to send a patchset. Sorry. ;)
>
>
> Bugs are detected and fixed on a imx6sl platform with linux 4.3, where 2 =
SSI interfaces are used. SSI3 configured as a master of the bus, SSI2 as a =
slave.
>
> Various loopback scenario are tested:
> * scenario 1: SSI3 (master) with TXD to RXD loopback
>
> 	         |
> 	         |---> TXD  --\
> 	SSI3     |<--- RXD  --/
> 	(master) |---> SYNC
> 	         |---> BCLK
> 	         |
> 	=

> * scenario 2: SSI3 connected to SSI2
> 	         |
> 	         |---> TXD  --------\
> 	SSI3     |<--- RXD  -----\  |
> 	(master) |---> SYNC --\  |  |
> 	         |---> BCLK   |  |  |
> 	         |       |    |  |  |
> 	         |       |    |  |  |
> 	         |<--- BCLK   |  |  |
> 	SSI2     |<--- SYNC --/  |  |
> 	(slave)  |---> TXD ------/  |
> 	         |<--- RXD  --------/
> 	         |
>
>
>
> A test software (called atest) was developed and available. [1]
> It basically generate/check specials frames with S16_LE sequence samples
>         NNN0, NNN1, NNN2 ... NNNC     with NNN =3D frame number, and C th=
e number of channels-1
>
>
>
> Patch 1:
> 	Limitation fix. Prerequisite to use the fsl_ssi driver with up to 32 cha=
nnels / slots
>
> Patch 2:
> 	Bug fix. Prerequisite to setup a relative high bitclk for our tests in 8=
ch / 16bits / 48kHz
>
> Patch 3:
> 	Simply save a 'dev' reference inside ssi_private for dev_err() purpose.
> 	(ssi_private is only available in lot of places, and
> 	 ssi_private->pdev is deprecated and NULL indeed)
>
> Patch 4:
> 	Fix playback samples being dropped because the TX fifo was not ready at
> 	the time the DMA starts filling (only in case where playback is started =
AFTER the capture)
>
> 	Detected in loopback scenario 1, with following script (> 80 % of reprod=
ucibility)
> 	$ atest -D SSI3 -c 8 -r 48000 capture play
> 	dbg: set period size: 960
> 	dbg: SSI3: capture_start
> 	dbg: SSI3: playback_start
> 	err: invalid frame after 1 null frames
> 	err:   0000 0000 0013 0014 0015 0016 0017 0020
> 	dbg: SIGINT
> 	total number of sequence errors: 21119
> 	=

> 	here we see that samples 0000 0001 ... 0012 are not present in the outpu=
t.
> 	In addition, this the number of samples dropped is not a multiple of
> 	the number of channel, we have a a channel slip.
>
>
> Patch 5:
> 	This is the Caleb Crome's case [2], where the SSI starts to generate sam=
ples while
> 	the TX FIFO is not filled by the DMA yet. Void samples can be inserted b=
efore DMA streaming.
>
> 	Detected in loopback scenario 2, with following script (reproducibility =
< 1%)
> 	$ atest -D SSI3 -c 8 -r 48000 capture &
> 	$ sleep 0.2
> 	$ atest -d 1 -D SSI2 -c 8 -r 48000 play
> 	dbg: SSI3: capture_start
> 	dbg: set period size: 960
> 	dbg: SSI2: playback_start
> 	dbg: start a 1 seconds duration timer
> 	err: invalid frame after 11568 null frames
> 	err:   0000 0010 0011 0012 0013 0014 0015 0016
> 	err:   0017 0020 0021 0022 0023 0024 0025 0026
>
>
>
> Patch 6:
> 	Deals with Capture restart whereas Playback is still running
> 	(or the opposite, Playback restart whereas Capture is till running).
> 	=

> 	Capture restart whereas Playback case is detected in
> 	loopback scenario 1 (reproducibility 100%).
> 	A playback session is running in background, and
> 	2 consecutive Captures are performed.
> 	The first is fine, the second fails.
> 	=

> 	We see at the 2nd capture startup that we receive 15 samples
> 	still pending in the RX FIFO from the previous capture session.
> 	=3D> We are receiving invalid samples + slips the channels
> 	=

> 	$ atest -D SSI3 -c 8 -r 48000 play &
> 	dbg: SSI3: playback_start
> 	$ atest -d 1 -D SSI3 -c 8 -r 48000 capture
> 	dbg: SSI3: capture_start
> 	dbg: start a 1 seconds duration timer
> 	warn: Valid frame after 1 null frames
> 	warn:   3a90 3a91 3a92 3a93 3a94 3a95 3a96 3a97
> 	total number of sequence errors: 0
> 	=

> 	$ atest -I 5 -d 1 -D SSI3 -c 8 -r 48000 capture  # restart the capture
> 	dbg: SSI3: capture_start
> 	dbg: start a 1 seconds duration timer
> 	err: invalid frame after 1 null frames
> 	err:   8dd6 8dd7 8de0 8de1 8de2 8de3 8de4 8de5
> 	err:   8de6 8de7 8df0 8df1 8df2 8df3 8df4 c0c0
> 	err:   c0c1 c0c2 c0c3 c0c4 c0c5 c0c6 c0c7 c0d0
> 	err:   c0d1 c0d2 c0d3 c0d4 c0d5 c0d6 c0d7 c0e0
> 	err:   c0e1 c0e2 c0e3 c0e4 c0e5 c0e6 c0e7 c0f0
>
>
> 	Playback restart whereas Capture case is also detected with
> 	loopback scenario 1 (reproducibility 100%), capturing continuously,
> 	and playing by periods of time.
> 	=

> 	$ atest -a -D SSI3 -c 8 -r 48000 capture play -r 1000,200
> 	dbg: SSI3: capture_start
> 	dbg: SSI3: playback_start
> 	dbg: SSI3: will stop every 1000 ms during 200 ms
> 	warn: Valid frame after 4 null frames
> 	warn:   0010 0011 0012 0013 0014 0015 0016 0017
> 	warn: SSI3: PT_W4_STOP
> 	warn: SSI3: PT_W4_RESTART
> 	err: invalid frame after 1602 null frames
> 	err:   eaa1 eaa2 eaa3 eaa4 eaa5 eaa6 eaa7 eab0
> 	err:   eab1 eab2 eab3 eab4 5810 5811 5812 5813
> 	dbg: stop on first error
> 	total number of sequence errors: 143
>
> 	=

> 	=

> 	Both cases are resolved by using the mostly undocumented SOR.RX_CLR and
> 	SOR TX_CLR (we can find the documentation in IMX51 reference manual
> 	at section 56.3.3.15).
> 	=

> 	=

> Arnaud
>
>
>
> [1] https://github.com/amouiche/atest
> [2] http://mailman.alsa-project.org/pipermail/alsa-devel/2015-October/099=
221.html
>
>
>
> Arnaud Mouiche (6):
>    ASoC: fsl_ssi: Real hardware channels max number is 32
>    ASoC: fsl_ssi: The IPG/5 limitation concerns the bitclk, not the
>      sysclk.
>    ASoC: fsl_ssi: Save a dev reference for dev_err() purpose.
>    ASoC: fsl_ssi: Fix samples being dropped as Playback startup
>    ASoC: fsl_ssi: Fix channel slipping in Playback at startup
>    ASoC: fsl_ssi: Fix channel slipping on capture (or playback) restart
>      in full duplex.
>
>   sound/soc/fsl/fsl_ssi.c | 74 +++++++++++++++++++++++++++++++++++++++++-=
-------
>   1 file changed, 63 insertions(+), 11 deletions(-)
>
