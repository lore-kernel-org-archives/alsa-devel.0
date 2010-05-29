From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Problem with snd_hda_intel from 05-27-2010 snapshot
Date: Sat, 29 May 2010 08:25:11 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005290822040.6856@eeebox2.perex-int.cz>
References: <AANLkTilIX_UnMYcg8LAqkndS80nFppblW6erTm2e7o5X@mail.gmail.com>
	<AANLkTinLbTMrYBhg6KO826slsugfEcU0_wYqukSQpQw2@mail.gmail.com>
	<alpine.LNX.2.00.1005270931570.6856@eeebox2.perex-int.cz>
	<AANLkTinvfYyOHzQrEfcBrDvDMW3Fc93oYrUHOcABm0Oa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A48E62452D
	for <alsa-devel@alsa-project.org>;
	Sat, 29 May 2010 08:25:12 +0200 (CEST)
In-Reply-To: <AANLkTinvfYyOHzQrEfcBrDvDMW3Fc93oYrUHOcABm0Oa@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: VDR User <user.vdr@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 27 May 2010, VDR User wrote:

> On Thu, May 27, 2010 at 12:37 AM, Jaroslav Kysela <perex@perex.cz> wrote:
>> Check any suspicious lines in /var/log/messages and follow proc xrun_debug
>> settings noted in bug above. I need at least 20 first lines after the
>> playback is started.
>
> By this do you mean compile the drivers with pcm-xrun-debug
> --with-debug=verbose --enable-verbose-procfs options?  Also, is there
> a way to disable all the debug logging in maybe
> /etc/modprobe.d/alsa-base.conf?  My system is installed on a CF and I
> can't have alsa hammering it with writes is they're not needed but the
> only way I know to turn the debug logging off is to not compile it in
> the first place.

I asked for one run, so you can recompile ALSA driver without debugging 
support after test. I think that the problem might be that the WALLCLK 
register gives wrong values for your hardware (but the Intel specification 
says that implementation of this register is MANDATORY).

Here is a patch which might show the bug:

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 170610e..a1e7c97 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1891,6 +1891,7 @@ static int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
  	int stream;

  	wallclk = azx_readl(chip, WALLCLK) - azx_dev->start_wallclk;
+	printk("wallclk: %u, %u\n", wallclk, azx_readl(chip, WALLCLK));
  	if (wallclk < (azx_dev->period_wallclk * 2) / 3)
  		return -1;	/* bogus (too early) interrupt */


>> Also, use 'aplay -Dplughw:0' from the alsa-utils package to trigger the
>> playback.
>
> The hdmi device I'm using is 1,3:
>
> test:~$ aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: NVidia [HDA NVidia], device 0: ALC883 Analog [ALC883 Analog]
>  Subdevices: 1/1
>  Subdevice #0: subdevice #0
> card 0: NVidia [HDA NVidia], device 1: ALC883 Digital [ALC883 Digital]
>  Subdevices: 1/1
>  Subdevice #0: subdevice #0
> card 1: NVidia_1 [HDA NVidia], device 3: NVIDIA HDMI [NVIDIA HDMI]
>  Subdevices: 0/1
>  Subdevice #0: subdevice #0
>
> So what exactly do I need to do then with aplay?  Do I need some file
> to play?  Sorry, I've never used Linux as a desktop so I'm only
> familiar with running VDR from command line.

If you use HDMI device, use 'aplay plughw:1,0 <some_wav_file>'. 
Some_wav_file means a .wav type audio file.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
