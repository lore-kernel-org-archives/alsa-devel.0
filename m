From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: Setting invalid samplerate
Date: Thu, 19 May 2011 12:24:53 +0200
Message-ID: <13007c956d1.7109012681098247941.4235053919533621827@zoho.com>
References: <4DD27C43.3050509@canonical.com> <s5hfwod5nz0.wl%tiwai@suse.de>
	<4DD4E909.80108@canonical.com> <s5htycr0zuf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id C4F6E103818
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 12:24:55 +0200 (CEST)
In-Reply-To: <s5htycr0zuf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello all,

I'm working on the driver for the dmx 6fire usb. On my sourceforge page, users have acknowledged that the driver is working fine. I don't know whether the alsa mailing list is the correct one; but since Ubuntu 11.04, I get complaints about the card not working anymore, dmesg says "invalid samplerate 64000 in prepare". I could reproduce the error on my own Ubuntu. I started to wonder why pulseaudio wants to use 64kHz since the card doesn't support it and I also didn't enable the SNDRV_PCM_RATE_64000 flag.

The hardware description is as follows:
	.rates = SNDRV_PCM_RATE_44100 |
		SNDRV_PCM_RATE_48000 |
		SNDRV_PCM_RATE_88200 |
		SNDRV_PCM_RATE_96000 |
		SNDRV_PCM_RATE_176400 |
		SNDRV_PCM_RATE_192000,

	.rate_min = 44100,
	.rate_max = 192000,

I wrote a small test program to see what happens if I try to set a samplerate of 48000. set_rate_near always returned 64kHz. A nasty workaround is to enable just 88.2kHz. But then not all programs run (f.ex. milkytracker refused to playback sound). So what is going on here and what could be done about it?

Thanks,
Torsten
