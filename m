From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] echoaudio 2/2
Date: Sat, 26 Mar 2005 23:32:55 +0100
Message-ID: <20050326233255.2bb694d6.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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


- Minor cleanup: move range checking inside the clt callback.


Signed-off-by: Giulisno Pochini <pochini@shiny.it>

Common subdirectories: alsa-driver_1_automute/pci/echoaudio/CVS and alsa-driver/pci/echoaudio/CVS
diff -du alsa-driver_1_automute/pci/echoaudio/echoaudio.c alsa-driver/pci/echoaudio/echoaudio.c
--- alsa-driver_1_automute/pci/echoaudio/echoaudio.c	Sat Mar 26 21:43:28 2005
+++ alsa-driver/pci/echoaudio/echoaudio.c	Sat Mar 26 21:45:29 2005
@@ -1455,9 +1455,6 @@
 /******************* Phantom power switch *******************/
 static int snd_echo_phantom_power_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
 {
-	echoaudio_t *chip;
-
-	chip = snd_kcontrol_chip(kcontrol);
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	uinfo->count = 1;
 	uinfo->value.integer.min = 0;
@@ -1468,22 +1465,23 @@
 static int snd_echo_phantom_power_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
 	echoaudio_t *chip = snd_kcontrol_chip(kcontrol);
+
 	ucontrol->value.integer.value[0] = chip->phantom_power;
 	return 0;
 }
 
 static int snd_echo_phantom_power_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
-	echoaudio_t *chip;
-	int changed = 0;
+	echoaudio_t *chip = snd_kcontrol_chip(kcontrol);
+	int power, changed = 0;
 
-	chip = snd_kcontrol_chip(kcontrol);
-	if (chip->phantom_power != !!ucontrol->value.integer.value[0]) {
+	power = !!ucontrol->value.integer.value[0];
+	if (chip->phantom_power != power) {
 		spin_lock_irq(&chip->lock);
-		changed = set_phantom_power(chip, ucontrol->value.integer.value[0]);
+		changed = set_phantom_power(chip, power);
+		spin_unlock_irq(&chip->lock);
 		if (changed == 0)
 			changed = 1;	/* no errors */
-		spin_unlock_irq(&chip->lock);
 	}
 	return changed;
 }
diff -du alsa-driver_1_automute/pci/echoaudio/gina3g_dsp.c alsa-driver/pci/echoaudio/gina3g_dsp.c
--- alsa-driver_1_automute/pci/echoaudio/gina3g_dsp.c	Sat Mar 26 21:43:28 2005
+++ alsa-driver/pci/echoaudio/gina3g_dsp.c	Sat Mar 26 21:45:43 2005
@@ -106,7 +106,7 @@
 	else
 		control_reg &= ~E3G_PHANTOM_POWER;
 
-	chip->phantom_power = !!on;
+	chip->phantom_power = on;
 	return write_control_reg(chip, control_reg, le32_to_cpu(chip->comm_page->e3g_frq_register), 0);
 }
 


--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
