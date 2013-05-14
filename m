From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: remove saarb and tavorevb3 machine drivers
Date: Tue, 14 May 2013 22:23:37 +0200
Message-ID: <2843869.zn4rrxyCrZ@wuerfel>
References: <1368544041.1350.111.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368544041.1350.111.camel@x61.thuisdomein>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Paul Bolle <pebolle@tiscali.nl>, Eric Miao <eric.y.miao@gmail.com>, Russell King <linux@arm.linux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 14 May 2013 17:07:21 Paul Bolle wrote:
> Support for PXA95x was removed in v3.8. This means that the Kconfig
> symbols MACH_SAARB and MACH_TAVOREVB3 are no longer available. This
> leaves the SoC Audio support for Marvell Saarb and Marvell Tavor EVB3
> unbuildable. Remove these drivers too.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Acked-by: Arnd Bergmann <arnd@arndb.de>
