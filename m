From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 1/3] ASoC: compress: Correct handling of copy
	callback
Date: Fri, 26 Jan 2018 13:08:43 +0000
Message-ID: <20180126130845.7122-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id EEC06267666
 for <alsa-devel@alsa-project.org>; Fri, 26 Jan 2018 14:08:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, ladis@linux-mips.org, kuninori.morimoto.gx@renesas.com, vinod.koul@intel.com, lgirdwood@gmail.com, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

The soc_compr_copy callback is currently broken. Since the
changes to move the compr_ops over to the component the return
value is not correctly propagated, always returning zero on
success rather than the number of bytes copied. This causes
user-space to stall continuously reading as it does not believe
it has received any data.

Furthermore, the changes to move the compr_ops over to the
component iterate through the list of components and will call
the copy callback for any that have compressed ops. There isn't
currently any consensus on the mechanism to combine the results
of multiple copy callbacks.

To fix this issue for now halt searching the component list when
we locate a copy callback and return the result of that single
callback. Additional work should probably be done to look at the
other ops, tidy things up, and work out if we want to support
multiple components on a single compressed, but this is the only
fix required to get things working again.

Fixes: 9e7e3738ab0e ("ASoC: snd_soc_component_driver has snd_compr_ops")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Ok here is the simpler fix that should make it much easier to
either sneak this into 4.15 or at least apply it to stable.

Going to do a little more thinking on the full patch before I
send again that need to really wrap my head around what the
intentions are with trying to enable multiple components to
furfil the same role. If anyone has any thoughts on use cases
etc. for this please do send them on :-)

Thanks,
Charles


 sound/soc/soc-compress.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 81232f4ab614b..7973f92cd40f5 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -944,7 +944,7 @@ static int soc_compr_copy(struct snd_compr_stream *cstream,
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
-	int ret = 0, __ret;
+	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -965,10 +965,10 @@ static int soc_compr_copy(struct snd_compr_stream *cstream,
 		    !component->driver->compr_ops->copy)
 			continue;
 
-		__ret = component->driver->compr_ops->copy(cstream, buf, count);
-		if (__ret < 0)
-			ret = __ret;
+		ret = component->driver->compr_ops->copy(cstream, buf, count);
+		break;
 	}
+
 err:
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
-- 
2.11.0
