From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/14] ALSA: riptide: Properly endian notations
Date: Wed, 25 Jul 2018 23:24:04 +0200
Message-ID: <20180725212414.19795-5-tiwai@suse.de>
References: <20180725212414.19795-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7129F26776E
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:24:16 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 37CBFADCB
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:24:16 +0000 (UTC)
In-Reply-To: <20180725212414.19795-1-tiwai@suse.de>
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

The SG descriptor of Riptide contains the little-endian values, hence
we need to define with __le32 properly.  This fixes sparse warnings
like:
  sound/pci/riptide/riptide.c:1112:40: warning: cast to restricted __le32

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/riptide/riptide.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 9d2b2ef15c6b..23017e3bc76c 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -470,10 +470,10 @@ struct snd_riptide {
 };
 
 struct sgd {			/* scatter gather desriptor */
-	u32 dwNextLink;
-	u32 dwSegPtrPhys;
-	u32 dwSegLen;
-	u32 dwStat_Ctl;
+	__le32 dwNextLink;
+	__le32 dwSegPtrPhys;
+	__le32 dwSegLen;
+	__le32 dwStat_Ctl;
 };
 
 struct pcmhw {			/* pcm descriptor */
-- 
2.18.0
