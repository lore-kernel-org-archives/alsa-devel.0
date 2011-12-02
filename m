From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
Date: Fri, 02 Dec 2011 14:32:59 +0200
Message-ID: <4ED8C57B.2000503@ti.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com> <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com> <20111202122558.GM8245@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20111202122558.GM8245@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 12/02/2011 02:25 PM, Mark Brown wrote:
> On Fri, Dec 02, 2011 at 11:52:56AM +0200, Peter Ujfalusi wrote:
>=20
>> +Required properties:
>> +  - compatible : "ti,omap4-dmic"
>> +  - ti,hwmods  : List of hwmod names associated with DMIC, in most =
case
>> +		 it is "dmic".
>=20
> Shouldn't there also be a regs property giving the register window?

As of now we receive all these information via OMAP hwmod.
All the properties (addresses, irq, etc) of the HW IP will be coming
from DT as soon as I can remove the ti,hwmod property.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
