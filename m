From: Caleb Crome <caleb@crome.org>
Subject: Re: Need general idea how to architect driver for
 multi-codec board
Date: Wed, 1 Jun 2011 15:17:10 -0700
Message-ID: <BANLkTinhMP143K5mAPPPc_R6N7Wxk8zZ3g@mail.gmail.com>
References: <BANLkTi=Fi_4nCP7A3Jd9C=4N_FTijOwGdw@mail.gmail.com>
	<20110511175021.GB22798@sirena.org.uk>
	<BANLkTi=arRRqPEDS9S=-ynM_1d8N_A=d+w@mail.gmail.com>
	<20110527012756.GA26768@sirena.org.uk>
	<BANLkTinM_MigPxzY4WCBZhjRPwuV15b9gQ@mail.gmail.com>
	<20110528013355.GD5971@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.212.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 4837A24596
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Jun 2011 00:17:14 +0200 (CEST)
Received: by pxi10 with SMTP id 10so188248pxi.8
	for <alsa-devel@alsa-project.org>; Wed, 01 Jun 2011 15:17:10 -0700 (PDT)
In-Reply-To: <20110528013355.GD5971@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Again,
  Sorry to keep on this, but I'm really wedged.  I can't tell if I'm trying
to break new ground, or if I just don't know what I'm doing :-)  Or both
perhaps.

I've got my multi-codec card instantiating (only 4 codecs here for
simplicity -- there are really 8 total)

# insmod tlv320aic3x_se.ko   # <--- my custom version of aic3x driver.
# insmod puppy_machine.ko  # <-- my custom machinne interface with all my
dai-links and all.

# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: tlv320aic33se [tlv320aic33-se], device 0: tlv320aic33-se
tlv320aic3x-se-hifi-0 []
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: tlv320aic33se [tlv320aic33-se], device 1: tlv320aic33-se
tlv320aic3x-se-hifi-1 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: tlv320aic33se [tlv320aic33-se], device 2: tlv320aic33-se
tlv320aic3x-se-hifi-2 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: tlv320aic33se [tlv320aic33-se], device 3: tlv320aic33-se
tlv320aic3x-se-hifi-3 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0


I can run jack on the first subdevice and it actually streams data both ways
on codec 0.

# jackd -d alsa -d hw:0,0
creating alsa driver ...
hw:0,0|hw:0,0|1024|2|48000|0|0|nomon|swmeter|-|32bit
control device hw:0
...


However, I can't seem to get access to any of the other codecs on the TDM
bus.  Remember, there is only a single CPU DAI here (a single McBSP port),
but multiple codec DAIs (one for each codec, in TDM mode).

# jackd -d alsa -d hw:0,0 -i4 -o4   # <--- Does not work.  hw:0,0 is just a
single stereo codec, so it doesn't start up the other DAIs

How do I get jackd (or anything else for that matter), to start all the DAIs
at the same time?

If I try:
# aplay -D hw:0,0 -f S16_LE test.wav    # <--- success

and in another shell:
# aplay -D hw:0,1 -f S16_LE test1.wav  # <--- failure

the second invocation on hw:0,1 fails because hw:0 is already open.

I also tried modifying my asoundrc to something similar to
http://quicktoots.linuxaudio.org/toots/el-cheapo, but that didn't work
either.

I can attach my code and even schematic if that would help.

Thanks again,
  -Caleb
