From: Rene Rebe <rene.rebe@gmx.net>
Subject: [PATCH] pmac mixer update from shadow register on resume and switching
 DRC on headphone plug
Date: Fri, 30 Jul 2004 16:56:16 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <410A6190.1020600@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080709030307020609040406"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

This is a multi-part message in MIME format.
--------------080709030307020609040406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

the attached patch improved the pmac driver by implementing updating the 
mixer from the shadow register after a resume or headphone interrupt, as 
well as automatically selecting DRC on headphone plug.

For normal line-out one does not want the DRC, but it should 
automatically be reenabled after the headphone is unplugged: Otherwise 
the power to the internal speakers is high enought to destroy them 
(happend once to my iBook - when it still had warrenty ... ;-)

I needed a work-queue / task-queue since it can not be done in the 
interrupt context - this is done in the way the OSS driver does it, too. 
I hope this is acceptable.

Have fun,
  René Rebe

--------------080709030307020609040406
Content-Type: text/plain;
 name="alsa-pmac.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-pmac.patch"

--- ppc/tumbler.c~	2004-06-16 07:18:52.000000000 +0200
+++ ppc/tumbler.c	2004-08-01 13:46:48.000000000 +0200
@@ -16,6 +16,11 @@
  *   You should have received a copy of the GNU General Public License
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ *   Rene Rebe <rene.rebe@gmx.net>:
+ *     * update from shadow registers on wakeup and headphone plug
+ *     * automatically toggle DRC on headphone plug
+ *	
  */
 
 
@@ -759,12 +764,6 @@
 	DEFINE_MONO("Tone Control - Treble", treble),
 	DEFINE_MONO("PCM Playback Volume", pcm),
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	  .name = "DRC Switch",
-	  .info = snd_pmac_boolean_mono_info,
-	  .get = tumbler_get_drc_switch,
-	  .put = tumbler_put_drc_switch
-	},
-	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	  .name = "DRC Range",
 	  .info = tumbler_info_drc_value,
 	  .get = tumbler_get_drc_value,
@@ -791,12 +790,6 @@
 	DEFINE_SNAPPER_MONO("Tone Control - Bass", bass),
 	DEFINE_SNAPPER_MONO("Tone Control - Treble", treble),
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	  .name = "DRC Switch",
-	  .info = snd_pmac_boolean_mono_info,
-	  .get = tumbler_get_drc_switch,
-	  .put = tumbler_put_drc_switch
-	},
-	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	  .name = "DRC Range",
 	  .info = tumbler_info_drc_value,
 	  .get = tumbler_get_drc_value,
@@ -826,6 +819,14 @@
 	.put = tumbler_put_mute_switch,
 	.private_value = TUMBLER_MUTE_AMP,
 };
+static snd_kcontrol_new_t tumbler_drc_sw __initdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "DRC Switch",
+	.info = snd_pmac_boolean_mono_info,
+	.get = tumbler_get_drc_switch,
+	.put = tumbler_put_drc_switch
+};
+
 
 #ifdef PMAC_SUPPORT_AUTOMUTE
 /*
@@ -847,6 +848,33 @@
 	}
 }
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+static struct tq_struct device_change;
+#else
+static struct work_struct device_change;
+#endif
+
+static void
+device_change_handler(void *self)
+{
+	pmac_t *chip = (pmac_t*) self;
+	pmac_tumbler_t *mix;
+
+	if (!chip)
+		return;
+
+	mix = chip->mixer_data;
+
+	/* first set the DRC so the speaker do not explode */
+	if (chip->model == PMAC_TUMBLER)
+		tumbler_set_drc(mix);
+	else
+		snapper_set_drc(mix);
+
+	/* reset the master volume so the correct amplification is applied */
+	tumbler_set_master_volume(mix);
+}
+
 static void tumbler_update_automute(pmac_t *chip, int do_notify)
 {
 	if (chip->auto_mute) {
@@ -856,14 +889,29 @@
 			/* mute speaker */
 			check_mute(chip, &mix->amp_mute, 1, do_notify, chip->speaker_sw_ctl);
 			check_mute(chip, &mix->hp_mute, 0, do_notify, chip->master_sw_ctl);
+			mix->drc_enable = 0;
+
 		} else {
 			/* unmute speaker */
 			check_mute(chip, &mix->amp_mute, 0, do_notify, chip->speaker_sw_ctl);
 			check_mute(chip, &mix->hp_mute, 1, do_notify, chip->master_sw_ctl);
+			mix->drc_enable = 1;
 		}
-		if (do_notify)
+		if (do_notify) {
 			snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
 				       &chip->hp_detect_ctl->id);
+			snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			               &chip->drc_sw_ctl->id);
+		}
+
+		/* finally we need to schedule an update of the mixer values
+		   (master and DRC are enough for now) -ReneR */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+		schedule_task(&device_change);
+#else
+		schedule_work(&device_change);
+#endif
+
 	}
 }
 #endif /* PMAC_SUPPORT_AUTOMUTE */
@@ -1114,11 +1163,21 @@
 	chip->speaker_sw_ctl = snd_ctl_new1(&tumbler_speaker_sw, chip);
 	if ((err = snd_ctl_add(chip->card, chip->speaker_sw_ctl)) < 0)
 		return err;
+	chip->drc_sw_ctl = snd_ctl_new1(&tumbler_drc_sw, chip);
+	if ((err = snd_ctl_add(chip->card, chip->drc_sw_ctl)) < 0)
+		return err;
+
 
 #ifdef CONFIG_PMAC_PBOOK
 	chip->resume = tumbler_resume;
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+	INIT_TQUEUE(&device_change, device_change_handler, (void *)chip);
+#else
+	INIT_WORK(&device_change, device_change_handler, (void *)chip);
+#endif
+
 #ifdef PMAC_SUPPORT_AUTOMUTE
 	if (mix->headphone_irq >=0 && (err = snd_pmac_add_automute(chip)) < 0)
 		return err;


--------------080709030307020609040406--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
