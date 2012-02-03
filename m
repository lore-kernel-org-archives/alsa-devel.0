From: Philippe =?ISO-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Subject: Re: [RFC PATCH] ARM ASoC: add sound driver for
	imx27pdk using mc13783 codec
Date: Fri, 03 Feb 2012 08:45:10 +0100
Message-ID: <1635894.OLo8mNMWim@laptop>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
	<2851519.TkeCdfD43W@laptop> <20120202173212.GA1785@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp0.epfl.ch (smtp0.epfl.ch [128.178.224.219])
	by alsa0.perex.cz (Postfix) with SMTP id B161624474
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 08:45:15 +0100 (CET)
In-Reply-To: <20120202173212.GA1785@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, J?rgen Lambrecht <juergen.lambrecht@gmail.com>, Lambrecht J?rgen <J.Lambrecht@televic.com>, Fabio Estevam <festevam@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Le jeudi 2 f=E9vrier 2012 17:32:12 Mark Brown a =E9crit :
> On Sun, Jan 29, 2012 at 08:01:38PM +0100, Philippe R?tornaz wrote:
> > Le samedi 28 janvier 2012 18:57:45 Fabio Estevam a ?crit :
> > > On Wed, Jan 25, 2012 at 1:45 PM, Philippe R?tornaz
> > > =

> > > > Sascha, do you have any plan to upstream the mc13783 codec
> > > > driver ?
> > > =

> > > In case Sascha doesn't have plans to upstream mc13783, is this
> > > something you could do?
> > =

> > It's an option, but I cannot work full-time on it so it would not be
> > fast.
> First step would be to post it :)
> =

> A useful approach might be to strip the driver down to the bare minimum
> (for example just getting DAC to headphone working, possibly at a fixed
> sample rate) and then build out functionality incrementally.  That would
> make it easier for different people to contribute bits they need.

Well, that was the whole point to post a link to a git tree containing the =

patches. But if you think I should post the patches directly on the mailing =

list I can do it.

But before investing too much time on it I would really like to have Sascha =

opinion about it as he is the main author of the mc13783 codec code.

Thanks,

Philippe
