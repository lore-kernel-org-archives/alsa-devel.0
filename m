From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: mxs: General cleanups
Date: Sun, 11 Dec 2011 11:03:18 +0800
Message-ID: <20111211030316.GG2800@opensource.wolfsonmicro.com>
References: <cover.1323436034.git.LW@KARO-electronics.de>
	<992d017bd0214a67a836f2d0279b4edb6913da28.1323436034.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 30E8624964
	for <alsa-devel@alsa-project.org>; Sun, 11 Dec 2011 04:04:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <992d017bd0214a67a836f2d0279b4edb6913da28.1323436034.git.LW@KARO-electronics.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: alsa-devel@alsa-project.org, Dong Aisheng-B29396 <B29396@freescale.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 09, 2011 at 02:38:08PM +0100, Lothar Wa=DFmann wrote:
> Some textual cleanups without functional changes
> =

> Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>
> ---
>  sound/soc/codecs/sgtl5000.c |   13 ++++++-------
>  sound/soc/mxs/mxs-saif.c    |    2 +-

This is mostly a patch to a CODEC driver not anything to do with mxs as
the subject says and =


>  static const struct i2c_device_id sgtl5000_id[] =3D {
>  	{"sgtl5000", 0},
> -	{},
> +	{ /* sentinel */ }

I'm not sure I actually find that an improvement; if we're going to
actively go out and do that we should do it consistently.
