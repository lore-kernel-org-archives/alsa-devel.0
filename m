From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH][next] ASoC: samsung: remove redundant pointer cpu_dai
Date: Tue, 13 Mar 2018 16:22:41 +0000
Message-ID: <1db711ff-63ba-7a0e-dc9d-33638bd4a0d9@canonical.com>
References: <20180313133626.31286-1-colin.king@canonical.com>
 <20180313162138.GQ2186@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NmhQ8UuReUGrKkEw16050u7Y6wETHqa6I"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180313162138.GQ2186@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NmhQ8UuReUGrKkEw16050u7Y6wETHqa6I
Content-Type: multipart/mixed; boundary="7ATi9oyvZgQiuPffh01VtWsIZvRkXEuM6";
 protected-headers="v1"
From: Colin Ian King <colin.king@canonical.com>
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim
 <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1db711ff-63ba-7a0e-dc9d-33638bd4a0d9@canonical.com>
Subject: Re: [PATCH][next] ASoC: samsung: remove redundant pointer cpu_dai
References: <20180313133626.31286-1-colin.king@canonical.com>
 <20180313162138.GQ2186@sirena.org.uk>
In-Reply-To: <20180313162138.GQ2186@sirena.org.uk>

--7ATi9oyvZgQiuPffh01VtWsIZvRkXEuM6
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13/03/18 16:21, Mark Brown wrote:
> On Tue, Mar 13, 2018 at 01:36:26PM +0000, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The pointer cpu_dai is assigned a value but the pointer is never
>> read, hence it is redundant and can be removed.
>=20
> There's some subsequent patches to that driver which I think provide an=

> alternative fix for this.
>=20
OK, glad it's been resolved.


--7ATi9oyvZgQiuPffh01VtWsIZvRkXEuM6--

--NmhQ8UuReUGrKkEw16050u7Y6wETHqa6I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJNBAEBCAA3FiEEcGLapPABucZhZwDPaMKH38aoAiYFAlqn+tEZHGNvbGluLmtp
bmdAY2Fub25pY2FsLmNvbQAKCRBowoffxqgCJk0FD/9EwjzOc/DkqLjwN58bPtUM
3KwUDNe29LLLRSFT9bBIZqpTFFAU0e/V6ThOMXl+ft0RaC+48xlf/i2+nqIgYx2z
5YsX8rYzbJAEN+wqT7LxHBYRUgzKCqVA+mjaxT1bbIgwK5V44gjlJGEAjNEIm8GA
BP+pdd3pHhcuuWMxivW8fFO5eaLlotM0N2S8fX0UruftkdpHYPn9lw1o3UmFVphE
+T62O2I7JI7+3guiYfM5vYMgJQf76+RVaKr1gw+7KQLNo2h0/G2Pes02d2Zpw6Le
0vuZ1/x03PFyvVwvdS74xEpKZiSM9fN3oPF3DZEx0j0xBbidOlM8BjfKmRKJbQIq
UpREasYvwUxOv2cmA4hhJQTYl+4q+YLsrsFBVts2sY3E3GEBLNJ1WcSwWbcVoC/m
ngPIz2suOu4RM+ookZg+bBr7UvomRvOVFj6myrrJ9IMCtgFGqaxVHEYPmDG5IuCt
Sx7xI+EKs/cmvKHqKan6iyXdEf+EMoCmGfzG0utVLh1gf18PFO+5NQ5V+DLRN3jI
H2uhuTYJuuIpKt5ftPE45XkD80jiJliPk+8JDeT/uV/q8qVBiYGZabCINlM0/gtO
8dOm0BIpaGCO3Wt3mPkFt6xuIFAZj0AIeypEcSOBcIFA12BS+w5pxz9FsDPAZe1V
kAxQyvwmgIjCdD1VTARwog==
=wjy8
-----END PGP SIGNATURE-----

--NmhQ8UuReUGrKkEw16050u7Y6wETHqa6I--
