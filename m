From: <LoganLi@viatech.com.cn>
Subject: [PATCH 27/30] ALSA: HDA VIA: rename
	vt1708_control_templates[].
Date: Fri, 9 Oct 2009 18:41:20 +0800
Message-ID: <5B2BE0DB92BC8F4694F815C2F34E0D5F123C48@exchbj03.viatech.com.bj>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C681103B1F
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 12:41:14 +0200 (CEST)
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
Subject: ALSA: HDA VIA: rename vt1708_control_templates[].

To via_control_templates[].

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 pci/hda/patch_via.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/pci/hda/patch_via.c
+++ b/pci/hda/patch_via.c
@@ -367,7 +367,7 @@
 			.put = bind_pin_switch_put,
\
 			.private_value = HDA_COMPOSE_AMP_VAL(0, 3, 0, 0)
}
 
-static struct snd_kcontrol_new vt1708_control_templates[] = {
+static struct snd_kcontrol_new via_control_templates[] = {
 	HDA_CODEC_VOLUME(NULL, 0, 0, 0),
 	HDA_CODEC_MUTE(NULL, 0, 0, 0),
 	ANALOG_INPUT_MUTE,
@@ -430,7 +430,7 @@
 	knew = snd_array_new(&spec->kctls);
 	if (!knew)
 		return -ENOMEM;
-	*knew = vt1708_control_templates[type];
+	*knew = via_control_templates[type];
 	knew->name = kstrdup(name, GFP_KERNEL);
 	if (!knew->name)
 		return -ENOMEM;
