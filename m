From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/3] ASoC: TWL4030: Add AVADC Clock Priority
Date: Mon, 22 Jun 2009 09:36:44 +0300
Message-ID: <200906220936.44711.peter.ujfalusi@nokia.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E3543F31D@dlee04.ent.ti.com>
	<20090619100016.GE5270@sirena.org.uk>
	<67059DBF19D7214F9C66BB0EA91BA90E3543F5CE@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id F01A42456A
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Jun 2009 08:36:48 +0200 (CEST)
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E3543F5CE@dlee04.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Friday 19 June 2009 20:57:39 ext Lopez Cruz, Misael wrote:
> > > +/* AVADC clock priority */
> > > +static const char *twl4030_avadc_clk_priority_texts[] =3D {
> > > +	"Voice high priority", "Audio high priority"
> > > +};
> > > +
> >
> > It'd probably be better to say "Hifi" (or whatever spelling
> > the rest of the driver uses) rather than "Audio" here.  Audio
> > is a bit confusing since obviously the voice data is audio
> > data too, it's just a different path through the CODEC with
> > different characteristics.  The same thing has been done
> > elsewhere in the driver.
>
> Agree, "HiFi" is being used in codec DAI definition so I'll
> use that too.
>
> I'll wait for Peter's comments before resending the patch.

Please change the Audio to HiFi, otherwise it is OK.

>
> Thanks,
> Misa

-- =

P=E9ter
