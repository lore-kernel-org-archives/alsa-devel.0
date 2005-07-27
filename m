From: Sergey Ulanov <Sergey.Ulanov@asplinux.ru>
Subject: [patch] Jack Sense support for AD1980 and AD1888
Date: Wed, 27 Jul 2005 13:02:18 +0400
Message-ID: <1122454939.1820.7.camel@sulanov.acronis.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-+0pTnq48xPs+41znqy7L"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-+0pTnq48xPs+41znqy7L
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Hello,
Attached patch adds "Jack Sense" controls for AD1980 and AD1888 chips.

--
Sergey Ulanov

--=-+0pTnq48xPs+41znqy7L
Content-Disposition: attachment; filename=alsa-driver-1.0.9b-ad1888-jacksense.patch
Content-Type: text/x-patch; name=alsa-driver-1.0.9b-ad1888-jacksense.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- ./alsa-driver-1.0.9b/alsa-kernel/pci/ac97/ac97_patch.c.orig	2005-05-27 13:42:45.000000000 +0400
+++ ./alsa-driver-1.0.9b/alsa-kernel/pci/ac97/ac97_patch.c	2005-07-27 12:58:27.758427488 +0400
@@ -1528,6 +1528,9 @@
 	},
 	AC97_SURROUND_JACK_MODE_CTL,
 	AC97_CHANNEL_MODE_CTL,
+
+	AC97_SINGLE("Headphone Jack Sense", AC97_AD_JACK_SPDIF, 10, 1, 0),
+	AC97_SINGLE("Line Jack Sense", AC97_AD_JACK_SPDIF, 12, 1, 0),
 };
 
 static int patch_ad1888_specific(ac97_t *ac97)

--=-+0pTnq48xPs+41znqy7L--



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
