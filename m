From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] hda_codec: restore control element values
	during resume
Date: Sun, 29 Apr 2007 17:14:21 +0100 (BST)
Message-ID: <20070429161421.863777B409F@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mtaout01-winn.ispmail.ntl.com (mtaout01-winn.ispmail.ntl.com
	[81.103.221.47]) by alsa0.perex.cz (Postfix) with ESMTP id CA47724549
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Apr 2007 18:14:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

After resume from suspend-to-RAM, there is no sound output from my Intel HDA
hardware:

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition
Audio Controller (rev 01)
Found in a Dell Inspiron 640m, SigmaTel STAC9200 chip.

After resuming, sound immediately returns when you adjust the volume one notch
in either direction. I reported this on the ALSA bug tracker (#0002989).

Further investigation shows that the AC_VERB_SET_AMP_GAIN_MUTE verb is not
being executed during resume, which seems strange. Does other hardware really
store this value during a suspend/resume cycle? Or maybe the volume is
generally controlled through other means on other setups? I'm not entirely
sure what the difference is between kcontrol and kcontrol_new structures, but
I note that there is already some code to restore the values for kcontrol_new
elements.

I solved the issue with the following patch. Is it correct?

Signed-off-by: Daniel Drake <dsd@gentoo.org>

Index: linux-2.6/sound/pci/hda/hda_codec.c
===================================================================
--- linux-2.6.orig/sound/pci/hda/hda_codec.c
+++ linux-2.6/sound/pci/hda/hda_codec.c
@@ -2248,15 +2248,39 @@ EXPORT_SYMBOL(snd_hda_suspend);
 int snd_hda_resume(struct hda_bus *bus)
 {
 	struct list_head *p;
+	struct snd_ctl_elem_value *val = kmalloc(sizeof(*val), GFP_KERNEL);
+
+	if (!val)
+		return -ENOMEM;
 
 	list_for_each(p, &bus->codec_list) {
 		struct hda_codec *codec = list_entry(p, struct hda_codec, list);
+		struct snd_kcontrol *kctl;
+
+		codec->in_resume = 1;
+
 		hda_set_power_state(codec,
 				    codec->afg ? codec->afg : codec->mfg,
 				    AC_PWRST_D0);
+
+
+		list_for_each_entry(kctl, &bus->card->controls, list) {
+			memset(val, 0, sizeof(*val));
+			val->id = kctl->id;
+			/* Assume that get callback reads only from cache,
+			 * not accessing the real hardware
+			 */
+			if (snd_ctl_elem_read(bus->card, val) < 0)
+				continue;
+			snd_ctl_elem_write(bus->card, NULL, val);
+		}
+
 		if (codec->patch_ops.resume)
 			codec->patch_ops.resume(codec);
+
+		codec->in_resume = 0;
 	}
+	kfree(val);
 	return 0;
 }
