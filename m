From: Christian Engelmayer <cengelma@gmx.at>
Subject: [PATCH] ASoC: Intel: Fix a self assignment in
 sst_mem_block_alloc_scratch()
Date: Sun, 13 Apr 2014 22:46:31 +0200
Message-ID: <20140413224631.1a1bdce1@spike>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/6tzXmpl9EFswPUYPSaZdRPF"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Dan Carpenter <dan.carpenter@oracle.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

--Sig_/6tzXmpl9EFswPUYPSaZdRPF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Remove a self assignment in sst_mem_block_alloc_scratch(). When calculating
buffer sizes there is no need for statements without effect. Detected by
Coverity: CID 1195249.

Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
---
 sound/soc/intel/sst-firmware.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index f768710..f24619a 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -505,9 +505,7 @@ struct sst_module *sst_mem_block_alloc_scratch(struct s=
st_dsp *dsp)
=20
 	/* calculate required scratch size */
 	list_for_each_entry(sst_module, &dsp->module_list, list) {
-		if (scratch->s.size > sst_module->s.size)
-			scratch->s.size =3D scratch->s.size;
-		else
+		if (scratch->s.size < sst_module->s.size)
 			scratch->s.size =3D sst_module->s.size;
 	}
=20
--=20
1.8.3.2

--Sig_/6tzXmpl9EFswPUYPSaZdRPF
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTSvenAAoJEKssnEpaPQKEwXQQANSrujXA4kpRYe1F3Nywh+6m
9itVV6sAeiEaVfRECBctASDHpUg2MRD0QN454xwmDateYhf4lshMsXPWy/3tS2FL
G7nN0TifgYjD1eFjAsbtaD33AiJLtw2Cdfsn7YQOOgpo42qm5ZNSJ9W3FCT8zJHL
bwj47BE2FBro6dRQnvPVBE/loxljGGCM6pm0utNIlxfBPi5/4GO6nLm0IXleC6IZ
ibbniWOUx9BL1N/0YP8bI4qVrBQSmT8J2KVG5W5MvXDcllh9dlkOosNWc7FKLf4S
w6mdW9EujzIEgPhSpJBRpqoTTYQ/qWcHWXM4qfsThjV/4YxMNs6RN7JCJKLU4i83
WhE3C/vqyTV9l9StC12JU6cdfnasPda3WWqz77NFpi60T2XYkX4m4qayLmPwnQVd
MKfcj/NL8HZSQc/V5B2uA3AhHzEv9emYGOow2C/JZeEGkDjFDKclgLXwoaflS3j4
6uXKDjjB7+CPnzR8WVHOgM6epj8HSALTK4aG1K9GvJVcJxmTs5f6OSxIV3CY0jH0
IeZPBC9rA0wa7A0Z96sY9E9V5A9JEwMcshuViNnrycFL7XPKLcXW990cz2M5gLLJ
mUwyRqZ3DP9U+7iBQzAmkAf/eT/ACOBJ8zcs61I3qwBuYh8qlqXa0vPrwOVtt7eE
tqdhh8j6gd9PfeDootJj
=avaV
-----END PGP SIGNATURE-----

--Sig_/6tzXmpl9EFswPUYPSaZdRPF--
