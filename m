From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH] ARM ASoC: add sound driver for
 imx27pdk using mc13783 codec
Date: Thu, 2 Feb 2012 17:32:12 +0000
Message-ID: <20120202173212.GA1785@sirena.org.uk>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
	<2667396.yifGumf5nD@laptop>
	<CAOMZO5CRmvwCy_qE81PauZ6jmPN7S3N3pky01V0OmWBLCJ5JyA@mail.gmail.com>
	<2851519.TkeCdfD43W@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E5A88103C22
	for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2012 18:32:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2851519.TkeCdfD43W@laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philippe R?tornaz <philippe.retornaz@epfl.ch>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, J?rgen Lambrecht <juergen.lambrecht@gmail.com>, Lambrecht J?rgen <J.Lambrecht@televic.com>, Fabio Estevam <festevam@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 29, 2012 at 08:01:38PM +0100, Philippe R?tornaz wrote:
> Le samedi 28 janvier 2012 18:57:45 Fabio Estevam a ?crit :
> > On Wed, Jan 25, 2012 at 1:45 PM, Philippe R?tornaz

> > > Sascha, do you have any plan to upstream the mc13783 codec driver ?

> > In case Sascha doesn't have plans to upstream mc13783, is this
> > something you could do?

> It's an option, but I cannot work full-time on it so it would not be fast.

First step would be to post it :)

A useful approach might be to strip the driver down to the bare minimum
(for example just getting DAC to headphone working, possibly at a fixed
sample rate) and then build out functionality incrementally.  That would
make it easier for different people to contribute bits they need.
