From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: remove explicit register defaults
Date: Mon, 1 Feb 2016 19:34:15 -0200
Message-ID: <CAOMZO5Bsy8DLNBKR77JFcihrrZp5mxN6BOJmte5uCXkwOfbzcg@mail.gmail.com>
References: <569D3800.2040801@maciej.szmigiero.name>
	<CAOMZO5DwQza+jDdkA80v4wkrB56y53tOjkP2-36YNq2WBLodaA@mail.gmail.com>
	<56AF4A9F.4060401@maciej.szmigiero.name>
	<CAOMZO5DK86JCs_KivZ5MMFKsiP6aVpopG-zgXPE-+_GWjQNuMw@mail.gmail.com>
	<56AF4ED0.7030801@maciej.szmigiero.name>
	<56AF8E9E.5000100@maciej.szmigiero.name>
	<20160201211017.GG4455@sirena.org.uk>
	<56AFCE8D.70804@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56AFCE8D.70804@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 1, 2016 at 7:30 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:

> So can regcache initialization be changed to use register by register read
> in case raw read fails?
>
> Since other option for drivers like SSI which are memory mapped and
> don't offer ability to reset their register values to default would be to
> explicitly write driver hardcoded defaults also by doing
> register by register write on probe time.

Yes, I had to do the same for sgtl5000:
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/sound/soc/codecs/sgtl5000.c?id=af8ee11209e749c75eabf32b2a4ca631f396acf8

Would this approach work here too?
