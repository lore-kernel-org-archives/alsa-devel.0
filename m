From: mengdong.lin@linux.intel.com
Subject: [PATCH 4/4] topology: Fix comparison of unsigned
	expression < 0
Date: Wed, 18 Nov 2015 02:23:59 -0500
Message-ID: <5409599d7c332c0b47008f219490dd5ab0a6a8ed.1447825540.git.mengdong.lin@linux.intel.com>
References: <cover.1447825540.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A2E46265654
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 08:08:14 +0100 (CET)
In-Reply-To: <cover.1447825540.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Fix gcc warning: comparison of unsigned expression < 0 is always false
[-Wtype-limits]

The ABI object channel->id is _le32 and is converted to host unsigned
integer. It cannot be < 0.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/channel.c b/src/topology/channel.c
index 9bc5d5a..c2f1fea 100644
--- a/src/topology/channel.c
+++ b/src/topology/channel.c
@@ -80,6 +80,7 @@ int tplg_parse_channel(snd_tplg_t *tplg,
 	snd_config_t *n;
 	struct snd_soc_tplg_channel *channel = private;
 	const char *id, *value;
+	int channel_id;
 
 	if (tplg->channel_idx >= SND_SOC_TPLG_MAX_CHAN)
 		return -EINVAL;
@@ -88,12 +89,13 @@ int tplg_parse_channel(snd_tplg_t *tplg,
 	snd_config_get_id(cfg, &id);
 	tplg_dbg("\tChannel %s at index %d\n", id, tplg->channel_idx);
 
-	channel->id = lookup_channel(id);
-	if (channel->id < 0) {
+	channel_id = lookup_channel(id);
+	if (channel_id < 0) {
 		SNDERR("error: invalid channel %s\n", id);
 		return -EINVAL;
 	}
 
+	channel->id = channel_id;
 	channel->size = sizeof(*channel);
 	tplg_dbg("\tChan %s = %d\n", id, channel->id);
 
-- 
2.5.0
