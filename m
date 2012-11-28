From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/14] ASoC: wm8993: Use
	devm_regulator_bulk_get
Date: Wed, 28 Nov 2012 17:41:42 +0000
Message-ID: <20121128174142.GW32691@opensource.wolfsonmicro.com>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
 <1353930587-12907-5-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6712262966347785940=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C0C9A261731
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 18:41:43 +0100 (CET)
In-Reply-To: <1353930587-12907-5-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============6712262966347785940==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7kW37LRKoI6fR2de"
Content-Disposition: inline


--7kW37LRKoI6fR2de
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2012 at 05:19:37PM +0530, Sachin Kamat wrote:
> devm_regulator_bulk_get() is device managed and makes error
> handling and code cleanup simpler.

Applied, thanks.  CC maintainers.

--7kW37LRKoI6fR2de
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQtkzPAAoJELSic+t+oim9/xUP/iazNxzwmTYx0cgVyhVI8alE
eEXRb0V6w9DIIZjVbOtBi/G8vRXVy57GeLhMgpq6AVFMkw/ovn5gnGcH5Ow2Vur1
3ijjx7+CEXwQqOU+WMWbXaKQGy80ytvVoaZgGsYH2/xq2vTXCJzXKb5uneU7e1D4
Db1+byYfidKmeGBPpQQIbursLxsFk27z9P0RRAe7wet6Pn8EnZktaL5BRtavwB8U
vhdXvyrAMYm1JgkK+2+oMeP0R6xEVXAibaP59bFgAoxJuLmR6jRtoTqSMrf+8z0O
cZcSiUHrGN/lKdp+r1zTgujy9Sx+9dHP2t7lSFUlqcS+AZLQnHiitrS7EFAWZLDI
3c3yR4UY1o0ZiJU8A3ov5EzerfpmZaF6lIHoiX9mLuc5YnJBJxeFLIArlY3q1thq
6hiPSduE0EO/uYzsyYOBU36Y/UKd13fuIgQ5N9x1VHkgFl8SgQ2KBQL61ZhRFQzn
3dzf3Buy/i/YimPK2WYwbInlLJ1iPoeq7Mv1kUU3D/HpsjJr/aVfh+PLoCbIADzh
T9bQMs79jou+tRUh2WUDyWgqN45TyOCufDoULE/rhrwe2br5Ydj+C8COnozaRMue
xJVWkHweFPJ5504Fi70qp2kVKdzIJ/1GiD46RrlVQ3MuFDs3+MUQAvTH5YF8qVYy
28Hw6w7CTqLxfKwwne+X
=Tv4y
-----END PGP SIGNATURE-----

--7kW37LRKoI6fR2de--

--===============6712262966347785940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6712262966347785940==--
