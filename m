From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH] ARM ASoC: add sound driver for
 imx27pdk using mc13783 codec
Date: Mon, 11 Jul 2011 20:44:56 +0900
Message-ID: <20110711114452.GK5092@opensource.wolfsonmicro.com>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
	<20110709022501.GA26900@sirena.org.uk>
	<4E1AD0DC.7020201@televic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 59BE924344
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 13:45:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E1AD0DC.7020201@televic.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lambrecht =?iso-8859-1?Q?J=FCrgen?= <J.Lambrecht@TELEVIC.com>
Cc: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 11, 2011 at 12:30:52PM +0200, Lambrecht J=FCrgen wrote:

> But actually, I have my doubts. Is it possible to reuse such a platform =

> driver?
> I don't know the other platforms, maybe they differ a little bit?

Yes, of course.  Use platform data or key off something like
machine_is_() to handle small differences between systems in the same
way as for any other driver.  There's a few examples of this in the
tree.
