From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add SoundCard driver for OKI SEMICONDUCTOR ML7213 IOH
Date: Sat, 9 Jul 2011 02:34:41 +0100
Message-ID: <20110709013441.GB25165@sirena.org.uk>
References: <1309948067-9333-1-git-send-email-toshiharu-linux@dsn.okisemi.com> <s5hhb6z3byw.wl%tiwai@suse.de> <34CF59A8D33E40B6822498A23CD554E8@hacdom.okisemi.com> <s5hvcve1n40.wl%tiwai@suse.de> <A103B14DCBE64935815497A3464F512F@hacdom.okisemi.com> <s5h8vsa11x2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h8vsa11x2.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Toshiharu Okada <toshiharu-linux@dsn.okisemi.com>, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com, tomoya-linux@dsn.okisemi.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 07, 2011 at 06:38:33PM +0200, Takashi Iwai wrote:

> It's not clear what you mean exactly as "unfixed", but in general, the
> decision rather depends on the usage of the device.  If it's designed
> for a use as a desktop PC component (such as a PCI card or
> onboard-audio on PC), it'd make sense to implement as a stand-alone,
> self-contained driver.

> OTOH, if it's targeted mainly for embedded area, ASoC is the right
> answer.  It's more modularized, and can be more flexibly configured in
> the end.

I'd say it depends rather more on the physical system design.  If there
are a bunch of separate chips which are interacted with separately by
software then ASoC makes sense, if the card is one logical object to
hardware a vanilla ALSA driver probably does.
