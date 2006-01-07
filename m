From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: re: Envy24control -changes on screen
Date: Sat, 7 Jan 2006 00:51:58 +0000
Message-ID: <200601070051.12458.gineera@aspect135.co.uk>
References: <200512162315.43124.gineera@aspect135.co.uk> <s5hoe2smc6h.wl%tiwai@suse.de> <200601061001.38397.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uCxvDnktDmMTaL9"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200601061001.38397.gineera@aspect135.co.uk>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_uCxvDnktDmMTaL9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 06 January 2006 10:01, I wrote:
> On Wednesday 04 January 2006 12:04, you wrote:
> > > Thanks to you also.
> > > Will this result in envy24control version number being raised?  It has
> > > been at 0.5.0 since at least alsa1.0.8?
> >
> > That makes sense.
> >
> > Could you create a patch together with replacements of
> > GTK_POLICY_AUTOMATIC?
> >
> >
> > Takashi
>
> What should new envy24control version be - '0.5.2' or '0.6.0', or something
> else?
> GTK_POLICY_AUTOMATIC part is ready to post.

Later I thought I may as well send this patch, as you can change it to 
whatever version number is prefered -I've done 0.6.0.  The part in configure 
is presumably not essential since it is re-generated from configure.in?  

Really wouldn't it be better to have the version just set in one place?  
Ideally, I would have thought, at every stable alsa release the minor version 
number would increase if there have been changes to that program, so a user 
can tell if he is compiling a different binary?

Alan

Summary: Change scroll policy in envy24control

Change gtk scroll policy for the main notebook pages in envy24control from 
ALWAYS to AUTOMATIC;  also raise envy24control version.

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>

--Boundary-00=_uCxvDnktDmMTaL9
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="e24c-1.0.10-AHmod3.7d.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="e24c-1.0.10-AHmod3.7d.patch"

diff -ru Denvy24control/configure Aenvy24control/configure
--- Denvy24control/configure	2005-11-16 17:15:47.000000000 +0000
+++ Aenvy24control/configure	2006-01-06 23:52:22.000000000 +0000
@@ -1509,7 +1509,7 @@
 
 # Define the identity of the package.
  PACKAGE=envy24control
- VERSION=0.5.0
+ VERSION=0.6.0
 
 
 cat >>confdefs.h <<_ACEOF
diff -ru Denvy24control/configure.in Aenvy24control/configure.in
--- Denvy24control/configure.in	2004-05-16 14:36:30.000000000 +0100
+++ Aenvy24control/configure.in	2006-01-06 23:47:56.000000000 +0000
@@ -1,5 +1,5 @@
 AC_INIT(envy24control.c)
-AM_INIT_AUTOMAKE(envy24control, 0.5.0)
+AM_INIT_AUTOMAKE(envy24control, 0.6.0)
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
diff -ru Denvy24control/configure.in-gtk2 Aenvy24control/configure.in-gtk2
--- Denvy24control/configure.in-gtk2	2004-05-16 14:36:30.000000000 +0100
+++ Aenvy24control/configure.in-gtk2	2006-01-06 23:41:49.000000000 +0000
@@ -1,5 +1,5 @@
 AC_INIT(envy24control.c)
-AM_INIT_AUTOMAKE(envy24control, 0.5.0)
+AM_INIT_AUTOMAKE(envy24control, 0.6.0)
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
diff -ru Denvy24control/envy24control.c Aenvy24control/envy24control.c
--- Denvy24control/envy24control.c	2006-01-04 17:12:56.000000000 +0000
+++ Aenvy24control/envy24control.c	2006-01-04 22:43:18.000000000 +0000
@@ -308,7 +303,7 @@
 	gtk_widget_show(scrolledwindow);
 	gtk_box_pack_start(GTK_BOX(hbox), scrolledwindow, TRUE, TRUE, 0);
 	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolledwindow),
-					GTK_POLICY_ALWAYS, GTK_POLICY_NEVER);
+					GTK_POLICY_AUTOMATIC, GTK_POLICY_NEVER);
 
 	viewport = gtk_viewport_new(NULL, NULL);
 	gtk_widget_show(viewport);
@@ -361,7 +356,7 @@
 	gtk_widget_show(scrolledwindow);
 	gtk_box_pack_start(GTK_BOX(hbox), scrolledwindow, TRUE, TRUE, 0);
 	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolledwindow), 
-					GTK_POLICY_ALWAYS, GTK_POLICY_NEVER);
+					GTK_POLICY_AUTOMATIC, GTK_POLICY_NEVER);
 
 	viewport = gtk_viewport_new(NULL, NULL);
 	gtk_widget_show(viewport);
@@ -524,7 +519,7 @@
 	gtk_widget_show(scrolledwindow);
 	gtk_container_add(GTK_CONTAINER(notebook), scrolledwindow);
 	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolledwindow), 
-				       GTK_POLICY_ALWAYS, GTK_POLICY_NEVER);
+				       GTK_POLICY_AUTOMATIC, GTK_POLICY_NEVER);
 
         label = gtk_label_new("Patchbay / Router");
         gtk_widget_show(label);
@@ -1346,7 +1341,7 @@
 	gtk_widget_show(scrolledwindow);
 	gtk_box_pack_start(GTK_BOX(hbox), scrolledwindow, TRUE, TRUE, 0);
 	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolledwindow),
-					GTK_POLICY_ALWAYS, GTK_POLICY_NEVER);
+					GTK_POLICY_AUTOMATIC, GTK_POLICY_NEVER);
 
 	viewport = gtk_viewport_new(NULL, NULL);
 	gtk_widget_show(viewport);
@@ -1412,7 +1407,7 @@
 	gtk_widget_show(scrolledwindow);
 	gtk_box_pack_start(GTK_BOX(hbox), scrolledwindow, TRUE, TRUE, 0);
 	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolledwindow),
-					GTK_POLICY_ALWAYS, GTK_POLICY_NEVER);
+					GTK_POLICY_AUTOMATIC, GTK_POLICY_NEVER);
 
 	viewport = gtk_viewport_new(NULL, NULL);
 	gtk_widget_show(viewport);
@@ -1493,7 +1488,7 @@
 				   label);
 
 	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolledwindow), 
-				       GTK_POLICY_ALWAYS, GTK_POLICY_NEVER);
+				       GTK_POLICY_AUTOMATIC, GTK_POLICY_NEVER);
 	viewport = gtk_viewport_new(NULL, NULL);
 	gtk_widget_show(viewport);
 	gtk_container_add(GTK_CONTAINER(scrolledwindow), viewport);
@@ -1842,7 +1837,7 @@
 	gtk_widget_show(scrolledwindow);
 	gtk_box_pack_start(GTK_BOX(hbox), scrolledwindow, TRUE, TRUE, 0);
 	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolledwindow),
-					GTK_POLICY_ALWAYS, GTK_POLICY_NEVER);
+					GTK_POLICY_AUTOMATIC, GTK_POLICY_NEVER);
 
 	viewport = gtk_viewport_new(NULL, NULL);
 	gtk_widget_show(viewport);

--Boundary-00=_uCxvDnktDmMTaL9--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
