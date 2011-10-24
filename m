From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add SoundCard driver for OKI SEMICONDUCTOR
	ML7213 IOH
Date: Mon, 24 Oct 2011 14:20:15 +0200
Message-ID: <20111024122015.GA26033@opensource.wolfsonmicro.com>
References: <70D251FDDC55405882A8447CC455D56E@hacdom.okisemi.com>
	<8486F61FC3B94B908BFE654234DD6C97@hacdom.okisemi.com>
	<4E9BAEF7.1080406@dsn.lapis-semi.com>
	<s5h7h3ysa4l.wl%tiwai@suse.de> <4EA5563A.10703@dsn.lapis-semi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A6E4324558
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Oct 2011 14:20:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4EA5563A.10703@dsn.lapis-semi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>
Cc: alsa-devel@alsa-project.org, "Wang, Qi" <qi.wang@intel.com>, Takashi Iwai <tiwai@suse.de>, "Wang,
	Yong Y" <yong.y.wang@intel.com>, linux-kernel@vger.kernel.org, "Ewe, Kok Howg" <kok.howg.ewe@intel.com>, Liam Girdwood <lrg@ti.com>, "Clark, Joel" <joel.clark@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 24, 2011 at 09:12:42PM +0900, Tomoya MORINAGA wrote:

> 1. PCI interface function.
> Any current ASoC drivers don't have PCI interface function.
> So I don't know where the function should be in machine driver or
> platform driver.

It depends on what the driver is for.  Probably you want a driver which
is some combination of machine driver and the various drivers that are
normally part of the SoC - whatever roles in the system are filled by
this hardware the driver ought to register subsystem drivers for those
roles.

> 2. Register Access
> Can platform driver access register ?
> According to the soc document, platform driver must not access hardware,
> however, some drivers looks accessing their hardware.

What makes you say this?  A driver that can't access hardware would be
rather useless...
