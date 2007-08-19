From: errordeveloper@gmail.com
Subject: Snd problem ... ( ACCESS_TYPE )
Date: Sun, 19 Aug 2007 07:25:39 +0000
Message-ID: <20070819072539.GA25373__48141.7815237821$1191435201$gmane$org@00110101.errordevlopment.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by alsa0.perex.cz (Postfix) with ESMTP id D6911244CF
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Oct 2007 20:12:46 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so183654ugf
	for <alsa-devel@alsa-project.org>; Wed, 03 Oct 2007 11:12:46 -0700 (PDT)
Resent-Message-ID: <20071003181501.GG6109@00110101.errordevlopment.org.uk>
Resent-To: alsa-devel@alsa-project.org
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi list.

I' m using alsa-lib v1.0.14rc2 on gentoo-linux (v2.6.20-gentoo-r8)
my soundcard is RME Hammerfall HDSP9632 (snd-hdsp driver)
i have been using it for a while - all fine
i only run a few applications for my sound experiments.
one of those is Snd (from CCRMA), it was okay until i have done a few
updates lately - kernel from 2.6.17 to 2.6.20 and alsa-lib as well.
i'm not sure about either of these but i check Snd src-tree and the
mailing list - nothing was changed ..

the error msg that i get is:

:(play)
;status of hw:0
hw_params status of hw:0
ACCESS:  MMAP_NONINTERLEAVED RW_NONINTERLEAVED
FORMAT:  S32_LE
SUBFORMAT:  STD
SAMPLE_BITS: 32
FRAME_BITS: [128 384]
CHANNELS: [4 12]
RATE: [32000 192000]
PERIOD_TIME: (333 256000]
PERIOD_SIZE: [64 8192]
PERIOD_BYTES: [2560 393216]
PERIODS: 2
BUFFER_TIME: (666 512000]
BUFFER_SIZE: [128 16384]
BUFFER_BYTES: [2560 786432]
TICK_TIME: 1000
sw_params status of hw:0
start_mode: DATA
xrun_mode: STOP
tstamp_mode: NONE
period_step: 0
sleep_min: 0
avail_min: 0
xfer_align: 0
silence_threshold: 0
silence_size: 0
boundary: 0
;Invalid argument: hw:0: access type RW_INTERLEAVED not available
can't play : Invalid argument: hw:0: access type RW_INTERLEAVED not
available
#f
:

i had tried to modify audio.c in Snd's tree to use both ACCESS types
given above , but it didn't help - showed device is busy error instead.
i'm only studying C, so can't be sure ..

anyway here is a problem which i could not solve yet and haven't seen
anyone helpful around #alsa, neither i could google anything out.


for a ref.: Cmdist mailing list                                                                                                                         Cmdist@ccrma.stanford.edu                                                                                                                   http://ccrma-mail.stanford.edu/mailman/listinfo/cmdist
and our discussion is here:
http://ccrma-mail.stanford.edu/pipermail/cmdist/2007-July/004221.html

could anyone have a look at this at somepoint, please .

-- 
thank you,
Ilya. D
errordeveloper|*@*|gmail|*dot*|com
