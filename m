From: <LoganLi@viatech.com.cn>
Subject: [PATCH 15/30] ALSA: HDA VIA: Modify
	vt1708_set_pinconfig_connect function.
Date: Fri, 9 Oct 2009 18:40:36 +0800
Message-ID: <5B2BE0DB92BC8F4694F815C2F34E0D5F123C3B@exchbj03.viatech.com.bj>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 789E9103B0D
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 12:40:30 +0200 (CEST)
Content-class: urn:content-classes:message
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
Cc: tiwai@suse.de, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: HDA VIA: Modify vt1708_set_pinconfig_connect function.

like seqassoc 0xff, seqassoc 0xf0 of vt1708 should override Port
Connectivity field into 'AC_JACK_PORT_COMPLEX'

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 pci/hda/patch_via.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/pci/hda/patch_via.c
+++ b/pci/hda/patch_via.c
@@ -1768,11 +1768,10 @@
 	def_conf = snd_hda_codec_get_pincfg(codec, nid);
 	seqassoc = (unsigned char) get_defcfg_association(def_conf);
 	seqassoc = (seqassoc << 4) | get_defcfg_sequence(def_conf);
-	if (get_defcfg_connect(def_conf) == AC_JACK_PORT_NONE) {
-		if (seqassoc == 0xff) {
-			def_conf = def_conf & (~(AC_JACK_PORT_BOTH <<
30));
-			snd_hda_codec_set_pincfg(codec, nid, def_conf);
-		}
+	if (get_defcfg_connect(def_conf) == AC_JACK_PORT_NONE
+	    && (seqassoc == 0xf0 || seqassoc == 0xff)) {
+		def_conf = def_conf & (~(AC_JACK_PORT_BOTH << 30));
+		snd_hda_codec_set_pincfg(codec, nid, def_conf);
 	}
 
 	return;
