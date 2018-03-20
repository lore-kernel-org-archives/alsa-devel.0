From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [RESEND][PATCH v4 2/3] ALSA: hda: ext: add spib to
	stream context
Date: Tue, 20 Mar 2018 21:31:07 +0530
Message-ID: <1521561668-28613-3-git-send-email-sriramx.periyasamy@intel.com>
References: <1521561668-28613-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 8723A2672C1
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 17:09:37 +0100 (CET)
In-Reply-To: <1521561668-28613-1-git-send-email-sriramx.periyasamy@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ramesh Babu <ramesh.babu@intel.com>

Platforms like skylake support SPIB (software position index in
Buffer) capability, through which application pointer can be
programmed in DMA. This helps DMA stop rendering stale data.

This patch saves spib values in stream context which can be
restored during resume from S3.

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
---
 include/sound/hdaudio_ext.h     | 1 +
 sound/hda/ext/hdac_ext_stream.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 9c14e21dda85..34c41496fbc7 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -89,6 +89,7 @@ struct hdac_ext_stream {
 
 	u32 dpib;
 	u32 lpib;
+	u32 spib;
 	bool decoupled:1;
 	bool link_locked:1;
 	bool link_prepared;
diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index c96d7a7a36af..c5212709bdb7 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -461,6 +461,8 @@ int snd_hdac_ext_stream_set_spib(struct hdac_ext_bus *ebus,
 	}
 
 	writel(value, stream->spib_addr);
+	/* save the spib value in stream context */
+	stream->spib = value;
 
 	return 0;
 }
-- 
2.7.4
