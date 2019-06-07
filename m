From: Rui Nuno Capela <rncbc@rncbc.org>
Subject: ALSA: snd_ice1712: Check correct return value to
 snd_i2c_sendbytes (EWS/DMX 6Fire)
Date: Fri, 7 Jun 2019 15:00:12 +0100
Message-ID: <70c8eb71-54d7-b440-967e-7717063a7259@rncbc.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------899C8D2E36FA40B22F531F7A"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from beta.rncbc.lan (a79-169-192-71.cpe.netcabo.pt [79.169.192.71])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C740F80709
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2019 16:00:25 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------899C8D2E36FA40B22F531F7A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Check for exact and correct return value to snd_i2c_sendbytes
call for EWS/DMX 6Fire (snd_ice1712).

Fixes a systemic error on every boot to snd_ice1712 driver
("cannot send pca") on Terratec EWS/DMX 6Fire PCI soundcards.

Signed-off-by: Rui Nuno Capela <rncbc@rncbc.org>

Cheers
- -- 
rncbc aka. Rui Nuno Capela
rncbc@rncbc.org
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEml2OG8nT8/KXriugSepTUDAa1MgFAlz6beYACgkQSepTUDAa
1MgAggf+LVoDgtUTSU6OsBipvlZ9Ro8ll4qBIPC8JtECk6iHur3C/xEHYqirVRQa
HVBuNxN4RiaJI/upALZ/6n2XY3cjB04qgfCg+lQTQFAY7Or6G3L3vzyg8C/y7q2n
uqkZTgbfNwQ01Xbq7Xa9QQ02eJKFCAmAOscBXwBQTpzzoThwFj0edUqvHleYuWOT
b6qsVUSJJmJQlJe/10zyg+btmQEtLAWtLsIg0pkvJQJCmQgxeCvDspoH8THs/ov3
eCZNVUjnK1qkkl1Z7yFLjp7wx8RV28YZ5kMtDmkiDac66JfEO80qtJvxwbAY/hOm
B/mII9niJLCEGV2cdNwPGpr2n4EdLg==
=g9Fk
-----END PGP SIGNATURE-----

--------------899C8D2E36FA40B22F531F7A
Content-Type: text/x-patch;
 name="patch-5.1.7-snd_ice1712-ews-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch-5.1.7-snd_ice1712-ews-1.diff"

Check for exact and correct return value to snd_i2c_sendbytes
call for EWS/DMX 6Fire (snd_ice1712).

Fixes a systemic error on every boot to snd_ice1712 driver
("cannot send pca") on Terratec EWS/DMX 6Fire PCI soundcards.

Signed-off-by: Rui Nuno Capela <rncbc@rncbc.org>


--- a/sound/pci/ice1712/ews.c	2019-06-04 06:59:45.000000000 +0100
+++ b/sound/pci/ice1712/ews.c	2019-06-07 11:04:01.735954865 +0100
@@ -826,7 +826,7 @@
 
 	snd_i2c_lock(ice->i2c);
 	byte = reg;
-	if (snd_i2c_sendbytes(spec->i2cdevs[EWS_I2C_6FIRE], &byte, 1)) {
+	if (snd_i2c_sendbytes(spec->i2cdevs[EWS_I2C_6FIRE], &byte, 1) != 1) {
 		snd_i2c_unlock(ice->i2c);
 		dev_err(ice->card->dev, "cannot send pca\n");
 		return -EIO;

--------------899C8D2E36FA40B22F531F7A
Content-Type: application/pgp-keys;
 name="0x9D0514152A8E5EC4.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0x9D0514152A8E5EC4.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=fVik
-----END PGP PUBLIC KEY BLOCK-----

--------------899C8D2E36FA40B22F531F7A
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------899C8D2E36FA40B22F531F7A--
