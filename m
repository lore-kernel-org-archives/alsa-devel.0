From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: OMAP machines: Fix kernel crash due
	to changes in core
Date: Fri, 07 Oct 2011 13:40:21 +0300
Message-ID: <3419773.iq8RNTCtj0@barack>
References: <1317971206-10365-1-git-send-email-peter.ujfalusi@ti.com>
	<20111007101711.GD19080@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 66A5724582
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 12:39:56 +0200 (CEST)
Received: by mail-bw0-f50.google.com with SMTP id zt19so5368509bkb.23
	for <alsa-devel@alsa-project.org>; Fri, 07 Oct 2011 03:39:54 -0700 (PDT)
In-Reply-To: <20111007101711.GD19080@opensource.wolfsonmicro.com>
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

On Friday 07 October 2011 11:17:12 Mark Brown wrote:
> On Fri, Oct 07, 2011 at 10:06:46AM +0300, Peter Ujfalusi wrote:
> > Calling soc_dapm_sync() after adding DAPM widgets/routes
> > will lead to kernel crash caused by unitialized
> > widget->power_check callback (NULL pointer dereference).
> > =

> > Call snd_soc_dapm_new_widgets(dapm); instead of soc_dapm_sync
> > which will initialize the widgets, and will call the
> > dapm_power_widgets (soc_dapm_sync is a wrapper for
> > dapm_power_widgets).
> =

> No, there should be no need for either callback in individual drivers
> unless they're doing something very specialist.  This will have been the
> case for a while now.

This might be true for machines, which adds jack functionality. We are now =

calling snd_soc_dapm_new_widgets before adding jack pins.
Also machines passing their DAPM widgets/routes via snd_soc_card are safe f=
rom =

this issue.

For machines, which does not add jacks the snd_soc_dapm_new_widgets will be =

not called at all, which will eventually leads to a crash.

in soc-core.c: soc_post_component_init() the dai->init called, but there's =
no =

additional snd_soc_dapm_new_widgets call to make sure that the new widgets =

added by the machine driver are instantiated.

--
P=E9ter
