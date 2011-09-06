From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 2/3] ASoC: soc-dapm: API to attach
	DAPM_SUPPLY to be used for dai
Date: Tue, 06 Sep 2011 13:21:56 +0300
Message-ID: <2352586.fDPvRLFK0h@barack>
References: <1314365603-8947-1-git-send-email-peter.ujfalusi@ti.com>
	<11979330.WnlDKWFkCB@barack> <20110903063119.GB6556@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog125.obsmtp.com (na3sys009aog125.obsmtp.com
	[74.125.149.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CFC02464F
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 12:22:03 +0200 (CEST)
Received: by bkbzs8 with SMTP id zs8so5525118bkb.12
	for <alsa-devel@alsa-project.org>; Tue, 06 Sep 2011 03:21:59 -0700 (PDT)
In-Reply-To: <20110903063119.GB6556@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Saturday 03 September 2011 07:31:19 Mark Brown wrote:
> > The sequence I'm looking for is:
> > 1. pcm_trigger: stop DMA
> > 2. DAPM sequence starts
> > 3. DAC is turned off on the codec side
> > 4. OMAP4 McPDM can be stopped - stop it
> > 5. DAPM finishes up
> > 6. codec can be turned off
> =

> Actually I think this is fine with my suggestion so long as you make the
> CODEC SYSCLK visible to DAPM and have the machine driver turn it off at
> some later point in the shutdown process (eg, in shutdown()).  That way
> the data paths will still be torn down by DAPM immediately but SYSCLK
> will still be generated.

I need to think about this.
Not sure how it will affect our system, if we do not have pmdown_time in th=
e =

future, when we add full ABE support.
As a side note: I have found an issue with my earlier proposal (DAPM_SUPPLY =

attached to the codec's DAC/ADC): I can end up turning off the host side Mc=
PDM =

during audio activity (by muting the outputs/inputs runtime). It has the si=
de =

effect of not recovering :o (also DMA stops, since the dai is stopped)

I'll get back to you on this soon (probably with a patch).

--
P=E9ter
