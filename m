From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: hda/eld - Add const to possible
	places
Date: Mon, 17 Aug 2015 15:44:11 +0200
Message-ID: <1439819051-32166-5-git-send-email-tiwai@suse.de>
References: <1439819051-32166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 000D7260471
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 15:44:25 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B9A0EADDA
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 13:44:25 +0000 (UTC)
In-Reply-To: <1439819051-32166-1-git-send-email-tiwai@suse.de>
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

Similar like the previous fix to hda_proc.c, adding const prefix will
save our world (a little bit).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_eld.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index c746cd9a4450..563984dd2562 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -42,7 +42,7 @@ enum cea_edid_versions {
 	CEA_EDID_VER_RESERVED	= 4,
 };
 
-static char *cea_speaker_allocation_names[] = {
+static const char * const cea_speaker_allocation_names[] = {
 	/*  0 */ "FL/FR",
 	/*  1 */ "LFE",
 	/*  2 */ "FC",
@@ -56,7 +56,7 @@ static char *cea_speaker_allocation_names[] = {
 	/* 10 */ "FCH",
 };
 
-static char *eld_connection_type_names[4] = {
+static const char * const eld_connection_type_names[4] = {
 	"HDMI",
 	"DisplayPort",
 	"2-reserved",
@@ -94,7 +94,7 @@ enum cea_audio_coding_xtypes {
 	AUDIO_CODING_XTYPE_FIRST_RESERVED	= 4,
 };
 
-static char *cea_audio_coding_type_names[] = {
+static const char * const cea_audio_coding_type_names[] = {
 	/*  0 */ "undefined",
 	/*  1 */ "LPCM",
 	/*  2 */ "AC-3",
@@ -482,14 +482,14 @@ void snd_hdmi_print_eld_info(struct hdmi_eld *eld,
 	struct parsed_hdmi_eld *e = &eld->info;
 	char buf[SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
 	int i;
-	static char *eld_version_names[32] = {
+	static const char * const eld_version_names[32] = {
 		"reserved",
 		"reserved",
 		"CEA-861D or below",
 		[3 ... 30] = "reserved",
 		[31] = "partial"
 	};
-	static char *cea_edid_version_names[8] = {
+	static const char * const cea_edid_version_names[8] = {
 		"no CEA EDID Timing Extension block present",
 		"CEA-861",
 		"CEA-861-A",
-- 
2.5.0
