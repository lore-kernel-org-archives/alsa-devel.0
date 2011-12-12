From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] Export symbols 'mxs_saif_put_mclk()' and
 'mxs_saif_get_mclk()'
Date: Mon, 12 Dec 2011 18:09:56 +0800
Message-ID: <20111212100954.GD31568@opensource.wolfsonmicro.com>
References: <1323683044-11694-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1323683044-11694-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: alsa-devel@alsa-project.org, Dong Aisheng-B29396 <B29396@freescale.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 12, 2011 at 10:44:04AM +0100, Lothar Wa=DFmann wrote:
> Fixes the following errors with MXS sound support built as module:
> |ERROR: "mxs_saif_put_mclk" [sound/soc/mxs/snd-soc-mxs-sgtl5000.ko] u=
ndefined!
> |ERROR: "mxs_saif_get_mclk" [sound/soc/mxs/snd-soc-mxs-sgtl5000.ko] u=
ndefined!
>=20
> Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>

This looks fine but doesn't seem to apply easily to anything immediatel=
y
- can you rebase against current code please?
