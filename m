From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 096/112] ALSA: hda - Add missing slave names
	for Speaker Surround, etc
Date: Tue,  8 Jan 2013 12:39:29 +0100
Message-ID: <1357645185-7645-97-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 086EE265228
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id CC662A5390
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index fa8302f..823fac5 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3250,6 +3250,9 @@ static const char * const slave_pfxs[] = {
 	"Front", "Surround", "Center", "LFE", "Side",
 	"Headphone", "Speaker", "Mono", "Line Out",
 	"CLFE", "Bass Speaker", "PCM",
+	"Speaker Front", "Speaker Surround", "Speaker CLFE", "Speaker Side",
+	"Headphone Front", "Headphone Surround", "Headphone CLFE",
+	"Headphone Side",
 	NULL,
 };
 
-- 
1.8.0.1
