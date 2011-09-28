From: Abdelghani Ouchabane <abdelghani@ezono.com>
Subject: Re: "modprobe snd_hda_intel" crashes on my hardware
Date: Wed, 28 Sep 2011 09:10:43 +0200
Message-ID: <4E82C873.9030504@ezono.com>
References: <4E817010.7030607@ezono.com> <4E81CD2E.2010009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ezo.ezono.com (ezo.ezono.com [50.22.105.208])
	by alsa0.perex.cz (Postfix) with ESMTP id 1281724538
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 11:10:49 +0200 (CEST)
In-Reply-To: <4E81CD2E.2010009@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> Anyway, you could just override the pin configs with a HDA patch file.
> Ensure that your kernel is compiled with CONFIG_SND_HDA_PATCH_LOADER;
> then create a file /lib/firmware/forgotten-ezono-hda-settings with the
> following contents:
>
> [codec]
> 0x11061708 0xffffffff 2
> [pincfg]
> 0x1c 0x0000f000
> 0x1d 0x00a0f040
> 0x1f 0x0100f010
> 0x20 0x0020f000
> 0x22 0x0000f002
> 0x23 0x0000f004
>
> Then load the snd-hda-intel driver with the parameter
> "patch=forgotten-ezono-hda-settings", either by adding that
> parameter to the modprobe command line, or by putting the line
>
>   options snd-hda-intel patch=forgotten-ezono-hda-settings
>
> into a .conf file in /etc/modprobe.d/.
>   
Hi Clemens ,

I tested your solution and here is the result:

1 - Keep my changes in sound/pci/hda/patch_via.c + your solution ----> 
The kernel did not crash + alsamixer showed the full interface, but the 
there was no sound, after rebooting the system, I had sound.

2 - Only your solution ----> The kernel crashed ( always ).

Maybe I am still missing some more settings in 
/lib/firmware/forgotten-ezono-hda-settings?

What do you think Clemens?
