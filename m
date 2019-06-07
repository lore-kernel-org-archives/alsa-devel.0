From: Rui Nuno Capela <rncbc@rncbc.org>
Subject: [PATCH] ALSA: snd_ice1712: Check correct return value
 to snd_i2c_sendbytes (EWS/DMX 6Fire)
Date: Fri, 7 Jun 2019 15:13:37 +0100
Message-ID: <cdac9547-b08f-62d4-d29a-89a4f92c3225@rncbc.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1E9DF436977A5F73D0C06C80"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from beta.rncbc.lan (a79-169-192-71.cpe.netcabo.pt [79.169.192.71])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81797F80709
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2019 16:13:49 +0200 (CEST)
Received: from [172.21.2.2] (unknown [185.31.158.240])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (Client did not present a certificate)
 by beta.rncbc.lan (Postfix) with ESMTPSA id 63F9A2007F
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2019 15:13:48 +0100 (WEST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------1E9DF436977A5F73D0C06C80
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Check for exact and correct return value to snd_i2c_sendbytes
call for EWS/DMX 6Fire (snd_ice1712).

Fixes a systemic error on every boot starting from kernel 5.1
onwards to snd_ice1712 driver ("cannot send pca") on Terratec
EWS/DMX 6Fire PCI soundcards.

Signed-off-by: Rui Nuno Capela <rncbc@rncbc.org>


--------------1E9DF436977A5F73D0C06C80
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


--------------1E9DF436977A5F73D0C06C80
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------1E9DF436977A5F73D0C06C80--
