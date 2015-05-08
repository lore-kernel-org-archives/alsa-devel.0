From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5645: improve headphone depop
	function
Date: Fri, 8 May 2015 18:15:11 +0100
Message-ID: <20150508171511.GF2761@sirena.org.uk>
References: <1431064414-27676-1-git-send-email-john.lin@realtek.com>
 <1431064414-27676-2-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2670385700031721186=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EAC2265DDA
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 19:15:17 +0200 (CEST)
In-Reply-To: <1431064414-27676-2-git-send-email-john.lin@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Lin <john.lin@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, zhengxing@rock-chips.com, yang.a.fang@intel.com, koro.chen@mediatek.com, lgirdwood@gmail.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2670385700031721186==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eNMatiwYGLtwo1cJ"
Content-Disposition: inline


--eNMatiwYGLtwo1cJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2015 at 01:53:34PM +0800, John Lin wrote:
> We add a calibration function and call it at the beginning of
> i2c_probe. The calibration value will be kept until codec is
> shutdown. We will reset the codec after the calibration is finished.
> So, we set cache_bypass in the calibration function. The benefit is
> we can shorter the delay time in headphone depop.

This looks fine but seems to depend on the previous patch.

--eNMatiwYGLtwo1cJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVTO8eAAoJECTWi3JdVIfQPNcH/34GH6eI5t8DZm0XEpMyjH7B
9jhq/m4HTzCo3Har1cwLaQBKaPrUNL8Szk/vD2BMpgkEkp4GX/NIwxTuCMyZhGl5
Lh9aKnWQb0XI1JkoNLbCR0IGPIYTqeNu3WUctFedxQnL8Q4x4PINZ678pfU6h4pr
4Nitit/b7s+45ug+qubOEQMpEnP+3SlI3CJTLIg3qiFkGQwgNAyEwYog19mRkIXi
jbxQUJn+LqoSpYGzTBLVzm2exLr3F0jPXmvXo74I63hTbnD375OFp+wCp/qMgqH1
6QlDKQmA1vtrgp2NA06WunQuWo0MMlQLzJj4BJmKV1mWY9yi60JjrhY0gHtM9rk=
=5Taj
-----END PGP SIGNATURE-----

--eNMatiwYGLtwo1cJ--

--===============2670385700031721186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2670385700031721186==--
