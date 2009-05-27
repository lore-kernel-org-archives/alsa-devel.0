From: Nickolas Lloyd <ultrageek.lloyd@gmail.com>
Subject: Re: [PATCH] snd-hda-intel: Jack Mode changes for
	Sigmatel boards
Date: Wed, 27 May 2009 14:14:08 +0000
Message-ID: <4A1D4AB0.40904@gmail.com>
References: <4A13F91D.8010102@gmail.com>	<s5hvdnp5wdv.wl%tiwai@suse.de>	<4A1AEF14.1090608@gmail.com>
	<s5hy6sj9fl0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id A08CD243FA
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 23:04:51 +0200 (CEST)
Received: by qyk1 with SMTP id 1so6611652qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2009 14:04:50 -0700 (PDT)
In-Reply-To: <s5hy6sj9fl0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Matthew Ranostay <mranostay@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Well, a goto loop is old-fashioned as a code in 21st century :)
>
> Also, it might be better to use auto_pin_cfg_labels[] to each unique
> control name instead of index. 
> It's often more intuitive.
>
>
> Takashi
>
>   
Thanks for the suggestions.  Indeed, using the labels array does make it
much more intuitive.

+static inline int stac92xx_add_jack_mode_control(struct hda_codec *codec,
+                        hda_nid_t nid, int idx)
+{
+    int def_conf = snd_hda_codec_get_pincfg(codec, nid);
+    int control = 0;
+    struct sigmatel_spec *spec = codec->spec;
+    char name[22];
+
+    if (!((get_defcfg_connect(def_conf)) & AC_JACK_PORT_FIXED)) {
+        if (stac92xx_get_vref(codec, nid) == AC_PINCTL_VREF_GRD
+            && nid == spec->line_switch)
+            control = STAC_CTL_WIDGET_IO_SWITCH;
+        else if (snd_hda_query_pin_caps(codec, nid)
+            & (AC_PINCAP_VREF_GRD << AC_PINCAP_VREF_SHIFT))
+            control = STAC_CTL_WIDGET_DC_BIAS;
+        else if (nid == spec->mic_switch)
+            control = STAC_CTL_WIDGET_IO_SWITCH;
+    }
+
+    if (control) {
+        strcpy(name, auto_pin_cfg_labels[idx]);
+        return stac92xx_add_control(codec->spec, control,
+                    strcat(name, " Jack Mode"), nid);
+    }
+
+    return 0;
+}
+

One question here is if it's possible for a Line In jack to act as a Mic
Jack via the use of a DC bias.

@@ -3269,20 +3336,13 @@ static int stac92xx_auto_create_multi_ou
             return err;
     }
 
-    if (spec->line_switch) {
-        err = stac92xx_add_control(spec, STAC_CTL_WIDGET_IO_SWITCH,
-                       "Line In as Output Switch",
-                       spec->line_switch << 8);
-        if (err < 0)
-            return err;
-    }
-
-    if (spec->mic_switch) {
-        err = stac92xx_add_control(spec, STAC_CTL_WIDGET_DC_BIAS,
-                       "Mic Jack Mode",
-                       spec->mic_switch);
-        if (err < 0)
-            return err;
+    for (idx = AUTO_PIN_MIC; idx <= AUTO_PIN_FRONT_LINE; idx++) {
+        nid = cfg->input_pins[idx];
+        if (nid) {
+            err = stac92xx_add_jack_mode_control(codec, nid, idx);
+            if (err < 0)
+                return err;
+        }

Do these sections look alright?  And if so, should I re-up the whole
thing?  Also, is there anything else you think I should change, or any
other suggestions you have?

Thanks,
Nick
