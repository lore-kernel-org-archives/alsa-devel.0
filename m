From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] echomixer update 2/4
Date: Sun, 16 Jan 2005 20:22:17 +0100
Message-ID: <20050116202217.32e1c384.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



- Bugfix: Makes sure that the "changed" event will be triggered when we will
set the right value (the trick of setting an out of range value do not work
anymore with gtk+-2.x).

- Bugfix: Same as above for toggle buttons.



Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-tools/echomixer/echomixer.c_old	Sun Jan 16 18:29:20 2005
+++ alsa-tools/echomixer/echomixer.c	Sat Jan 15 17:43:54 2005
@@ -1865,7 +1865,7 @@
   GtkWidget *vbsel, *frame, *button;
   GtkWidget *label, *menu, *menuitem;
   GSList *bgroup;
-  int err, i, o, n, cardnum;
+  int err, i, o, n, cardnum, value;
   char hwname[8], cardname[32], load, save;
   snd_ctl_card_info_t *hw_info;
 
@@ -2049,6 +2049,7 @@
       p4dbuIn[i]=gtk_toggle_button_new_with_label(str);
       gtk_box_pack_start(GTK_BOX(hbox), p4dbuIn[i], TRUE, FALSE, 1);
       gtk_widget_show(p4dbuIn[i]);
+      gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(p4dbuIn[i]), NominalIn[i]);	// Forces handler call
       gtk_signal_connect(GTK_OBJECT(p4dbuIn[i]), "toggled", GTK_SIGNAL_FUNC(Nominal_level_toggled), (gpointer)i);
       gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(p4dbuIn[i]), !NominalIn[i]);
     }
@@ -2069,6 +2070,7 @@
       p4dbuOut[i]=gtk_toggle_button_new_with_label(str);
       gtk_box_pack_start(GTK_BOX(hbox), p4dbuOut[i], TRUE, FALSE, 1);
       gtk_widget_show(p4dbuOut[i]);
+      gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(p4dbuOut[i]), NominalOut[i]);
       gtk_signal_connect(GTK_OBJECT(p4dbuOut[i]), "toggled", GTK_SIGNAL_FUNC(Nominal_level_toggled), (gpointer)(i+ECHO_MAXAUDIOINPUTS));
       gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(p4dbuOut[i]), !NominalOut[i]);
     }
@@ -2209,7 +2211,8 @@
       gtk_widget_show(label);
       gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
       // Volume
-      pcmoutControl.adj[i]=gtk_adjustment_new(999, ECHOGAIN_MINOUT, ECHOGAIN_MAXOUT, SHORTSTEP, LONGSTEP, 0);
+      value = INVERT(pcmoutControl.Gain[i]);
+      pcmoutControl.adj[i]=gtk_adjustment_new(!value, ECHOGAIN_MINOUT, ECHOGAIN_MAXOUT, SHORTSTEP, LONGSTEP, 0);
       pcmoutControl.volume[i]=gtk_vscale_new(GTK_ADJUSTMENT(pcmoutControl.adj[i]));
       gtk_widget_show(pcmoutControl.volume[i]);
       gtk_box_pack_start(GTK_BOX(vbox), pcmoutControl.volume[i], TRUE, TRUE, 0);
@@ -2219,7 +2222,7 @@
       pcmoutControl.label[i]=gtk_label_new("xxx");
       gtk_widget_show(pcmoutControl.label[i]);
       gtk_box_pack_start(GTK_BOX(vbox), pcmoutControl.label[i], FALSE, FALSE, 0);
-      gtk_adjustment_set_value(GTK_ADJUSTMENT(pcmoutControl.adj[i]), INVERT(pcmoutControl.Gain[i]));
+      gtk_adjustment_set_value(GTK_ADJUSTMENT(pcmoutControl.adj[i]), value);
     }
     gtk_widget_set_usize(GTK_WIDGET(pcmoutControl.volume[0]), 0, 170);		// Set minimum y size
   }
@@ -2261,7 +2264,8 @@
       gtk_widget_show(label);
       gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
       // Volume (resolution is 0.5 dB)
-      lineinControl.adj[i]=gtk_adjustment_new(999, ECHOGAIN_MININP, ECHOGAIN_MAXINP, SHORTSTEP, LONGSTEP*2, 0);
+      value = IN_INVERT(lineinControl.Gain[i]);
+      lineinControl.adj[i]=gtk_adjustment_new(!value, ECHOGAIN_MININP, ECHOGAIN_MAXINP, SHORTSTEP, LONGSTEP*2, 0);
       lineinControl.volume[i]=gtk_vscale_new(GTK_ADJUSTMENT(lineinControl.adj[i]));
       gtk_widget_show(lineinControl.volume[i]);
       gtk_box_pack_start(GTK_BOX(vbox), lineinControl.volume[i], TRUE, TRUE, 0);
@@ -2271,7 +2275,7 @@
       lineinControl.label[i]=gtk_label_new("xxx");
       gtk_widget_show(lineinControl.label[i]);
       gtk_box_pack_start(GTK_BOX(vbox), lineinControl.label[i], FALSE, FALSE, 0);
-      gtk_adjustment_set_value(GTK_ADJUSTMENT(lineinControl.adj[i]), IN_INVERT(lineinControl.Gain[i]));
+      gtk_adjustment_set_value(GTK_ADJUSTMENT(lineinControl.adj[i]), value);
     }
     gtk_widget_set_usize(GTK_WIDGET(lineinControl.volume[0]), 0, 170);	// Set minimum y size
   }
@@ -2299,7 +2303,8 @@
       gtk_widget_show(label);
       gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
       // Volume
-      lineoutControl.adj[i]=gtk_adjustment_new(0, ECHOGAIN_MINOUT, ECHOGAIN_MAXOUT, SHORTSTEP, LONGSTEP, 0);
+      value = INVERT(lineoutControl.Gain[i]);
+      lineoutControl.adj[i]=gtk_adjustment_new(!value, ECHOGAIN_MINOUT, ECHOGAIN_MAXOUT, SHORTSTEP, LONGSTEP, 0);
       lineoutControl.volume[i]=gtk_vscale_new(GTK_ADJUSTMENT(lineoutControl.adj[i]));
       gtk_widget_show(lineoutControl.volume[i]);
       gtk_box_pack_start(GTK_BOX(vbox), lineoutControl.volume[i], TRUE, TRUE, 0);
@@ -2309,7 +2314,7 @@
       lineoutControl.label[i]=gtk_label_new("xxx");
       gtk_widget_show(lineoutControl.label[i]);
       gtk_box_pack_start(GTK_BOX(vbox), lineoutControl.label[i], FALSE, FALSE, 0);
-      gtk_adjustment_set_value(GTK_ADJUSTMENT(lineoutControl.adj[i]), INVERT(lineoutControl.Gain[i]));
+      gtk_adjustment_set_value(GTK_ADJUSTMENT(lineoutControl.adj[i]), value);
     }
     gtk_widget_set_usize(GTK_WIDGET(lineoutControl.volume[0]), 0, 170);		// Set minimum y size
   }




--
Giuliano.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
