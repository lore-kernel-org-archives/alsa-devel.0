From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 15/31] HDA patch_via.c: Modify
	vt1708_set_pinconfig_connect function.
Date: Thu, 8 Oct 2009 13:45:38 +0800
Message-ID: <16685ee0910072245h342e9a01m287283843203adb1@mail.gmail.com>
References: <16685ee0910050727y2734efd5yf931cbb4a79d07cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D0C1103962
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:45:39 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 22so2081517fge.2
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:45:39 -0700 (PDT)
In-Reply-To: <16685ee0910050727y2734efd5yf931cbb4a79d07cd@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, LoganLi@viatech.com.cn, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Modify vt1708_set_pinconfig_connect function.

like seqassoc 0xff, seqassoc 0xf0 of vt1708 should override Port
Connectivity field into 'AC_JACK_PORT_COMPLEX'

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1764,11 +1764,10 @@
 	def_conf = snd_hda_codec_get_pincfg(codec, nid);
 	seqassoc = (unsigned char) get_defcfg_association(def_conf);
 	seqassoc = (seqassoc << 4) | get_defcfg_sequence(def_conf);
-	if (get_defcfg_connect(def_conf) == AC_JACK_PORT_NONE) {
-		if (seqassoc == 0xff) {
-			def_conf = def_conf & (~(AC_JACK_PORT_BOTH << 30));
-			snd_hda_codec_set_pincfg(codec, nid, def_conf);
-		}
+	if (get_defcfg_connect(def_conf) == AC_JACK_PORT_NONE
+	    && (seqassoc == 0xf0 || seqassoc == 0xff)) {
+		def_conf = def_conf & (~(AC_JACK_PORT_BOTH << 30));
+		snd_hda_codec_set_pincfg(codec, nid, def_conf);
 	}

 	return;
