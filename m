From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] alsa-lib: topology: Fix private data for BEs
Date: Tue, 22 Aug 2017 10:16:05 +0100
Message-ID: <1503393365-24760-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F6C7267578
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 11:16:25 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Private data was not being added to BEs. Fix this.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/topology/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/topology/data.c b/src/topology/data.c
index 5b83b9f..f96ff9b 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -50,7 +50,9 @@ struct snd_soc_tplg_private *get_priv_data(struct tplg_elem *elem)
 	case SND_TPLG_TYPE_DAI:
 		priv = &elem->dai->priv;
 		break;
-
+	case SND_TPLG_TYPE_BE:
+		priv = &elem->link->priv;
+		break;
 	default:
 		SNDERR("error: '%s': no support for private data for type %d\n",
 			elem->id, elem->type);
-- 
1.9.1
