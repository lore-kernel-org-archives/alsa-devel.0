From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt5645: add "coreboot" to
	dmi_system_id list
Date: Wed, 3 Feb 2016 02:37:08 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D70110F96C@RTITMBSV03.realtek.com.tw>
References: <1454304078-12322-1-git-send-email-bardliao@realtek.com>
 <20160202194936.GB4455@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 290F72605FF
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 03:37:17 +0100 (CET)
In-Reply-To: <20160202194936.GB4455@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "Koul,
 Vinod (vinod.koul@intel.com)" <vinod.koul@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "rakesh.a.ughreja@intel.com" <rakesh.a.ughreja@intel.com>, Flove <flove@realtek.com>, "Bossart, Pierre-louis
 (pierre-louis.bossart@intel.com)" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Add some Intel folks.

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, February 03, 2016 3:50 AM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org;
> lars@metafoo.de; Flove; Oder Chiou; John Lin
> Subject: Re: [PATCH] ASoC: rt5645: add "coreboot" to dmi_system_id list
> 
> On Mon, Feb 01, 2016 at 01:21:18PM +0800, Bard Liao wrote:
> 
> > +	{
> > +		.ident = "Google Chrome",
> > +		.matches = {
> > +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> > +		},
> > +	},
> 
> While coreboot is most commonly seen in ChromeOS systems it's not
> unique to them so this seems likely to generate false positives.  Since

So far, almost all ChromeOS system with rt5650 codec have the same
properties. We think the settings can be a default setting for rt5650
codec. That's why we use DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE")
and place it in the lowest priority currently. Adding "coreboot" is for
those ChromeOS system other than with DMI_SYS_VENDOR "GOOGLE".

> the target for this change is internal-only development hardware it
> doesn't seem unreasonable to expect people to be able to keep changes
> like device ID updates internally.  This is one of the many costs of BIOSes
> that require us to do such DMI hacks, it'd be much better to improve the
> firmware and the driver so they can specify required properties directly
> rather than relying on DMI.

Agree. We will find a more reasonable way (maybe ACPI) to specify
required properties directly. However, I can expect that will take time.
If you think use "coreboot" is not a good idea, can we match the
DMI_PRODUCT_NAME field just like before until we finish the
implementation of specifying required properties directly?


> 
> ------Please consider the environment before printing this e-mail.
