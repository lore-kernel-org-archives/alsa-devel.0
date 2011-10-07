From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: OMAP machines: Fix kernel crash due
 to changes in core
Date: Fri, 7 Oct 2011 12:47:49 +0100
Message-ID: <20111007114749.GI19080@opensource.wolfsonmicro.com>
References: <1317971206-10365-1-git-send-email-peter.ujfalusi@ti.com>
	<3419773.iq8RNTCtj0@barack>
	<20111007104800.GH19080@opensource.wolfsonmicro.com>
	<1923772.Cd9hLQzlop@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F2127103B55
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 13:47:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1923772.Cd9hLQzlop@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, =?utf-8?Q?Gra=C5=BEvydas?= Ignotas <notasas@gmail.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 07, 2011 at 02:12:43PM +0300, P=E9ter Ujfalusi wrote:
> On Friday 07 October 2011 11:48:01 Mark Brown wrote:

> > > This might be true for machines, which adds jack functionality. We are
> > > now calling snd_soc_dapm_new_widgets before adding jack pins.
> > > Also machines passing their DAPM widgets/routes via snd_soc_card are
> > > safe from this issue.

> > No, it should never be needed by anything.

> Could be, but day before yesterday the sdp4430 was fine.
> I've pulled yesterday morning, and welcomed me with a kernel crash at boo=
t =

> time.

You're missing the point here.  A crash has been introduced but doing
the syncs during startup should have been and should continue to be a
waste of time with no useful impact on the behaviour of the system.

> > > in soc-core.c: soc_post_component_init() the dai->init called, but
> > > there's no additional snd_soc_dapm_new_widgets call to make sure that
> > > the new widgets added by the machine driver are instantiated.

> > We could either go round every single machine driver in the kernel
> > modifying them or we could make sure it's handled in the core - I know
> > which of those seems better to me!

> For sure fixing this in core is the best place.
> Try to boot smartq_wm8987, s3c24xx_simtec_tlv320aic23, s3c24xx_simtec_her=
mes,
> jive_wm8750, h1940_uda1380, etc.
> Lots of the machine drivers are calling soc_dapm_sync after adding widget=
s.
> They will crash.
> If we want to fix this in core we need to remove the soc_dapm_sync from _=
init
> calls, and add the snd_soc_dapm_new_widgets post dai_link->init call in
> soc_post_component_init of soc-core.c.

Removing the calls is a totally sensible thing to do, like I say they
should at best be a waste of time.  The problem with your patch was that
weren't just removing them, you were replacing them with calls to
new_widgets() which should be equally pointless.  If we have to do that
we're clearly failing at something.
