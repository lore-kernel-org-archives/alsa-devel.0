From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/6] ASoC: samsung: fix Kconfig dependencies
Date: Sun, 2 Oct 2011 21:47:30 +0100
Message-ID: <20111002204729.GC5811@opensource.wolfsonmicro.com>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1317587284-2776-6-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A70722434B
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 22:47:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317587284-2776-6-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 02, 2011 at 10:28:03PM +0200, Arnd Bergmann wrote:

>  config SND_SAMSUNG_AC97
>  	tristate
> +	depends on SND_SOC_ALL_CODECS=n || SND_SOC_ALL_CODECS
>  	select SND_SOC_AC97_BUS

No, I'm not sure what the problem you're trying to fix here but this
looks pretty terrible.  SND_SOC_ALL_CODECS is a debugging tool for build
coverage, we shouldn't be restricting actual useful drivers based on it.
What is the intention of this change and why does it only apply to the
Samsung platform?  It all looks very magic.

>  config SND_SOC_SAMSUNG_SMDK_WM8994
>  	tristate "SoC I2S Audio support for WM8994 on SMDK"
>  	depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210)
> +	depends on MFD_WM8994
>  	select SND_SOC_WM8994

This is non-idiomatic - we always select the CODEC drivers rather than
depending on them for usability.

Please also split the two changes you're doing here into separate
patches.  I might've applied the wm8994 bit but it's squashed in with
the AC'97 change...
