From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: [PATCH] Change alsamixer to show different views. Playback controls,
 or Capture controls.
Date: Fri, 27 Aug 2004 13:51:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <412F2E4E.4080300@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000000040903090901040408"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D75241EB
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2004 14:51:27 +0200 (MEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-35.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1C0gCU-000PqS-0Z
	for alsa-devel@alsa-project.org; Fri, 27 Aug 2004 12:51:26 +0000
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

This is a multi-part message in MIME format.
--------------000000040903090901040408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I attach a diff file against ./alsa-utils/alsamixer/alsamixer.c

It causes alsamixer to display 2 different views of the mixer controls.
One view shows only the "Playback" controls, the other view shows only 
the "Capture" controls, with a hidden mode (Press F1, then Enter) to 
show the old method of all controls together.

Cheers

James

--------------000000040903090901040408
Content-Type: text/plain;
 name="alsamixer-separate-play-capture.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsamixer-separate-play-capture.txt"

--- alsamixer.c.org	2004-08-13 12:01:34.000000000 +0100
+++ alsamixer.c	2004-08-27 13:44:29.132321190 +0100
@@ -167,6 +167,8 @@
 /* --- views --- */
 enum {
   VIEW_CHANNELS,
+  VIEW_PLAYBACK,
+  VIEW_CAPTURE,
   VIEW_HELP,
   VIEW_PROCINFO
 };
@@ -177,7 +179,7 @@
 static int	 mixer_needs_resize = 0;
 static int	 mixer_minimize = 0;
 static int	 mixer_no_lrcorner = 0;
-static int	 mixer_view = VIEW_CHANNELS;
+static int	 mixer_view = VIEW_PLAYBACK;
 static int	 mixer_max_x = 0;
 static int	 mixer_max_y = 0;
 static int	 mixer_ofs_x = 0;
@@ -227,6 +229,7 @@
 
 /* split scontrols */
 static int	 mixer_n_elems = 0;
+static int	 mixer_n_view_elems = 0;
 static int	 mixer_n_vis_elems = 0;
 static int	 mixer_first_vis_elem = 0;
 static int	 mixer_focus_elem = 0;
@@ -254,6 +257,8 @@
  " Esc     exit alsamixer\n"
  " F1      show Help screen\n"
  " F2      show /proc info screen\n"
+ " F3      show Playback controls only\n"
+ " F4      show Capture controls only\n"
  " Return  return to main screen\n"
  " Space   toggle Capture facility\n"
  " Tab     toggle ExactMode\n"
@@ -545,7 +550,7 @@
 
   if (mixer_sid == NULL)
     return;
-  
+
   sid = (snd_mixer_selem_id_t *)(((char *)mixer_sid) + snd_mixer_selem_id_sizeof() * mixer_grpidx[elem_index]);
   elem = snd_mixer_find_selem(mixer_handle, sid);
   if (elem == NULL)
@@ -758,7 +763,7 @@
       vright = vleft;
     }
   }
-  
+
   if (type == MIXER_ELEM_CAPTURE && snd_mixer_selem_has_capture_volume(elem)) {
     long vmin, vmax;
     snd_mixer_selem_get_capture_volume_range(elem, &vmin, &vmax);
@@ -779,7 +784,21 @@
     if (xlen > 63)
       xlen = 63;
     mixer_dc (DC_PROMPT);
-    mvaddstr (3, 2, "Item: ");
+    mvaddstr (3, 2, "View: ");
+    mixer_dc (DC_TEXT);
+    switch (mixer_view) {
+    case VIEW_PLAYBACK:
+      mvaddstr (3, 8, "Playback");
+      break;
+    case VIEW_CAPTURE:
+      mvaddstr (3, 8, "Capture");
+      break;
+    default:
+      mvaddstr (3, 8, "All");
+      break;
+    }
+    mixer_dc (DC_PROMPT);
+    mvaddstr (4, 2, "Item: ");
     mixer_dc (DC_TEXT);
     string1[8] = 0;
     for (i = 0; i < 63; i++)
@@ -952,7 +971,6 @@
   static int o_y = 0;
   int i, x, y;
   
-  
   if (!mixer_cbar_get_pos (mixer_focus_elem, &x, &y))
     {
       if (mixer_focus_elem < mixer_first_vis_elem)
@@ -961,15 +979,15 @@
 	mixer_first_vis_elem = mixer_focus_elem - mixer_n_vis_elems + 1;
       mixer_cbar_get_pos (mixer_focus_elem, &x, &y);
     }
-  if (mixer_first_vis_elem + mixer_n_vis_elems >= mixer_n_elems) {
-     mixer_first_vis_elem = mixer_n_elems - mixer_n_vis_elems;
+  if (mixer_first_vis_elem + mixer_n_vis_elems >= mixer_n_view_elems) {
+     mixer_first_vis_elem = mixer_n_view_elems - mixer_n_vis_elems;
      if (mixer_first_vis_elem < 0)
        mixer_first_vis_elem = 0;
      mixer_cbar_get_pos (mixer_focus_elem, &x, &y);
   }
   mixer_write_cbar(mixer_focus_elem);
   for (i = 0; i < mixer_n_vis_elems; i++) {
-    if (i + mixer_first_vis_elem >= mixer_n_elems)
+    if (i + mixer_first_vis_elem >= mixer_n_view_elems)
       continue;
     mixer_update_cbar (i + mixer_first_vis_elem);
   }
@@ -1521,53 +1539,57 @@
     elem = snd_mixer_find_selem(mixer_handle, sid);
     if (elem == NULL)
       CHECK_ABORT (ERR_FCN, "snd_mixer_find_selem()", -EINVAL);
-    for (i = 0; i < MIXER_ELEM_CAPTURE; i++) {
-      int ok;
-      for (j = ok = 0; j < 2; j++) {
-	if (mixer_changed_state)
-	  goto __again;
-	if (snd_mixer_selem_has_playback_channel(elem, mixer_elem_chn[i][j]))
-	  ok++;
+    if ( (mixer_view == VIEW_PLAYBACK) || (mixer_view == VIEW_CHANNELS) ) {
+      for (i = 0; i < MIXER_ELEM_CAPTURE; i++) {
+        int ok;
+        for (j = ok = 0; j < 2; j++) {
+	  if (mixer_changed_state)
+	    goto __again;
+ 	  if (snd_mixer_selem_has_playback_channel(elem, mixer_elem_chn[i][j]))
+	    ok++;
+        }
+        if (ok) {
+	  sid = (snd_mixer_selem_id_t *)(((char *)mixer_sid) + snd_mixer_selem_id_sizeof() * idx);
+	  mixer_grpidx[elem_index] = idx;
+	  if (snd_mixer_selem_is_enumerated(elem)) {
+	    mixer_type[elem_index] = MIXER_ELEM_ENUM;
+	  } else {
+	    mixer_type[elem_index] = i;
+	    if (i == 0 && snd_mixer_selem_has_playback_switch(elem))
+	      mixer_type[elem_index] |= MIXER_ELEM_MUTE_SWITCH;
+	    if (snd_mixer_selem_has_playback_volume(elem))
+	      mixer_type[elem_index] |= MIXER_ELEM_HAS_VOLUME;
+	  }
+	  elem_index++;
+	  nelems_added++;
+	  if (elem_index >= mixer_n_elems)
+	    break;
+        }
       }
-      if (ok) {
-	sid = (snd_mixer_selem_id_t *)(((char *)mixer_sid) + snd_mixer_selem_id_sizeof() * idx);
-	mixer_grpidx[elem_index] = idx;
-	if (snd_mixer_selem_is_enumerated(elem)) {
-	  mixer_type[elem_index] = MIXER_ELEM_ENUM;
-	} else {
-	  mixer_type[elem_index] = i;
-	  if (i == 0 && snd_mixer_selem_has_playback_switch(elem))
-	    mixer_type[elem_index] |= MIXER_ELEM_MUTE_SWITCH;
-	  if (snd_mixer_selem_has_playback_volume(elem))
-	    mixer_type[elem_index] |= MIXER_ELEM_HAS_VOLUME;
-	  if (i == 0 && snd_mixer_selem_has_capture_switch(elem))
-	    mixer_type[elem_index] |= MIXER_ELEM_CAPTURE_SWITCH;
-	}
-	elem_index++;
-	nelems_added++;
-	if (elem_index >= mixer_n_elems)
+    }
+
+    if ( (mixer_view == VIEW_CAPTURE) || (mixer_view == VIEW_CHANNELS) ) {
+      if (snd_mixer_selem_has_capture_volume(elem) ||
+	  (nelems_added == 0 && snd_mixer_selem_has_capture_switch(elem))) {
+        mixer_grpidx[elem_index] = idx;
+        mixer_type[elem_index] = MIXER_ELEM_CAPTURE;
+        if (nelems_added == 0 && snd_mixer_selem_has_capture_switch(elem))
+	  mixer_type[elem_index] |= MIXER_ELEM_CAPTURE_SWITCH;
+        if (nelems_added)
+	  mixer_type[elem_index] |= MIXER_ELEM_CAPTURE_SUFFIX;
+        if (snd_mixer_selem_has_capture_volume(elem))
+	  mixer_type[elem_index] |= MIXER_ELEM_HAS_VOLUME;
+        elem_index++;
+        if (elem_index >= mixer_n_elems)
 	  break;
       }
     }
-    if (snd_mixer_selem_has_capture_volume(elem) ||
-	(nelems_added == 0 && snd_mixer_selem_has_capture_switch(elem))) {
-      mixer_grpidx[elem_index] = idx;
-      mixer_type[elem_index] = MIXER_ELEM_CAPTURE;
-      if (nelems_added == 0 && snd_mixer_selem_has_capture_switch(elem))
-	mixer_type[elem_index] |= MIXER_ELEM_CAPTURE_SWITCH;
-      if (nelems_added)
-	mixer_type[elem_index] |= MIXER_ELEM_CAPTURE_SUFFIX;
-      if (snd_mixer_selem_has_capture_volume(elem))
-	mixer_type[elem_index] |= MIXER_ELEM_HAS_VOLUME;
-      elem_index++;
-      if (elem_index >= mixer_n_elems)
-	break;
-    }
   }
 
+  mixer_n_view_elems = elem_index;
   mixer_focus_elem = 0;
   if (focus_type >= 0) {
-    for (elem_index = 0; elem_index < mixer_n_elems; elem_index++) {
+    for (elem_index = 0; elem_index < mixer_n_view_elems; elem_index++) {
       sid = (snd_mixer_selem_id_t *)(((char *)mixer_sid) + snd_mixer_selem_id_sizeof() * mixer_grpidx[elem_index]);
       if (!strcmp(snd_mixer_selem_id_get_name(focus_gid),
                   snd_mixer_selem_id_get_name(sid)) &&
@@ -1619,7 +1641,7 @@
 
   /* required allocations */
   mixer_n_vis_elems = (mixer_max_x - mixer_ofs_x * 2 + 1) / 9;
-  mixer_n_vis_elems = CLAMP (mixer_n_vis_elems, 1, mixer_n_elems);
+  mixer_n_vis_elems = CLAMP (mixer_n_vis_elems, 1, mixer_n_view_elems);
   mixer_extra_space = mixer_max_x - mixer_ofs_x * 2 + 1 - mixer_n_vis_elems * 9;
   mixer_extra_space = MAX (0, mixer_extra_space / (mixer_n_vis_elems + 1));
   if (MIXER_TEXT_Y + 10 < mixer_max_y)
@@ -1769,9 +1791,13 @@
       break;
     case 13:	/* Return */
     case 10:	/* NewLine */
-      if (mixer_view == VIEW_CHANNELS)
+      if (mixer_view == VIEW_CHANNELS) {
 	mixer_clear (FALSE);
-      mixer_view = VIEW_CHANNELS;
+      } else {
+        mixer_view = VIEW_CHANNELS;
+        mixer_changed_state=1;
+        mixer_reinit ();
+      } 
       key = 0;
       break;
     case 'h':
@@ -1785,6 +1811,26 @@
       mixer_view = VIEW_PROCINFO;
       key = 0;
       break;
+    case KEY_F (3):
+      if (mixer_view == VIEW_PLAYBACK) {
+	mixer_clear (FALSE);
+      } else {
+        mixer_view = VIEW_PLAYBACK;
+        mixer_changed_state=1;
+        mixer_reinit ();
+      } 
+      key = 0;
+      break;
+    case KEY_F (4):
+      if (mixer_view == VIEW_CAPTURE) {
+	mixer_clear (FALSE);
+      } else {
+        mixer_view = VIEW_CAPTURE;
+        mixer_changed_state=1;
+        mixer_reinit ();
+      } 
+      key = 0;
+      break;
     case '\014':
     case 'L':
     case 'l':
@@ -1855,7 +1901,10 @@
 	break;
       }
   
-  if (key && mixer_view == VIEW_CHANNELS)
+  if (key && 
+    ((mixer_view == VIEW_CHANNELS) ||
+    (mixer_view == VIEW_PLAYBACK) ||
+    (mixer_view == VIEW_CAPTURE)) )
     switch (key)
       {
       case KEY_RIGHT:
@@ -1955,7 +2004,7 @@
   if (old_view != mixer_view)
     mixer_clear (FALSE);
   
-  mixer_focus_elem = CLAMP (mixer_focus_elem, 0, mixer_n_elems - 1);
+  mixer_focus_elem = CLAMP (mixer_focus_elem, 0, mixer_n_view_elems - 1);
   
   return finished;
 }
@@ -2027,7 +2076,7 @@
   mixer_init ();
   mixer_reinit ();
   
-  if (mixer_n_elems == 0) {
+  if (mixer_n_view_elems == 0) {
     fprintf(stderr, "No mixer elems found\n");
     mixer_abort (ERR_NONE, "", 0);
   }
@@ -2060,6 +2109,8 @@
 	  switch (mixer_view)
 	    {
 	    case VIEW_CHANNELS:
+	    case VIEW_PLAYBACK:
+	    case VIEW_CAPTURE:
 	      mixer_update_cbars ();
 	      break;
 	    case VIEW_HELP:

--------------000000040903090901040408--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
