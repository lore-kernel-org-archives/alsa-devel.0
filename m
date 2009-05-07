From: Tino Keitel <tino.keitel@gmx.de>
Subject: Re: 2.6.29 regression: left audio channel broken after resume from
	suspend with Intel HDA
Date: Thu, 7 May 2009 09:23:53 +0200
Message-ID: <20090507072352.GA6513@mac.home>
References: <20090420194659.GA11399@dose.home.local> <s5h8wluinon.wl%tiwai@suse.de> <20090421073219.GA5866@dose.home.local> <s5hfxg2cv6m.wl%tiwai@suse.de> <20090421183936.GA21935@dose.home.local> <s5hws9a5ewr.wl%tiwai@suse.de> <20090424142113.GA18668@dose.home.local> <s5hskjy5d2t.wl%tiwai@suse.de> <20090428002309.GA29572@x61> <20090506222753.GA6728@mac.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755049AbZEGHYL@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090506222753.GA6728@mac.home>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2009 at 00:27:53 +0200, Tino Keitel wrote:
> On Tue, Apr 28, 2009 at 02:23:09 +0200, Tino Keitel wrote:
> 
> [...]
> 
> > I just saw another, major problem: line in doesn't work anymore with
> > 2.6.29 and also 2.6.30-rc3 (no usable input level). It works with
> > 2.6.27.20.
> 
> FYI: I just tried 2.6.28 and line-in was still broken. So the last
> working kernel is 2.6.27.

I tried this:

git bisect start v2.6.28 v2.6.27 sound/pci/hda/patch_sigmatel.c

The result is commit 4f1e6bc3646ab50b8181555ab7e6eeab68b8632a.

I can't use git revert because of conflicts, so I crafted the attached
patch against 2.6.30-rc4-00288-g413f81e, and now line-in works.

Regards,
Tino

--VS++wcV0S1rZb1Fb
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="fix-mac-mini-line-in.patch"

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 917bc5d..8846a3b 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4070,21 +4070,19 @@ static int stac92xx_init(struct hda_codec *codec)
 		hda_nid_t nid = cfg->input_pins[i];
 		if (nid) {
 			unsigned int pinctl, conf;
-			if (i == AUTO_PIN_MIC || i == AUTO_PIN_FRONT_MIC) {
-				/* for mic pins, force to initialize */
-				pinctl = stac92xx_get_vref(codec, nid);
-				pinctl |= AC_PINCTL_IN_EN;
-				stac92xx_auto_set_pinctl(codec, nid, pinctl);
-			} else {
-				pinctl = snd_hda_codec_read(codec, nid, 0,
-					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
-				/* if PINCTL already set then skip */
-				if (!(pinctl & AC_PINCTL_IN_EN)) {
-					pinctl |= AC_PINCTL_IN_EN;
-					stac92xx_auto_set_pinctl(codec, nid,
-								 pinctl);
-				}
-			}
+			pinctl = snd_hda_codec_read(codec, nid,
+						    0, AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+			/* if PINCTL already set then skip */
+			if (pinctl & AC_PINCAP_IN)
+				continue;
+			pinctl = AC_PINCTL_IN_EN;
+			if (i == AUTO_PIN_MIC || i == AUTO_PIN_FRONT_MIC)
+				pinctl |= stac92xx_get_vref(codec, nid);
+			stac92xx_auto_set_pinctl(codec, nid, pinctl);
+
+
+
+
 			conf = snd_hda_codec_get_pincfg(codec, nid);
 			if (get_defcfg_connect(conf) != AC_JACK_PORT_FIXED) {
 				enable_pin_detect(codec, nid,

--VS++wcV0S1rZb1Fb--
