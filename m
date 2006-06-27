From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] snd-aoa: support iMac G5 iSight
Date: Tue, 27 Jun 2006 19:37:44 +0200
Message-ID: <1151429864.597.20.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8281A26F
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jun 2006 19:37:49 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This properly adds support for the iMac G5 iSight.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- a/fabrics/snd-aoa-fabric-layout.c
+++ b/fabrics/snd-aoa-fabric-layout.c
@@ -94,6 +94,7 @@ MODULE_ALIAS("sound-layout-82");
 MODULE_ALIAS("sound-layout-84");
 MODULE_ALIAS("sound-layout-86");
 MODULE_ALIAS("sound-layout-92");
+MODULE_ALIAS("sound-layout-96");
 
 /* onyx with all but microphone connected */
 static struct codec_connection onyx_connections_nomic[] = {
@@ -381,6 +382,13 @@ static struct layout layouts[] = {
 		.connections = toonie_connections,
 	  },
 	},
+	{
+	  .layout_id = 96,
+	  .codecs[0] = {
+	  	.name = "onyx",
+	  	.connections = onyx_connections_noheadphones,
+	  },
+	},
 	/* unknown, untested, but this comes from Apple */
 	{ .layout_id = 41,
 	  .codecs[0] = {
@@ -479,12 +487,6 @@ static struct layout layouts[] = {
 		.connections = onyx_connections_noheadphones,
 	  },
 	},
-	{ .layout_id = 96,
-	  .codecs[0] = {
-		.name = "onyx",
-		.connections = onyx_connections_noheadphones,
-	  },
-	},
 	{ .layout_id = 98,
 	  .codecs[0] = {
 		.name = "toonie",



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
