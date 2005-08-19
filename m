From: Nicolas GRAZIANO <nicolas.graziano@free.fr>
Subject: [PATCH] hda-intel, correct a bug in detection of rate supported
Date: Fri, 19 Aug 2005 21:59:58 +0200
Message-ID: <43063A3E.4010903@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from postfix3-2.free.fr (postfix3-2.free.fr [213.228.0.169])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 22ACF1E2
	for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2005 22:00:00 +0200 (MEST)
Received: from [82.66.38.107] (rob92-2-82-66-38-107.fbx.proxad.net [82.66.38.107])
	by postfix3-2.free.fr (Postfix) with ESMTP id 89FB0C085
	for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2005 21:59:58 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The insertion of the rate 9600 make a shift in detection of supported
rate, put this rate at the end of the list.

Signed-off-by: Nicolas Graziano <nicolas.graziano@wanadoo.fr>


Index: pci/hda/hda_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/hda_codec.c,v
retrieving revision 1.23
diff -u -r1.23 hda_codec.c
--- pci/hda/hda_codec.c 11 Aug 2005 10:00:16 -0000      1.23
+++ pci/hda/hda_codec.c 19 Aug 2005 19:43:51 -0000
@@ -1165,8 +1165,9 @@
  */
 static unsigned int rate_bits[][3] = {
        /* rate in Hz, ALSA rate bitmask, HDA format value */
+
+       /* autodetected value used in snd_hda_query_supported_pcm */
        { 8000, SNDRV_PCM_RATE_8000, 0x0500 }, /* 1/6 x 48 */
-       { 9600, SNDRV_PCM_RATE_KNOT, 0x0400 }, /* 1/5 x 48 */
        { 11025, SNDRV_PCM_RATE_11025, 0x4300 }, /* 1/4 x 44 */
        { 16000, SNDRV_PCM_RATE_16000, 0x0200 }, /* 1/3 x 48 */
        { 22050, SNDRV_PCM_RATE_22050, 0x4100 }, /* 1/2 x 44 */
@@ -1177,6 +1178,9 @@
        { 96000, SNDRV_PCM_RATE_96000, 0x0800 }, /* 2 x 48 */
        { 176400, SNDRV_PCM_RATE_176400, 0x5800 },/* 4 x 44 */
        { 192000, SNDRV_PCM_RATE_192000, 0x1800 }, /* 4 x 48 */
+
+       /* not autodetected value */
+       { 9600, SNDRV_PCM_RATE_KNOT, 0x0400 }, /* 1/5 x 48 */
        { 0 }
 };




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
