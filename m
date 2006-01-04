From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Envy24control -tidy declarations after patches
Date: Wed, 4 Jan 2006 22:11:45 +0000
Message-ID: <200601042211.45775.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hgEvDnI3wAQnV2u"
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_hgEvDnI3wAQnV2u
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have noticed other redundant declarations in envy24control.c and .h 
following my previous patches, and prepared the following patch to tidy this 
up.

Summary: Tidy up redundant declarations.

Remove declarations in envy24control not needed following my previous patches.

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>

--Boundary-00=_hgEvDnI3wAQnV2u
Content-Type: text/x-diff;
  charset="us-ascii";
  name="e24c-1.0.10-AHmod3.6h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="e24c-1.0.10-AHmod3.6h.patch"

--- Denvy24control/envy24control.c	2006-01-04 17:12:56.000000000 +0000
+++ Aenvy24control/envy24control.c	2006-01-04 17:36:40.000000000 +0000
@@ -105,21 +112,16 @@
 
 GtkWidget *hw_spdif_input_coaxial_radio;
 GtkWidget *hw_spdif_input_optical_radio;
+GtkWidget *hw_spdif_switch_off_radio;
 
 GtkWidget *input_interface_internal;
 GtkWidget *input_interface_front_input;
 GtkWidget *input_interface_rear_input;
 GtkWidget *input_interface_wavetable;
 
-GtkWidget *hw_breakbox_led_on_radio;
-GtkWidget *hw_breakbox_led_off_radio;
-
 GtkWidget *hw_phono_input_on_radio;
 GtkWidget *hw_phono_input_off_radio;
 
-GtkWidget *hw_spdif_switch_on_radio;
-GtkWidget *hw_spdif_switch_off_radio;
-
 GtkObject *av_dac_volume_adj[10];
 GtkObject *av_adc_volume_adj[10];
 GtkObject *av_ipga_volume_adj[10];
diff -ru Denvy24control/envy24control.h Aenvy24control/envy24control.h
--- Denvy24control/envy24control.h	2004-05-16 14:36:30.000000000 +0100
+++ Aenvy24control/envy24control.h	2006-01-04 17:34:51.000000000 +0000
@@ -142,16 +142,11 @@
 
 extern GtkWidget *hw_spdif_input_coaxial_radio;
 extern GtkWidget *hw_spdif_input_optical_radio;
-
-extern GtkWidget *hw_breakbox_led_on_radio;
-extern GtkWidget *hw_breakbox_led_off_radio;
+extern GtkWidget *hw_spdif_switch_off_radio;
 
 extern GtkWidget *hw_phono_input_on_radio;
 extern GtkWidget *hw_phono_input_off_radio;
 
-extern GtkWidget *hw_spdif_switch_on_radio;
-extern GtkWidget *hw_spdif_switch_off_radio;
-
 extern GtkWidget *input_interface_internal;
 extern GtkWidget *input_interface_front_input;
 extern GtkWidget *input_interface_rear_input;
@@ -210,8 +208,6 @@
 void spdif_input_update(void);
 void spdif_input_toggled(GtkWidget *togglebutton, gpointer data);
 void analog_input_select_toggled(GtkWidget *togglebutton, gpointer data);
-void breakbox_led_toggled(GtkWidget *togglebutton, gpointer data);
-void spdif_on_off_toggled(GtkWidget *togglebutton, gpointer data);
 void phono_input_toggled(GtkWidget *togglebutton, gpointer data);
 
 void hardware_init(void);

--Boundary-00=_hgEvDnI3wAQnV2u--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
