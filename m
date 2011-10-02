From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/6] ASoC: samsung: fix Kconfig dependencies
Date: Sun, 2 Oct 2011 22:29:59 +0100
Message-ID: <20111002212958.GD4506@opensource.wolfsonmicro.com>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
 <1317587284-2776-6-git-send-email-arnd@arndb.de>
 <20111002204729.GC5811@opensource.wolfsonmicro.com>
 <3289863.m6ULFZUV3p@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3289863.m6ULFZUV3p@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 02, 2011 at 11:14:55PM +0200, Arnd Bergmann wrote:

> So should SND_SOC_WM8994 instead select MFD_WM8994? That would mean adding
> the select only in one place.

select ignores the dependencies of the things it selects which isn't
enormously helpful for this sort of stuff.
