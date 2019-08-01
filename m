From: Keyon Jie <yang.jie@linux.intel.com>
Subject: [PATCH] topology: add support to parse private data
	for pcm
Date: Thu,  1 Aug 2019 17:15:06 +0800
Message-ID: <20190801091506.19733-1-yang.jie@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2ED1DF804CF
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2019 11:09:22 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Keyon Jie <yang.jie@linux.intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

We have private data section in struct snd_soc_tplg_pcm, but alsatplg
doesn't support handling it yet, here add handling in tplg_parse_pcm()
to enable it.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
---
 src/topology/data.c | 3 +++
 src/topology/pcm.c  | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/src/topology/data.c b/src/topology/data.c
index b3f4421f..729ce1f4 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -53,6 +53,9 @@ struct snd_soc_tplg_private *get_priv_data(struct tplg_elem *elem)
 	case SND_TPLG_TYPE_BE:
 		priv = &elem->link->priv;
 		break;
+	case SND_TPLG_TYPE_PCM:
+		priv = &elem->pcm->priv;
+		break;
 	default:
 		SNDERR("error: '%s': no support for private data for type %d\n",
 			elem->id, elem->type);
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 5f586dc1..c533ee68 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -732,6 +732,14 @@ int tplg_parse_pcm(snd_tplg_t *tplg,
 				return err;
 			continue;
 		}
+
+		/* private data */
+		if (strcmp(id, "data") == 0) {
+			err = tplg_parse_data_refs(n, elem);
+			if (err < 0)
+				return err;
+			continue;
+		}
 	}
 
 	return 0;
-- 
2.20.1
