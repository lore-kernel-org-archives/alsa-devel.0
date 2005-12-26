From: John Rigg <ad@sound-man.co.uk>
Subject: envy24control wordclock text patch
Date: Mon, 26 Dec 2005 16:08:33 +0000
Message-ID: <20051226160833.GA4940@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I reported a bug in envy24control about the text displayed when using
the BNC word clock input on a Delta 1010 (bug id 0001677). It says
`No signal' when locked and `Locked' when there's no signal. I wasn't
sure how to submit a patch using the Bugtrack interface, so I've
attached it here (this fixes it in alsa-tools-1.0.10).

John

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="envy24control-wclocktext-patch-1.0.10"

diff -uprN alsa-tools-1.0.10/envy24control/hardware.c alsa-tools-patched/envy24control/hardware.c
--- alsa-tools/envy24control/hardware.c	2004-04-16 14:09:35.000000000 +0100
+++ alsa-tools/envy24control/hardware.c	2005-12-26 15:09:16.000000000 +0000
@@ -170,7 +170,7 @@ gint master_clock_status_timeout_callbac
 	if ((err = snd_ctl_elem_read(ctl, sw)) < 0)
 		g_print("Unable to determine word clock status: %s\n", snd_strerror(err));
 	gtk_label_set_text(GTK_LABEL(hw_master_clock_status_label),
-			   snd_ctl_elem_value_get_boolean(sw, 0) ? "Locked" : "No signal");
+			   snd_ctl_elem_value_get_boolean(sw, 0) ? "No signal" : "Locked");
 	return TRUE;
 }
 

--oyUTqETQ0mS9luUI--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
