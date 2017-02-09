From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/3] ASoC: zx-i2s: introduce pclk for
	zx2967 family
Date: Thu, 9 Feb 2017 12:06:25 +0000
Message-ID: <20170209120625.lhqcistgyjpy3plq@sirena.org.uk>
References: <1486522955-14528-1-git-send-email-baoyou.xie@linaro.org>
 <1486522955-14528-2-git-send-email-baoyou.xie@linaro.org>
 <20170209005207.y6wcrzk43ngfslhl@rob-hp-laptop>
 <20170209014807.GO3407@dragon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5382407215857446295=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DD29E26680F
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 13:07:27 +0100 (CET)
In-Reply-To: <20170209014807.GO3407@dragon>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: mark.rutland@arm.com, Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, mathieu.poirier@linaro.org, devicetree@vger.kernel.org, vinod.koul@intel.com, linux-kernel@vger.kernel.org, mturquette@baylibre.com, tiwai@suse.com, sboyd@codeaurora.org, lgirdwood@gmail.com, chen.chaokai@zte.com.cn, xie.baoyou@zte.com.cn, wang.qiang01@zte.com.cn, jun.nie@linaro.org, Baoyou Xie <baoyou.xie@linaro.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5382407215857446295==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l2smyxk6aht5vgdo"
Content-Disposition: inline


--l2smyxk6aht5vgdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 09:48:09AM +0800, Shawn Guo wrote:
> On Wed, Feb 08, 2017 at 06:52:07PM -0600, Rob Herring wrote:

> > Personally, I'd prefer "dt-bindings: sound: blah...", but not enough to=
=20
> > argue with Mark about it. If that is not the prefix, then it should at=
=20
> > least have "binding" in the subject.

> +1

> The prefix of sound bindings is quite unique from other subsystems.
> Looking at the prefix of Documentation/devicetree/bindings/sound/
> commits, I'm always confused whether it's a pure binding commit
> or just submitted as part of the driver patch.  I feel that we
> kinda lose the point of having a prefix.

That's really not what's happening reliably - other subsystems also seem
to have a bunch of things prefixed for the subsystem and the DT specific
prefixes are all over the shop, people seem to be making them up at
random.  If DT binding review were something that reliably and
consistently happened and didn't affect the subsystem I'd perhaps buy it
but for run of the mill stuff it seems like getting things reviewed in
the subsystem is more important.

--l2smyxk6aht5vgdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlicW0AACgkQJNaLcl1U
h9CKUwf/eenRtWOUgLcSz5PgdgRE/tMDYOn9I9BKP3Nk7UCWpJKA2W/LE5lgLfow
SvQsLunCt49zniDpfmtwIsFedDTfPNjg1P6FZf+/1WrbFBTP4vRP7vve55ERrC+l
lFpmn9MaPnVRleZqBgG3qEbpoacyxG63VNZNRYnNcn6LT4P8YgaHUmQHOAfjtNXC
d50aaW2fofXFAWByjaErj7jT2zfVsX4xXy/aBYi4yGd2ILhqfsYsOhC1uJcBdoHh
xMu+jLHhqZRHQdg62ShazpRifrVI9mL0j0HyUvviAULGu1agA7o1e6Q/vEsFsMlY
mlDOb6ZOiKRbaGBC7bwA4sta3NaV9A==
=vk02
-----END PGP SIGNATURE-----

--l2smyxk6aht5vgdo--

--===============5382407215857446295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5382407215857446295==--
