From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 - resend 10/13] ASoC: omap-abe-twl6040: Configure card
 according to platform data
Date: Wed, 25 Jan 2012 10:23:01 +0200
Message-ID: <4F1FBBE5.5080804@ti.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com> <1327405950-6676-11-git-send-email-peter.ujfalusi@ti.com> <20120124130008.GC31839@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120124130008.GC31839@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 01/24/2012 03:00 PM, Mark Brown wrote:
> On Tue, Jan 24, 2012 at 01:52:27PM +0200, Peter Ujfalusi wrote:
>> Disable the not connected pins on the board based on the
>> received platform data.
>> DO not register the jack function on boards, which does not have
>> means to detect it (jack is always connected).
>=20
> This should no longer be needed with the auto not connected stuff.

The auto not connected checks if we have connected something in the car=
d
domain to the codec's input/output/micbias widgets.
In the machine driver we start from fully wired configuration, and base=
d
on the received platform data we mark certain connections not connected=
=2E
The audio nc feature would not work here. It will not mark anything nc
since the DAPM map is complete.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
