From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: [PATCH/KCONFIG] - Add SUPERH depends to
	sound/soc/sh/Kconfig
Date: Fri, 1 Feb 2008 08:08:01 +0100
Message-ID: <20080201080801.16be8d6d.Kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Fri__1_Feb_2008_08_08_01_+0100_DR5uL1PbReVEL_eC"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FE9A103848
	for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2008 08:08:30 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id w49so1526165pyg.36
	for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2008 23:08:23 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart=_Fri__1_Feb_2008_08_08_01_+0100_DR5uL1PbReVEL_eC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Currently you will see an empty "SoC Audio support for SuperH" menu 
when building for other archs (example pxa).
This patch adds "depends on SUPERH" to remove that empty menu.

signed-off-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index f03220d..4c1e013 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -1,4 +1,5 @@
 menu "SoC Audio support for SuperH"
+	depends on SUPERH
 
 config SND_SOC_PCM_SH7760
 	tristate "SoC Audio support for Renesas SH7760"



--Multipart=_Fri__1_Feb_2008_08_08_01_+0100_DR5uL1PbReVEL_eC
Content-Type: application/octet-stream;
 name="SoC-SuperH-add-depends.patch"
Content-Disposition: attachment;
 filename="SoC-SuperH-add-depends.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zaC9LY29uZmlnIGIvc291bmQvc29jL3NoL0tjb25maWcK
aW5kZXggZjAzMjIwZC4uNGMxZTAxMyAxMDA2NDQKLS0tIGEvc291bmQvc29jL3NoL0tjb25maWcK
KysrIGIvc291bmQvc29jL3NoL0tjb25maWcKQEAgLTEsNCArMSw1IEBACiBtZW51ICJTb0MgQXVk
aW8gc3VwcG9ydCBmb3IgU3VwZXJIIgorCWRlcGVuZHMgb24gU1VQRVJICiAKIGNvbmZpZyBTTkRf
U09DX1BDTV9TSDc3NjAKIAl0cmlzdGF0ZSAiU29DIEF1ZGlvIHN1cHBvcnQgZm9yIFJlbmVzYXMg
U0g3NzYwIgo=

--Multipart=_Fri__1_Feb_2008_08_08_01_+0100_DR5uL1PbReVEL_eC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Multipart=_Fri__1_Feb_2008_08_08_01_+0100_DR5uL1PbReVEL_eC--
