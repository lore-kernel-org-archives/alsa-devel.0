From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: OMAP machines: Fix kernel crash due
	to changes in core
Date: Fri, 07 Oct 2011 07:21:32 -0700 (PDT)
Message-ID: <1375918.bhdBV2GSbL@barack>
References: <1317971206-10365-1-git-send-email-peter.ujfalusi@ti.com>
	<4518982.z3cBzfSFpP@barack>
	<20111007134635.GG14518@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog107.obsmtp.com (na3sys009aog107.obsmtp.com
	[74.125.149.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 991DB103BA8
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 16:21:34 +0200 (CEST)
Received: by mail-bw0-f42.google.com with SMTP id c12so1508247bkb.1
	for <alsa-devel@alsa-project.org>; Fri, 07 Oct 2011 07:21:33 -0700 (PDT)
In-Reply-To: <20111007134635.GG14518@opensource.wolfsonmicro.com>
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

On Friday 07 October 2011 14:46:36 Mark Brown wrote:
> > - From the remaining drivers the soc_dapm_sync need to be removed. If
> > they do funky stuff with their widgets we might need to add
> > snd_soc_dapm_new_widgets() for their init call to be sure they are not
> > crashing.
> =

> new_widgets() is orthogonal to the sync(), there is now a stronger
> requirement for it though.

Yes, new_widgets() is instantiating the new widgets + sync()
IMHO it is going to be rare case when machine drivers would need to do this.

> > I have converted some of the OMAP machine drivers according to point 2
> > after this patch. I only changed those which seamed obvious.
> =

> Yeah, I didn't apply all those patches as they depended on this one.

I'll rewrite the series to skip the sync -> new_widgets() step.

--
P=E9ter
