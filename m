From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: [PATCH] ALSA: hda - apply CS420X erratum fix for
	CS4207 only
Date: Thu,  3 Mar 2011 03:18:18 +0530
Message-ID: <1299102498-29063-2-git-send-email-arun.raghavan@collabora.co.uk>
References: <1298955969.12314.12.camel@snowflake>
	<1299102498-29063-1-git-send-email-arun.raghavan@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.128.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AC421037F3
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2011 22:48:41 +0100 (CET)
In-Reply-To: <1299102498-29063-1-git-send-email-arun.raghavan@collabora.co.uk>
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
Cc: Brian Austin <brian.austin@cirrus.com>, Arun Raghavan <arun@accosted.net>
List-Id: alsa-devel@alsa-project.org

From: Arun Raghavan <arun@accosted.net>

The commit a769cbcf60cee51f4431c0938acd39e7e5b76b8d
    ALSA: hda - Add errata initverb sequence for CS42xx codecs
applies a fix for a chip erratum that is specific to CS4207
unconditionally. On CS4206, this causes digital output to never be
activated.
---
 sound/pci/hda/patch_cirrus.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index a07b031..9804b09 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -1065,8 +1065,9 @@ static int cs_init(struct hda_codec *codec)
 {
 	struct cs_spec *spec = codec->spec;
 
-	/* init_verb sequence for C0/C1/C2 errata*/
-	snd_hda_sequence_write(codec, cs_errata_init_verbs);
+	/* init_verb sequence for CS4207 C0/C1/C2 errata */
+	if (codec->vendor_id == 0x10134207)
+		snd_hda_sequence_write(codec, cs_errata_init_verbs);
 
 	snd_hda_sequence_write(codec, cs_coef_init_verbs);
 
-- 
1.7.4.1
