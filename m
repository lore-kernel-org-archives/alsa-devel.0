From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: OMAP machines: Fix kernel crash due
	to changes in core
Date: Fri, 07 Oct 2011 14:12:43 +0300
Message-ID: <1923772.Cd9hLQzlop@barack>
References: <1317971206-10365-1-git-send-email-peter.ujfalusi@ti.com>
	<3419773.iq8RNTCtj0@barack>
	<20111007104800.GH19080@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog108.obsmtp.com (na3sys009aog108.obsmtp.com
	[74.125.149.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 87A9224695
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 13:12:20 +0200 (CEST)
Received: by mail-bw0-f53.google.com with SMTP id zt12so5020190bkb.12
	for <alsa-devel@alsa-project.org>; Fri, 07 Oct 2011 04:12:16 -0700 (PDT)
In-Reply-To: <20111007104800.GH19080@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, =?utf-8?B?R3Jhxb52eWRhcw==?= Ignotas <notasas@gmail.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Friday 07 October 2011 11:48:01 Mark Brown wrote:
> > This might be true for machines, which adds jack functionality. We are
> > now calling snd_soc_dapm_new_widgets before adding jack pins.
> > Also machines passing their DAPM widgets/routes via snd_soc_card are
> > safe from this issue.
> =

> No, it should never be needed by anything.

Could be, but day before yesterday the sdp4430 was fine.
I've pulled yesterday morning, and welcomed me with a kernel crash at boot =

time.
 =

> > For machines, which does not add jacks the snd_soc_dapm_new_widgets will
> > be not called at all, which will eventually leads to a crash.
> > =

> > in soc-core.c: soc_post_component_init() the dai->init called, but
> > there's no additional snd_soc_dapm_new_widgets call to make sure that
> > the new widgets added by the machine driver are instantiated.
> =

> We could either go round every single machine driver in the kernel
> modifying them or we could make sure it's handled in the core - I know
> which of those seems better to me!

For sure fixing this in core is the best place.
Try to boot smartq_wm8987, s3c24xx_simtec_tlv320aic23, s3c24xx_simtec_herme=
s,
jive_wm8750, h1940_uda1380, etc.
Lots of the machine drivers are calling soc_dapm_sync after adding widgets.
They will crash.
If we want to fix this in core we need to remove the soc_dapm_sync from _in=
it
calls, and add the snd_soc_dapm_new_widgets post dai_link->init call in
soc_post_component_init of soc-core.c.

Having the soc_dapm_sync without calling snd_soc_dapm_new_widgets after add=
ing
new widgets will trigger this.

As I said: sdp4430 strated to crash yesterday morning - without any change =
in
the sdp4430 driver.

--
P=E9ter
