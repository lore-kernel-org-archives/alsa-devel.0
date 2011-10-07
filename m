From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: OMAP machines: Fix kernel crash due
 to changes in core
Date: Fri, 7 Oct 2011 11:48:01 +0100
Message-ID: <20111007104800.GH19080@opensource.wolfsonmicro.com>
References: <1317971206-10365-1-git-send-email-peter.ujfalusi@ti.com>
	<20111007101711.GD19080@opensource.wolfsonmicro.com>
	<3419773.iq8RNTCtj0@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B08A24684
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 12:48:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3419773.iq8RNTCtj0@barack>
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

On Fri, Oct 07, 2011 at 01:40:21PM +0300, P=E9ter Ujfalusi wrote:
> On Friday 07 October 2011 11:17:12 Mark Brown wrote:

> > No, there should be no need for either callback in individual drivers
> > unless they're doing something very specialist.  This will have been the
> > case for a while now.

> This might be true for machines, which adds jack functionality. We are no=
w =

> calling snd_soc_dapm_new_widgets before adding jack pins.
> Also machines passing their DAPM widgets/routes via snd_soc_card are safe=
 from =

> this issue.

No, it should never be needed by anything.

> For machines, which does not add jacks the snd_soc_dapm_new_widgets will =
be =

> not called at all, which will eventually leads to a crash.

> in soc-core.c: soc_post_component_init() the dai->init called, but there'=
s no =

> additional snd_soc_dapm_new_widgets call to make sure that the new widget=
s =

> added by the machine driver are instantiated.

We could either go round every single machine driver in the kernel
modifying them or we could make sure it's handled in the core - I know
which of those seems better to me!
