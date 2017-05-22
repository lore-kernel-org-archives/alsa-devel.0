From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: hda - Provide dual-codecs model
	option for a few Realtek codecs
Date: Mon, 22 May 2017 16:46:05 +0200
Message-ID: <20170522144606.30477-2-tiwai@suse.de>
References: <20170522144606.30477-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 47F32266EB0
 for <alsa-devel@alsa-project.org>; Mon, 22 May 2017 16:46:08 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id C84DFAC08
 for <alsa-devel@alsa-project.org>; Mon, 22 May 2017 14:46:07 +0000 (UTC)
In-Reply-To: <20170522144606.30477-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Recently some laptops and mobos are equipped with the dual Realtek
codecs that require special quirks.  For making the debugging easier,
add the model "dual-codecs" to be passed via module option.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3fdd5af190a4..918e45268915 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2343,6 +2343,7 @@ static const struct hda_model_fixup alc882_fixup_models[] = {
 	{.id = ALC883_FIXUP_ACER_EAPD, .name = "acer-aspire"},
 	{.id = ALC882_FIXUP_INV_DMIC, .name = "inv-dmic"},
 	{.id = ALC882_FIXUP_NO_PRIMARY_HP, .name = "no-primary-hp"},
+	{.id = ALC1220_FIXUP_GB_DUAL_CODECS, .name = "dual-codecs"},
 	{}
 };
 
@@ -6015,6 +6016,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC292_FIXUP_TPT440_DOCK, .name = "tpt440-dock"},
 	{.id = ALC292_FIXUP_TPT440, .name = "tpt440"},
 	{.id = ALC292_FIXUP_TPT460, .name = "tpt460"},
+	{.id = ALC233_FIXUP_LENOVO_MULTI_CODECS, .name = "dual-codecs"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
@@ -7342,6 +7344,7 @@ static const struct hda_model_fixup alc662_fixup_models[] = {
 	{.id = ALC662_FIXUP_ASUS_MODE8, .name = "asus-mode8"},
 	{.id = ALC662_FIXUP_INV_DMIC, .name = "inv-dmic"},
 	{.id = ALC668_FIXUP_DELL_MIC_NO_PRESENCE, .name = "dell-headset-multi"},
+	{.id = ALC662_FIXUP_LENOVO_MULTI_CODECS, .name = "dual-codecs"},
 	{}
 };
 
-- 
2.13.0
