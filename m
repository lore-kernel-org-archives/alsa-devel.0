From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] alsactl fixes
Date: Fri, 20 Jun 2003 09:09:43 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0306200908110.9190-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


When a card doesn't have any controls, the state.cardid.control node
isn't written to the output file because the node's join flag has been
set. This patch modifies alsactl not to set the join flag in this case
to prevent the "no state is present for card" message from "alsactl
restore".

And the check in line 510 used the wrong variable.



Index: alsa-utils/alsactl/alsactl.c
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/alsactl/alsactl.c,v
retrieving revision 1.52
diff -u -r1.52 alsactl.c
--- alsa-utils/alsactl/alsactl.c	1 Apr 2003 15:51:16 -0000	1.52
+++ alsa-utils/alsactl/alsactl.c	20 Jun 2003 07:00:26 -0000
@@ -507,7 +507,7 @@
 	}
 	err = snd_config_search(state, id, &card);
 	if (err == 0 &&
-	    snd_config_get_type(state) != SND_CONFIG_TYPE_COMPOUND) {
+	    snd_config_get_type(card) != SND_CONFIG_TYPE_COMPOUND) {
 		error("config state.%s node is not a compound", id);
 		err = -EINVAL;
 		goto _close;
@@ -527,18 +527,22 @@
 			goto _close;
 		}
 	}
-	err = snd_config_compound_add(card, "control", 1, &control);
-	if (err < 0) {
-		error("snd_config_compound_add: %s", snd_strerror(err));
-		goto _close;
-	}
 	err = snd_ctl_elem_list(handle, list);
 	if (err < 0) {
 		error("Cannot determine controls: %s", snd_strerror(err));
 		goto _close;
 	}
 	count = snd_ctl_elem_list_get_count(list);
-	if (count <= 0) {
+	if (count < 0) {
+		err = 0;
+		goto _close;
+	}
+	err = snd_config_compound_add(card, "control", count > 0, &control);
+	if (err < 0) {
+		error("snd_config_compound_add: %s", snd_strerror(err));
+		goto _close;
+	}
+	if (count == 0) {
 		err = 0;
 		goto _close;
 	}




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
