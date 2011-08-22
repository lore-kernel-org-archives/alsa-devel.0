From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 2/2] ASoC: omap-mcpdm: Replace legacy
	driver
Date: Mon, 22 Aug 2011 14:34:23 +0300
Message-ID: <1452269.zSYBkDql26@barack>
References: <1313739679-8975-1-git-send-email-peter.ujfalusi@ti.com>
	<4E4E2103.9030208@metafoo.de> <4E4E2384.5000501@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id CE05410386D
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 13:34:18 +0200 (CEST)
In-Reply-To: <4E4E2384.5000501@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Girdwood,
	Liam" <lrg@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Friday 19 August 2011 10:49:08 Lars-Peter Clausen wrote:
> sorry:
> struct omap_mcpdm *mcpdm =3D  snd_soc_platform_get_drvdata(w->platform);
> =

> > This would avoid having to add the private_data field to the widget
> > struct. In it's current form it will only really work, if there is just
> > one instance of the driver using the widget. And if that's the case you
> > can use a global variable directly anyway.

The other option was to use global variable to get the *mcpdm for the widge=
t.
Generally I try to avoid global variables as much as I can, since the use o=
f =

them looks really hackish.
There could be some way to reach the CPU dai via pointers/lookups from the =

widget, but it does looked really ugly, and I was only half way there.

-- =

P=E9ter
