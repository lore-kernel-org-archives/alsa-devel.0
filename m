From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/2] ASoC: omap-mcpdm: Replace legacy
 driver
Date: Mon, 22 Aug 2011 14:04:28 +0100
Message-ID: <20110822130427.GE9232@opensource.wolfsonmicro.com>
References: <1313739679-8975-1-git-send-email-peter.ujfalusi@ti.com>
	<4E4E2103.9030208@metafoo.de> <4E4E2384.5000501@metafoo.de>
	<1452269.zSYBkDql26@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4585024535
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 15:04:29 +0200 (CEST)
Content-Disposition: inline
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
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "Girdwood,
	Liam" <lrg@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 22, 2011 at 02:34:23PM +0300, P=E9ter Ujfalusi wrote:
> On Friday 19 August 2011 10:49:08 Lars-Peter Clausen wrote:
> > sorry:
> > struct omap_mcpdm *mcpdm =3D  snd_soc_platform_get_drvdata(w->platform);

> > > This would avoid having to add the private_data field to the widget
> > > struct. In it's current form it will only really work, if there is ju=
st
> > > one instance of the driver using the widget. And if that's the case y=
ou
> > > can use a global variable directly anyway.

> The other option was to use global variable to get the *mcpdm for the wid=
get.
> Generally I try to avoid global variables as much as I can, since the use=
 of =

> them looks really hackish.
> There could be some way to reach the CPU dai via pointers/lookups from th=
e =

> widget, but it does looked really ugly, and I was only half way there.

The widget will have a DAPM context associated with it, should we
perhaps add this facility to the DAPM context where it'd then work for
everything?  If we're getting fancy the context could look up the CODEC
context rather than use a local one if it's for a CODEC.
