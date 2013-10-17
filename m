From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ALSA: Add SoC on-chip internal memory
 support for DMA buffer allocation
Date: Thu, 17 Oct 2013 10:38:34 +0100
Message-ID: <20131017093834.GI2443@sirena.org.uk>
References: <1381920801-9187-1-git-send-email-b42378@freescale.com>
 <20131016115847.GK2443@sirena.org.uk> <525EBFF0.1080303@metafoo.de>
 <20131016174658.GO2443@sirena.org.uk>
 <20131017015431.GD24805@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4641235767557497702=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 376F1265358
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2013 11:38:47 +0200 (CEST)
In-Reply-To: <20131017015431.GD24805@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4641235767557497702==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HqT/R3Rz35fLyCbr"
Content-Disposition: inline


--HqT/R3Rz35fLyCbr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2013 at 09:54:32AM +0800, Nicolin Chen wrote:

> Do I still need to change the name to SRAM? I think both name make sense to me.
> I use IRAM just because using different name for phandle and macro/functions
> might confuse people when reviewing the patch. But it looks like IRAM is still
> not the perfect choice.

No, IRAM is fine if that is actually used these days.

--HqT/R3Rz35fLyCbr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSX7AXAAoJELSic+t+oim9LCMP/2KxaQFuhtaYGNVB1/cXJHpR
vf70Obu7BPo7aGpWqkxB2/0ldLkGZy+q9bzpL3wL+Dh8PcxOOKOnX6o+yJ1bxHrP
8pugDBooBAru4mxmqWVTLXTVztTZCprH3rEahT74UoLC8ej/AKTmm2zT56XRzkjD
xERg7nz7ruxG/qnqNjOO2ANgewwRHDkj7QoEAkknQpyvuJoEpwv4c7n9/fK4Q6BU
oHNKC8n1zpJujnTLDU4QU+G/F3BsFKsgIZzfEzn7/z37J2xqvh8YxkxCUdaF9Knb
+KM+haMVYgtXRDB1PsJrvCAcQ/dvj816Xdkmw/tAdw2Iy/ljTWH/DppNdxz2PAtK
tOkHkPpWNMelovToH2F4YWO/GyNmU4QkjjDY1cxCfq/P53+IdwWsImldPWhzqmMF
zX6LLE/WMNYX8pbI8EOcoaTxTydHJktHbZl0kNpsVUTFaxMx8r71a1RcNit+0IH6
eUrkQGk5BGCMJ6b44sUIeMXNnV86Ha6dkjvp8qxibv+1kc8kfEGsKidaSJimuFEJ
LG5olBcmBNsIqKS46VNKybC0YpxITi+0gKoNUSYbrrWcctZ/tyIiUbOdn5S177UA
vgWsT2XWHFuUhk4cqC0GBinbr4uQggacJ6en8Uat9txhoKjTr2A4vD9uXGhdq+Gy
mQA07jT4XzAYuFBLjNQ8
=wVSt
-----END PGP SIGNATURE-----

--HqT/R3Rz35fLyCbr--

--===============4641235767557497702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4641235767557497702==--
