From: =?ISO-8859-1?Q?Ren=E9_Rebe?= <rene@rocklinux-consulting.de>
Subject: Re: [PATCH] pmac mixer update from shadow register on
 resume and switc	hing DRC on headphone plug
Date: Sun, 15 Aug 2004 01:24:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <411E9F44.6080004@rocklinux-consulting.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030308050509060202060503"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?Ren=E9_Rebe?= <rene@rocklinux-consulting.de>
Cc: alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030308050509060202060503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

René Rebe wrote:
> Hi Takashi,
> 
>  > Could you make them separate, and send the patch to tumbler.c and
>  > new tumber.patch?
> 
> Sure - sorrey for the delay, here it goes. tumbler-all.patch is the one 
> to be applied, and tumbler.patch the one to be placed in the 
> alsa-driver/ppc directory.

Well, just compiling 2.6.8 I had to notice that I missed a single line 
change in pmac.h ...

Here goes a corrected patch ,-)

Sincerely yours,
   René Rebe

--
René Rebe - Europe/Germany/Berlin
   rene@rocklinux.org rene@rocklinux-consulting.de
http://www.rocklinux.org http://www.rocklinux-consulting.de

--------------030308050509060202060503
Content-Type: text/x-patch;
 name="tumbler-all.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tumbler-all.patch"

--- ppc/tumbler.c~	2004-06-29 18:14:25.000000000 +0200
+++ ppc/tumbler.c	2004-08-12 18:15:31.000000000 +0200
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
 
 
@@ -757,12 +762,6 @@
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
@@ -789,12 +788,6 @@
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
@@ -824,6 +817,14 @@
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
@@ -845,6 +846,29 @@
 	}
 }
 
+static struct work_struct device_change;
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
+	/* first set the DRC so the speaker do not explode -ReneR */
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
@@ -854,14 +878,25 @@
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
+		schedule_work(&device_change);
+
 	}
 }
 #endif /* PMAC_SUPPORT_AUTOMUTE */
@@ -1112,11 +1147,17 @@
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
 
+	INIT_WORK(&device_change, device_change_handler, (void *)chip);
+
 #ifdef PMAC_SUPPORT_AUTOMUTE
 	if (mix->headphone_irq >=0 && (err = snd_pmac_add_automute(chip)) < 0)
 		return err;
--- ppc/pmac.h~	2004-08-14 13:25:33.000000000 +0200
+++ ppc/pmac.h	2004-08-14 13:26:21.000000000 +0200
@@ -155,6 +155,7 @@
 	void (*mixer_free)(pmac_t *);
 	snd_kcontrol_t *master_sw_ctl;
 	snd_kcontrol_t *speaker_sw_ctl;
+	snd_kcontrol_t *drc_sw_ctl;	/* only used for tumbler -ReneR */
 	snd_kcontrol_t *hp_detect_ctl;
 
 	/* lowlevel callbacks */

--------------030308050509060202060503
Content-Type: text/x-patch;
 name="tumbler.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tumbler.patch"

--- tumbler.c~	2004-08-12 18:15:31.000000000 +0200
+++ tumbler.c	2004-08-12 18:14:47.000000000 +0200
@@ -846,7 +846,11 @@
 	}
 }
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+static struct tq_struct device_change;
+#else
 static struct work_struct device_change;
+#endif
 
 static void
 device_change_handler(void *self)
@@ -895,7 +899,11 @@
 
 		/* finally we need to schedule an update of the mixer values
 		   (master and DRC are enough for now) -ReneR */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+		schedule_task(&device_change);
+#else
 		schedule_work(&device_change);
+#endif
 
 	}
 }
@@ -1156,7 +1164,11 @@
 	chip->resume = tumbler_resume;
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+	INIT_TQUEUE(&device_change, device_change_handler, (void *)chip);
+#else
 	INIT_WORK(&device_change, device_change_handler, (void *)chip);
+#endif
 
 #ifdef PMAC_SUPPORT_AUTOMUTE
 	if (mix->headphone_irq >=0 && (err = snd_pmac_add_automute(chip)) < 0)

--------------030308050509060202060503--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
