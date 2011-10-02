From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] ASoC: codecs/wm8682: use __devexit_p
Date: Sun, 2 Oct 2011 21:36:13 +0100
Message-ID: <20111002203613.GA5811@opensource.wolfsonmicro.com>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
 <1317587284-2776-2-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1317587284-2776-2-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Lartey <ian@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 02, 2011 at 10:27:59PM +0200, Arnd Bergmann wrote:
> This fixes a build error when CONFIG_HOTPLUG is disabled.

Axel Lin sent a patch for this recently, it's already been merged.

>  sound/soc/codecs/wm8782.c |    2 +-

Your subject line doesn't match the file you're changing.
