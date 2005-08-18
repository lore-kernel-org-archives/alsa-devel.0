From: Alan H <alan@horstmann.fsworld.co.uk>
Subject: Re: Envy24control -SPDIF bug and maybe improvements?
Date: Thu, 18 Aug 2005 23:33:24 +0100
Message-ID: <200508182333.24454.alan@horstmann.fsworld.co.uk>
References: <200507262109.54095.alan@horstmann.fsworld.co.uk> <Pine.LNX.4.61.0507270902130.8129@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0yQBDKB0y75W8pL"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0507270902130.8129@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_0yQBDKB0y75W8pL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Regarding envy24control SPDIF bug (bugtrack alsa-tools 
0001214), attached are 2 patches, and readme file.
AHmod1.2 simply fixes bug but note the 
snd_ctl_elem_value_set_boolean(spdif_on_off,..) seems to work in reverse 
elsewhere, which is compensated for here (maybe needs sorting in the 
driver?).
AHmod2.3 also changes the controls for DMX6fire, to correct breakbox LED and 
other odds.
Patch needs the -l option for these to suceed; both are against alsa1.0.9.

Version3.2
I also have produced a version with more extensive and general changes/
improvements, but the diff is 50K.  It would be helpful if users of 
envy24control would try this out to see if it is liked, by taking the files 
from the tarball attached.  If there is interest I could try to sort 
patching.

Regards           Alan

On Wednesday 27 July 2005 08:04, Jaroslav Kysela wrote:
> On Tue, 26 Jul 2005, Alan H wrote:
> > Hi,
> >
> > Recently I reported a bug with DMX6fire and SPDIF inputs (bugtrack
> > alsa-tools 0001214), and then, as reported there, happened to find the
> > problem myself when perusing the source code.
> >
> > As a user of the DMX6fire and an electronics engineer, I am newish to
> > Linux and software.  However, as I had ended up looking at the source
> > code and had ideas for improvements to the controls and usability of
> > 'e24c', I altered it in stages, and resulted in a neater, easier version
> > for me to use.
> >
> > How can this alternative be considered/made available for others -for
> > example where could I put a tarball of the 3 major version stages of the
> > changed files?  These versions are all up to date with the released
> > alsa-1.0.9.
> >
> > Is there a better way to approach such development, if I am considering
> > other improvements?
>
> Please, provide us a patch against ALSA 1.0.9 or better against ALSA CVS..
> Patch can be generated via this command:
>
> diff -ru <old_dir> <new_dir>
>
> We will review the patch and if it's ok, we'll apply it to ALSA
> mainstream.
>
> 						Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SUSE Labs
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_0yQBDKB0y75W8pL
Content-Type: text/plain;
  charset="iso-8859-1";
  name="AHmoded-readme"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="AHmoded-readme"

Notes to go with AHmoded versions of envy24control files

Alan Horstmann
Date  27.7.2005

The associated files contain improved(?) versions of the envy24control utility, in increasing
levels of changes.

Version 1.2
This started with bug-fixing SPDIF input on/off not functioning which
turns out to be a simple variable error in hardware.c.  However, the snd_ctl_elem_value
for spdif_on_off works in reverse (this is seen in alsamixer also) and so I have reversed the
action here to compensate.  Just these changes are in version 1.2, which simply affects
hardware.c in the envy24control files.

Version 2.3
As a Terratec DMX6fire user, some extra controls are presented, and I can compare to the
Terratec driver for Microsoft Windows.  The 'breakbox LED' is supposed to indicate when front
panel input is selected, so in this version that is what happens.  The separate user switch has
been removed.  Also some control label/titles are changed to make more sense with the DMX6fire.
Both envy24control.c and hardware.c need to be altered.

Version 3.2
To improve usability further the screen interface has been altered slightly, to permit a
smaller minimum screen size, scrolling all pages and splitting input meters from pcm meters.
Pop-up menu is enabled.  Controls on the hardware page are re-arranged so the most often used
can be accessed quickley, and the SPDIF controls combined to a single input selector.  The
precise size seems to depend on gtk theme used, but is much smaller than before.  Finally an
extra command line option is added, '-w..' which allows the initial width of the window to be
set, either as a number of channels (1-20) or as a pixel number (>20).  Changes are thus
required to envy24control.c, hardware.c and levelmeters.c.


Both version 2.3 and 3.2 have a temporary mod comment in the 'About' page.
All the above files have been brought up to date to alsa-1.0.9 and have been checked with it.

--Boundary-00=_0yQBDKB0y75W8pL
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="envy24control-1.0.9-AHmod1.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="envy24control-1.0.9-AHmod1.2.patch"


diff -ru envy24control/hardware.c Aenvy24control/hardware.c
--- envy24control/hardware.c	2004-04-16 14:09:35.000000000 +0100
+++ Aenvy24control/hardware.c	2005-07-25 15:16:09.000000000 +0100
@@ -1,6 +1,6 @@
 /*****************************************************************************
    hardware.c - Hardware Settings
-   Copyright (C) 2000 by Jaroslav Kysela <perex@suse.cz>
+   Copyright (C) 2000 by Jaroslav Kysela <perex@suse.cz> APH Modded 29.6.05 inc1.0.9
    
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
@@ -720,9 +720,11 @@
         if ((err = snd_ctl_elem_read(ctl, spdif_on_off)) < 0)
                 g_print("Unable to read S/PDIF on/off switch: %s\n", snd_strerror(err));
         if (snd_ctl_elem_value_get_boolean(spdif_on_off, 0)) {
-                toggle_set(hw_spdif_switch_on_radio, TRUE);
-        } else {
+			/* Logic reversed to correct button action */
+			/* The cause is elsewhere. AH 29.6.2005    */
                 toggle_set(hw_spdif_switch_off_radio, TRUE);
+        } else {
+                toggle_set(hw_spdif_switch_on_radio, TRUE);
         }
 }
 
@@ -734,10 +736,12 @@
         if (!is_active(togglebutton))
                 return;
         if (!strcmp(str, "On"))
-                snd_ctl_elem_value_set_boolean(spdif_input, 0, 1);
+                snd_ctl_elem_value_set_boolean(spdif_on_off, 0, 0);
+			/* Logic reversed to correct button action */
+			/* The cause is elsewhere. AH 29.6.2005    */
         else
-                snd_ctl_elem_value_set_boolean(spdif_input, 0, 0);
-        if ((err = snd_ctl_elem_write(ctl, spdif_input)) < 0)
+                snd_ctl_elem_value_set_boolean(spdif_on_off, 0, 1);
+        if ((err = snd_ctl_elem_write(ctl, spdif_on_off)) < 0)
                 g_print("Unable to write S/PDIF on/off switch: %s\n", snd_strerror(err));
 }



--Boundary-00=_0yQBDKB0y75W8pL
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="envy24control-1.0.9-AHmod2.3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="envy24control-1.0.9-AHmod2.3.patch"

diff -ru envy24control/envy24control.c Aenvy24control/envy24control.c
--- envy24control/envy24control.c       2005-05-24 17:52:18.000000000 +0100
+++ Aenvy24control/envy24control.c      2005-07-27 13:01:21.000000000 +0100
@@ -3,7 +3,7 @@
    Copyright (C) 2000 by Jaroslav Kysela <perex@suse.cz>

    (2003/03/22) Changed to hbox/vbox layout.
-   Copyright (C) 2003 by S??ren Wedel Nielsen
+   Copyright (C) 2003 by S??ren Wedel Nielsen   APH mod v2.3 Date 25.7.05 inc1.0.9

    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
@@ -1162,7 +1162,7 @@
        if((card_eeprom.subvendor == ICE1712_SUBDEVICE_DELTADIO2496) || (card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE))
                hide = 0;

-       frame = gtk_frame_new("S/PDIF Input");
+       frame = gtk_frame_new("Front Digital In");
        gtk_widget_show(frame);
        gtk_box_pack_start(GTK_BOX(box), frame, FALSE, TRUE, 0);
        gtk_container_set_border_width(GTK_CONTAINER(frame), 6);
@@ -1205,7 +1205,7 @@
         if( card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE)
                 hide = 0;

-        frame = gtk_frame_new("S/PDIF On/Off");
+        frame = gtk_frame_new("Digital Input");
         gtk_widget_show(frame);
         gtk_box_pack_start(GTK_BOX(box), frame, FALSE, TRUE, 0);
         gtk_container_set_border_width(GTK_CONTAINER(frame), 6);
@@ -1215,29 +1215,29 @@
         gtk_container_add(GTK_CONTAINER(frame), vbox);
         gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);

-        radiobutton = gtk_radio_button_new_with_label(group, "On");
-        hw_spdif_switch_on_radio = radiobutton;
+        radiobutton = gtk_radio_button_new_with_label(group, "Internal CD");
+        hw_spdif_switch_off_radio = radiobutton;
         group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
         gtk_widget_show(radiobutton);
         gtk_box_pack_start(GTK_BOX(vbox), radiobutton, FALSE, FALSE, 0);
         gtk_signal_connect(GTK_OBJECT(radiobutton), "toggled",
                           (GtkSignalFunc)spdif_on_off_toggled,
-                          (gpointer)"On");
+                          (gpointer)"Off");

-        radiobutton = gtk_radio_button_new_with_label(group, "Off");
-        hw_spdif_switch_off_radio = radiobutton;
+        radiobutton = gtk_radio_button_new_with_label(group, "Front Digital In");
+        hw_spdif_switch_on_radio = radiobutton;
         group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
         gtk_widget_show(radiobutton);
         gtk_box_pack_start(GTK_BOX(vbox), radiobutton, FALSE, FALSE, 0);
         gtk_signal_connect(GTK_OBJECT(radiobutton), "toggled",
                           (GtkSignalFunc)spdif_on_off_toggled,
-                          (gpointer)"Off");
+                          (gpointer)"On");

         if(hide)
                 gtk_widget_hide_all(frame);
 }

-static void create_breakbox_led(GtkWidget *box)
+/*static void create_breakbox_led(GtkWidget *box)
 {
         GtkWidget *frame;
         GtkWidget *vbox;
@@ -1278,7 +1278,7 @@

         if(hide)
                 gtk_widget_hide_all(frame);
-}
+}*/

 static void create_phono_input(GtkWidget *box)
 {
@@ -1416,13 +1416,13 @@
        create_actual_rate(vbox);
        create_volume_change(vbox);

-       create_spdif_output_settings(hbox);
+       create_spdif_output_settings(hbox);

-       create_spdif_input_select(vbox2);
        create_input_interface(vbox2);
-       create_breakbox_led(vbox2);
+       /*create_breakbox_led(vbox2);*/
        create_phono_input(vbox2);
        create_spdif_on_off(vbox2);
+       create_spdif_input_select(vbox2);
 }

 static void create_about(GtkWidget *main, GtkWidget *notebook, int page)
@@ -1446,7 +1446,7 @@
        gtk_box_pack_start(GTK_BOX(vbox), label, TRUE, TRUE, 6);

        /* create first line */
-       label = gtk_label_new("Envy24 Control Utility " VERSION);
+       label = gtk_label_new("Envy24 Control Utility APH MOD 2.3-4.7.05 v" VERSION);
         gtk_widget_show(label);
        gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, TRUE, 6);

diff -ru envy24control/hardware.c Aenvy24control/hardware.c
--- envy24control/hardware.c    2004-04-16 14:09:35.000000000 +0100
+++ Aenvy24control/hardware.c   2005-07-27 13:08:50.000000000 +0100
@@ -1,6 +1,6 @@
 /*****************************************************************************
    hardware.c - Hardware Settings
-   Copyright (C) 2000 by Jaroslav Kysela <perex@suse.cz>
+   Copyright (C) 2000 by Jaroslav Kysela <perex@suse.cz> APH Modded v2.3 Date 25.7.05 inc1.0.9

    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
@@ -664,27 +665,33 @@
 void analog_input_select_toggled(GtkWidget *togglebutton, gpointer data)
 {
        char *what = (char *) data;
+       int err;

         if (!is_active(togglebutton))
                 return;
+       //g_print("Anal i/p togg");
         if (!strcmp(what, "Internal")) {
                 analog_input_select_set(0);
+               snd_ctl_elem_value_set_boolean(breakbox_led, 0, 0);
         } else if (!strcmp(what, "Front Input")) {
                 analog_input_select_set(1);
+               snd_ctl_elem_value_set_boolean(breakbox_led, 0, 1);
         } else if (!strcmp(what, "Rear Input")) {
                 analog_input_select_set(2);
+               snd_ctl_elem_value_set_boolean(breakbox_led, 0, 0);
         } else if (!strcmp(what, "Wave Table")) {
                 analog_input_select_set(3);
+               snd_ctl_elem_value_set_boolean(breakbox_led, 0, 0);
         } else {
                 g_print("analog_input_select_toggled: %s ???\n", what);
         }
+       if ((err = snd_ctl_elem_write(ctl, breakbox_led)) < 0)
+               g_print("Unable to write breakbox LED switch: %s\n", snd_strerror(err));
 }

-
-void breakbox_led_update(void)
+/*void breakbox_led_update(void)
 {
        int err;
-
         if (card_eeprom.subvendor != ICE1712_SUBDEVICE_DMX6FIRE)
                return;
        if ((err = snd_ctl_elem_read(ctl, breakbox_led)) < 0)
@@ -695,21 +702,20 @@
                 toggle_set(hw_breakbox_led_off_radio, TRUE);
        }
 }
-
-void breakbox_led_toggled(GtkWidget *togglebutton, gpointer data)
+ void breakbox_led_toggled(GtkWidget *togglebutton, gpointer data)
 {
        int err;
                char *str = (char *)data;
-
         if (!is_active(togglebutton))
                return;
+       g_print("LED togg");
        if (!strcmp(str, "On"))
                        snd_ctl_elem_value_set_boolean(breakbox_led, 0, 1);
        else
                        snd_ctl_elem_value_set_boolean(breakbox_led, 0, 0);
        if ((err = snd_ctl_elem_write(ctl, breakbox_led)) < 0)
                g_print("Unable to write breakbox LED switch: %s\n", snd_strerror(err));
-}
+}*/

 void spdif_on_off_update(void)
 {
@@ -720,9 +726,11 @@
         if ((err = snd_ctl_elem_read(ctl, spdif_on_off)) < 0)
                 g_print("Unable to read S/PDIF on/off switch: %s\n", snd_strerror(err));
         if (snd_ctl_elem_value_get_boolean(spdif_on_off, 0)) {
-                toggle_set(hw_spdif_switch_on_radio, TRUE);
+                       /* Logic reversed to correct button action */
+                       /* The cause is elsewhere. AH 29.6.2005    */
+               toggle_set(hw_spdif_switch_off_radio, TRUE);
         } else {
-                toggle_set(hw_spdif_switch_off_radio, TRUE);
+                toggle_set(hw_spdif_switch_on_radio, TRUE);
         }
 }

@@ -734,10 +742,12 @@
         if (!is_active(togglebutton))
                 return;
         if (!strcmp(str, "On"))
-                snd_ctl_elem_value_set_boolean(spdif_input, 0, 1);
-        else
-                snd_ctl_elem_value_set_boolean(spdif_input, 0, 0);
-        if ((err = snd_ctl_elem_write(ctl, spdif_input)) < 0)
+                snd_ctl_elem_value_set_boolean(spdif_on_off, 0, 0);
+                       /* Logic reversed to correct button action */
+                       /* The cause is elsewhere. AH 14.7.2005    */
+       else
+                snd_ctl_elem_value_set_boolean(spdif_on_off, 0, 1);
+        if ((err = snd_ctl_elem_write(ctl, spdif_on_off)) < 0)
                 g_print("Unable to write S/PDIF on/off switch: %s\n", snd_strerror(err));
 }

@@ -841,7 +851,7 @@
        spdif_input_update();
        spdif_output_update();
        analog_input_select_update();
-       breakbox_led_update();
+       /*breakbox_led_update();*/
        spdif_on_off_update();
        phono_input_update();
 }

--Boundary-00=_0yQBDKB0y75W8pL
Content-Type: application/x-tbz;
  name="AHmodedE24c.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="AHmodedE24c.tar.bz2"

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

--Boundary-00=_0yQBDKB0y75W8pL--



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
