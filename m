From: Dirk Jagdmann <doj@cubic.org>
Subject: [patch] envy24control midi bugfix
Date: Tue, 26 Jul 2005 19:02:28 +0200
Message-ID: <42E66CA4.6060202@cubic.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000302070604030307040602"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from roasted.cubic.org (roasted.cubic.org [193.108.181.130])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 23CE015A
	for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2005 19:02:32 +0200 (MEST)
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
Cc: perex@suse.cz
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000302070604030307040602
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello developers,

this patch is a bugfix for the midi patch I posted yesterday. This patch 
fixes the "mute" button when driven via midi and the "LR Gang" button is 
set.

-- 
---> doj / cubic
----> http://cubic.org/~doj
-----> http://llg.cubic.org

--------------000302070604030307040602
Content-Type: text/plain;
 name="envy24control-midi-bugfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="envy24control-midi-bugfix.patch"

Index: mixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/mixer.c,v
retrieving revision 1.11
diff -u -r1.11 mixer.c
--- mixer.c	26 Jul 2005 11:37:11 -0000	1.11
+++ mixer.c	26 Jul 2005 14:58:58 -0000
@@ -133,10 +133,15 @@
 
 void mixer_set_mute(int stream, int left, int right)
 {
-	if (left >= 0)
+	int stereo = is_active(mixer_stereo_toggle[stream-1]) ? 1 : 0;
+	if (left >= 0 || stereo) {
 		toggle_set(mixer_mute_toggle[stream-1][0], left ? TRUE : FALSE);
-	if (right >= 0)
+		if(stereo && left<0) left=right;
+	}
+	if (right >= 0 || stereo) {
 		toggle_set(mixer_mute_toggle[stream-1][1], right ? TRUE : FALSE);
+		if(stereo && right<0) right=left;
+	}
 	set_switch1(stream, left, right);
 }
 

--------------000302070604030307040602--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
