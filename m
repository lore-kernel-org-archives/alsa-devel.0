From: Dave Dillow <dave@thedillows.org>
Subject: [RFC PATCH] alsactl: skip inactive controls
Date: Sat, 15 Dec 2007 14:13:41 -0500
Message-ID: <1197746021.24276.8.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knology.net (smtp.knology.net [24.214.63.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B62524701
	for <alsa-devel@alsa-project.org>; Sat, 15 Dec 2007 20:13:46 +0100 (CET)
Received: from obelisk.thedillows.org (obelisk.thedillows.org [192.168.0.10])
	by shed.thedillows.org (8.13.8/8.13.8) with ESMTP id lBFJDfD7032025
	for <alsa-devel@alsa-project.org>; Sat, 15 Dec 2007 14:13:42 -0500
Received: from obelisk.thedillows.org (localhost.localdomain [127.0.0.1])
	by obelisk.thedillows.org (8.14.1/8.13.8) with ESMTP id lBFJDfpT026997
	for <alsa-devel@alsa-project.org>; Sat, 15 Dec 2007 14:13:41 -0500
Received: (from il1@localhost)
	by obelisk.thedillows.org (8.14.1/8.14.1/Submit) id lBFJDftI026994
	for alsa-devel@alsa-project.org; Sat, 15 Dec 2007 14:13:41 -0500
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

When using alsactl to save or restore the card settings, it currently
skips over controls that don't have the appropriate read/write
permissions. It should also skip over inactive controls, otherwise it
will get an error when it tries to access that control, and will fail to
save the card state (or fully restore it.)
---
I noticed this while adding surround support to SiS7019. I think the
problem affects other cards, as I am following the pattern used by
trident, rme*, cmipci,  emu10k1 and others.

This is only for discussion, since I've not tested this (nor even
compiled it) but I think it will fix the issue.

diff -r d3ba62cd2776 alsactl/state.c
--- a/alsactl/state.c	Fri Dec 14 15:29:51 2007 +0100
+++ b/alsactl/state.c	Sat Dec 15 14:06:35 2007 -0500
@@ -250,7 +250,8 @@ static int get_control(snd_ctl_t *handle
 		return err;
 	}
 
-	if (!snd_ctl_elem_info_is_readable(info))
+	if (snd_ctl_elem_info_is_inactive(info) ||
+				!snd_ctl_elem_info_is_readable(info))
 		return 0;
 	snd_ctl_elem_value_set_id(ctl, id);
 	err = snd_ctl_elem_read(handle, ctl);
@@ -1306,7 +1307,8 @@ static int set_control(snd_ctl_t *handle
 		}
 	}
 
-	if (!snd_ctl_elem_info_is_writable(info))
+	if (snd_ctl_elem_info_is_inactive(info) ||
+				!snd_ctl_elem_info_is_writable(info))
 		return 0;
 	snd_ctl_elem_value_set_numid(ctl, numid1);
