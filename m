From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/2] ASoC: omap-mcpdm: Replace legacy
 driver
Date: Mon, 22 Aug 2011 15:39:15 +0200
Message-ID: <4E525C03.6090405@metafoo.de>
References: <1313739679-8975-1-git-send-email-peter.ujfalusi@ti.com>
	<4E4E2103.9030208@metafoo.de> <4E4E2384.5000501@metafoo.de>
	<1452269.zSYBkDql26@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id D31F724570
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 15:39:36 +0200 (CEST)
In-Reply-To: <1452269.zSYBkDql26@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Girdwood,
	Liam" <lrg@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On 08/22/2011 01:34 PM, P=E9ter Ujfalusi wrote:
> On Friday 19 August 2011 10:49:08 Lars-Peter Clausen wrote:
>> sorry:
>> struct omap_mcpdm *mcpdm =3D  snd_soc_platform_get_drvdata(w->platform);
>>
>>> This would avoid having to add the private_data field to the widget
>>> struct. In it's current form it will only really work, if there is just
>>> one instance of the driver using the widget. And if that's the case you
>>> can use a global variable directly anyway.
> =

> The other option was to use global variable to get the *mcpdm for the wid=
get.
> Generally I try to avoid global variables as much as I can, since the use=
 of =

> them looks really hackish.

omap_mcpdm_widgets is a global variable. You assign to it in asoc_mcpdm_pro=
be
and read from it in omap_mcpdm_add_dapm_widget. The fact that you hide your
*mcpdm in a void pointer doesn't make it less hackish.
