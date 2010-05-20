From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 11/11] ALSA: hda: Storage class should be
	before const qualifier
Date: Thu, 20 May 2010 10:40:55 +0200
Message-ID: <1274344855-9336-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.zhaw.ch (mx1.zhaw.ch [160.85.104.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D2061039A1
	for <alsa-devel@alsa-project.org>;
	Thu, 20 May 2010 10:40:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
Cc: Tobias Klauser <tklauser@distanz.ch>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The C99 specification states in section 6.11.5:

The placement of a storage-class specifier other than at the beginning
of the declaration specifiers in a declaration is an obsolescent
feature.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 80a183f..53538b0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -14207,7 +14207,7 @@ enum {
 	ALC269_FIXUP_SONY_VAIO,
 };
 
-const static struct hda_verb alc269_sony_vaio_fixup_verbs[] = {
+static const struct hda_verb alc269_sony_vaio_fixup_verbs[] = {
 	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREFGRD},
 	{}
 };
-- 
1.6.3.3
