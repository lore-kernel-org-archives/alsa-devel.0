From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt5645: Add dmi_system_id "Google
	Terra"
Date: Thu, 26 Nov 2015 09:19:08 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7010D374E@RTITMBSV03.realtek.com.tw>
References: <1448333729-11065-1-git-send-email-bardliao@realtek.com>
 <20151125120139.GP1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D3D522665A1
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 10:19:16 +0100 (CET)
In-Reply-To: <20151125120139.GP1929@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "Luke_Yin@asus.com" <Luke_Yin@asus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, November 25, 2015 8:02 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; lars@metafoo.de;
> Flove; Oder Chiou; John Lin; Luke_Yin@asus.com
> Subject: Re: [PATCH] ASoC: rt5645: Add dmi_system_id "Google Terra"
> 
> On Tue, Nov 24, 2015 at 10:55:29AM +0800, Bard Liao wrote:
> 
> > +	{
> > +		.ident = "Google Terra",
> > +		.callback = strago_quirk_cb,
> > +		.matches = {
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Terra"),
> > +		},
> > +	},
> 
> It might make more sense to just have a single entry for all these Google
> platforms and extend this table rather than adding a complete new entry
> for every platform - they're all the same and it'd make the table smaller.

Totally agree. We are trying to simplify the code. The idea is using
DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE") for all google project
except a few projects with different HW design. We will use if else
statement to match the projects with special HW design first and the
general ones. Also, I think those can support DT/ACPI should have higher
priority than DMI match, right?

> 
> ------Please consider the environment before printing this e-mail.
