From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add support for multi register mux
Date: Mon, 31 Mar 2014 13:07:48 +0100
Message-ID: <20140331120748.GS2269@sirena.org.uk>
References: <1395792156-4178-1-git-send-email-aruns@nvidia.com>
 <53332CC7.6060800@metafoo.de>
 <D6C615D3E4730340AE82D5BD856631C0A26CB319B2@HQMAIL02.nvidia.com>
 <5333ED3A.7040908@metafoo.de>
 <5571431004A69147BCABABE4E097D66BA3EFF70CFC@HQMAIL02.nvidia.com>
 <D6C615D3E4730340AE82D5BD856631C0A26CB31F48@HQMAIL02.nvidia.com>
 <5336A619.5030007@metafoo.de>
 <781A12BB53C15A4BB37291FDE08C03F3A05CC6A11A@HQMAIL02.nvidia.com>
 <20140331112140.GO2269@sirena.org.uk> <533957C8.2030105@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6395826108704427588=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BE26264F06
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 14:08:08 +0200 (CEST)
In-Reply-To: <533957C8.2030105@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Songhee Baek <sbaek@nvidia.com>, Arun Shamanna Lakshmi <aruns@nvidia.com>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, "'swarren@wwwdotorg.org'" <swarren@wwwdotorg.org>, "'tiwai@suse.de'" <tiwai@suse.de>, "'lgirdwood@gmail.com'" <lgirdwood@gmail.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============6395826108704427588==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5UN41tlPsqEEbq75"
Content-Disposition: inline


--5UN41tlPsqEEbq75
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 31, 2014 at 01:55:52PM +0200, Lars-Peter Clausen wrote:
> On 03/31/2014 01:21 PM, Mark Brown wrote:

> >The above is a bit confusing...  partly this is because of a lack of
> >context (what is MULTI_MUX_INPUT_OFFSET?) and partly because it isn't
> >entirely obvious that stopping as soon as we see any value set is the
> >right choice, especially given the addition to rather than setting of
> >val.

> I think the idea is that since we know that for one-hot encodings only
> powers of two are valid values the other bits are used to encode the
> register number. E.g 0x4 means bit 3 in register 0, 0x5 means bit 3 in
> register 1, 0x6 means bit 3 in register 2 and so on. I guess it is possible
> to make it work. But this seems to be quite hack-ish to me. You'd have to be
> careful that MULTI_MUX_INPUT_OFFSET(reg_idx) never evaluates to a power of
> two and there are probably some more pitfalls.

Ugh, right.  The fact that I couldn't tell that this was what the code
was trying to do from looking at it is not a good sign here.

--5UN41tlPsqEEbq75
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOVqRAAoJELSic+t+oim9elUP/1ShTgGXfGf0zIOhjsSXh+qA
piIiERAxX51dZnNaLXg192209RzXYOWGh1NQVBaFJ+WdvNo1E+Ty7eHXMlYPQG7q
B5U9NtTD3jg7wR/Mq3EMda+Xz3WstpgVSPOLRa+r9tturwVMK2uNneVJFQ02I6Y2
ZEUnUEfqRe6YxC8UKCJCGOc1ygsjqn9GL3H3f+YFlBD1MYgA47c/rtfjDpQ+PLms
7kD8b+QgxFrxzhjtJ52+XLfDeM+F3TKrc7UKI3Lawmgxc9HW0yOIui1k2G81TXHp
qt3ZPtVXZwPOQMQ6gfkDhsr2Z/yCtyWWUwoHwkt1+UekhOZ0T8pkL/63ugIQXKDx
3jzoNrhPvasl/bc8YJjxKLO8KX35tI/qavQt/mAGy+AKZuczSAI/LR0XJjiJL5ff
cFwLs4PMrcQJTkyNvksVYc6wLLQjHfIM9HsBvQ2XUzmT8gKt1jigDC7EF6JFdgJB
UUYW0zYg2pGNy5v/3o9JftALBFK2bPgnSry/OUDy5n426kW9VPlMNtb955Vne0sC
xoS8JP1NI0vaNyQntxYOZy3l4nHK9NKFmF2PU7Nb12dMkqpimgYPksnDjytqrgnD
v5m6+wPcb1N/KsRSrTkqDi3FfO9bjmYmcT3Z4UsxiBMi6NuDgWebeMMBuDC1cjlK
1Qs5nVOGFOeCdNsViZ/O
=KPR7
-----END PGP SIGNATURE-----

--5UN41tlPsqEEbq75--

--===============6395826108704427588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6395826108704427588==--
