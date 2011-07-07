From: "Toshiharu Okada" <toshiharu-linux@dsn.okisemi.com>
Subject: Re: [PATCH] Add SoundCard driver for OKI SEMICONDUCTOR ML7213 IOH
Date: Thu, 7 Jul 2011 16:54:18 +0900
Message-ID: <34CF59A8D33E40B6822498A23CD554E8@hacdom.okisemi.com>
References: <1309948067-9333-1-git-send-email-toshiharu-linux@dsn.okisemi.com> <s5hhb6z3byw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: tomoya-linux@dsn.okisemi.com, kok.howg.ewe@intel.com, joel.clark@intel.com, yong.y.wang@intel.com, qi.wang@intel.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

Date: Wed, 06 Jul 2011 13:06:15 +0200
From: Takashi Iwai <tiwai@suse.de>
>
>I just took a quick glance over the code, and wonder whether this kind
>of driver would fit better with ASoC framework.
>Have you considered the implementation on ASoC?

Thank you for your comment.

I referred to the following files and implemented this driver.

http://www.mirrorservice.org/sites/ftp.sourceforge.net/pub/sourceforge/s/project/st/sta2x11/2.6.33/20100910/20100910-alpha-src.zip
sound/drivers/sta2x11i2s.c

Therefore, I am not considering about ASoC.
Do I need to fit this driver to an ASoC framework for an upstream?

Best Regards,
Toshiharu Okada 
