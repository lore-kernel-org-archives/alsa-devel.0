From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ALSA: compress: fix documentation errors
Date: Tue, 28 Oct 2014 21:25:13 +0530
Message-ID: <1414511713-14813-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A97D2650D7
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 17:35:31 +0100 (CET)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Some structure documentation was not right so fix it now

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/compress_driver.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index ae6c3b8..396e8f7 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -42,12 +42,11 @@ struct snd_compr_ops;
  * @buffer_size: size of the above buffer
  * @fragment_size: size of buffer fragment in bytes
  * @fragments: number of such fragments
- * @hw_pointer: offset of last location in buffer where DSP copied data
- * @app_pointer: offset of last location in buffer where app wrote data
  * @total_bytes_available: cumulative number of bytes made available in
  *	the ring buffer
  * @total_bytes_transferred: cumulative bytes transferred by offload DSP
  * @sleep: poll sleep
+ * @private_data: driver private data pointer
  */
 struct snd_compr_runtime {
 	snd_pcm_state_t state;
@@ -94,6 +93,8 @@ struct snd_compr_stream {
  * This can be called in during stream creation only to set codec params
  * and the stream properties
  * @get_params: retrieve the codec parameters, mandatory
+ * @set_metadata: Set the metadata values for a stream
+ * @get_metadata: retreives the requested metadata values from stream
  * @trigger: Trigger operations like start, pause, resume, drain, stop.
  * This callback is mandatory
  * @pointer: Retrieve current h/w pointer information. Mandatory
-- 
1.7.0.4
