From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ASoC: mxs: Export symbols
 'mxs_saif_put_mclk()' and 'mxs_saif_get_mclk()'
Date: Sun, 11 Dec 2011 10:55:21 +0800
Message-ID: <20111211025519.GC2800@opensource.wolfsonmicro.com>
References: <cover.1323436034.git.LW@KARO-electronics.de>
	<42d1579aefe3a3025f16fb4e38a4acf6b72756f7.1323436034.git.LW@KARO-electronics.de>
	<20111209141530.GI3327@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 482EE2494A
	for <alsa-devel@alsa-project.org>; Sun, 11 Dec 2011 03:56:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111209141530.GI3327@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Dong Aisheng-B29396 <B29396@freescale.com>, linux-kernel@vger.kernel.org, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 09, 2011 at 03:15:30PM +0100, Wolfram Sang wrote:
> On Fri, Dec 09, 2011 at 02:38:10PM +0100, Lothar Wa=DFmann wrote:

> > +EXPORT_SYMBOL(mxs_saif_put_mclk);

> EXPORT_SYMBOL_GPL. I'd vote this is an implementation issue.

Yes, please - the entire subsystem is exported _GPL.
