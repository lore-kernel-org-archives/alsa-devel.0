From: Pawel MOLL <pawel.moll@st.com>
Subject: [PATCH] IEC958 definitions for consumer status channel,
	byte 4
Date: Fri, 29 Feb 2008 10:57:55 +0000
Message-ID: <1204282675.19178.8.camel@bri1004.bri.st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-xAJi2+xVolVaVsltg1Of"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s200aog14.obsmtp.com (s200aog14.obsmtp.com [207.126.144.128])
	by alsa0.perex.cz (Postfix) with ESMTP id A052D243CC
	for <alsa-devel@alsa-project.org>; Fri, 29 Feb 2008 11:58:04 +0100 (CET)
Received: from zeta.dmz-us.st.com (ns4.st.com [167.4.80.115])
	by beta.dmz-us.st.com (STMicroelectronics) with ESMTP id E92E0DB08
	for <alsa-devel@alsa-project.org>; Fri, 29 Feb 2008 10:57:57 +0000 (GMT)
Received: from mail1.bri.st.com (mail1.bri.st.com [164.129.8.218])
	by zeta.dmz-us.st.com (STMicroelectronics) with ESMTP id 6A66F48CB3
	for <alsa-devel@alsa-project.org>; Fri, 29 Feb 2008 10:57:57 +0000 (GMT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-xAJi2+xVolVaVsltg1Of
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Attached are patches for alsa-kernel and alsa-lib, adding mentioned
definitions.

Regards

Pawe=C5=82

--=-xAJi2+xVolVaVsltg1Of
Content-Disposition: attachment; filename=alsa-kernel.iec958_aec4_con.patch
Content-Type: text/x-patch; name=alsa-kernel.iec958_aec4_con.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Added definition for byte 4 of SPDIF channel status, according to
second edition of IEC 60958-3 (consumer) spec.

Signed-off-by: Pawel MOLL <pawel.moll@st.com>
---
diff -r 8ba16b4a9e2d include/asoundef.h
--- a/include/asoundef.h	Wed Jan 23 11:52:38 2008 +0100
+++ b/include/asoundef.h	Fri Feb 29 10:47:54 2008 +0000
@@ -112,6 +112,14 @@
 #define IEC958_AES3_CON_CLOCK_1000PPM	(0<<4)	/* 1000 ppm */
 #define IEC958_AES3_CON_CLOCK_50PPM	(1<<4)	/* 50 ppm */
 #define IEC958_AES3_CON_CLOCK_VARIABLE	(2<<4)	/* variable pitch */
+#define IEC958_AES4_CON_MAX_WORDLEN_24	(1<<0)	/* 0 = 20-bit, 1 = 24-bit */
+#define IEC958_AES4_CON_WORDLEN		(7<<1)	/* mask - sample word length */
+#define IEC958_AES4_CON_WORDLEN_NOTID	(0<<1)	/* not indicated */
+#define IEC958_AES4_CON_WORDLEN_20_16	(1<<1)	/* 20-bit or 16-bit */
+#define IEC958_AES4_CON_WORDLEN_22_18	(2<<1)	/* 22-bit or 18-bit */
+#define IEC958_AES4_CON_WORDLEN_23_19	(4<<1)	/* 23-bit or 19-bit */
+#define IEC958_AES4_CON_WORDLEN_24_20	(5<<1)	/* 24-bit or 20-bit */
+#define IEC958_AES4_CON_WORDLEN_21_17	(6<<1)	/* 21-bit or 17-bit */
 
 /*****************************************************************************
  *                                                                           *

--=-xAJi2+xVolVaVsltg1Of
Content-Disposition: attachment; filename=alsa-lib.iec958_aes4_con.patch
Content-Type: text/x-patch; name=alsa-lib.iec958_aes4_con.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Added definition for byte 4 of SPDIF channel status, according to
second edition of IEC 60958-3 (consumer) spec.

Signed-off-by: Pawel MOLL <pawel.moll@st.com>
---
diff -r 7388ad3d21ea include/asoundef.h
--- a/include/asoundef.h	Mon Feb 25 15:11:46 2008 +0100
+++ b/include/asoundef.h	Fri Feb 29 10:47:40 2008 +0000
@@ -121,6 +121,14 @@ extern "C" {
 #define IEC958_AES3_CON_CLOCK_1000PPM	(0<<4)	/**< 1000 ppm */
 #define IEC958_AES3_CON_CLOCK_50PPM	(1<<4)	/**< 50 ppm */
 #define IEC958_AES3_CON_CLOCK_VARIABLE	(2<<4)	/**< variable pitch */
+#define IEC958_AES4_CON_MAX_WORDLEN_24	(1<<0)	/**< 0 = 20-bit, 1 = 24-bit */
+#define IEC958_AES4_CON_WORDLEN		(7<<1)	/**< mask - sample word length */
+#define IEC958_AES4_CON_WORDLEN_NOTID	(0<<1)	/**< not indicated */
+#define IEC958_AES4_CON_WORDLEN_20_16	(1<<1)	/**< 20-bit or 16-bit */
+#define IEC958_AES4_CON_WORDLEN_22_18	(2<<1)	/**< 22-bit or 18-bit */
+#define IEC958_AES4_CON_WORDLEN_23_19	(4<<1)	/**< 23-bit or 19-bit */
+#define IEC958_AES4_CON_WORDLEN_24_20	(5<<1)	/**< 24-bit or 20-bit */
+#define IEC958_AES4_CON_WORDLEN_21_17	(6<<1)	/**< 21-bit or 17-bit */
 
 /** \} */
 

--=-xAJi2+xVolVaVsltg1Of
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-xAJi2+xVolVaVsltg1Of--
