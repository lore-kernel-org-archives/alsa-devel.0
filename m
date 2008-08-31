From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH] alsa-lib: Reword doxygen doc for
	snd_pcm_delay()
Date: Sun, 31 Aug 2008 03:42:20 +0200
Message-ID: <20080831014220.GA21232@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 854281037FE
	for <alsa-devel@alsa-project.org>;
	Sun, 31 Aug 2008 03:42:21 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

snd_pcm_delay() is for synchronization purposes, it returns the overall latency
of the stream, not just the latency induced by the hardware playback buffer.
The documentation is a bit misleading about this fact, and some people already
misunderstood it. So let's reword this to make the explanation clearer and
explicit.

This is a result of the discussions of the thread this mail belongs to:

http://mailman.alsa-project.org/pipermail/alsa-devel/2008-June/008456.html

Lennart

---
 src/pcm/pcm.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index ee2300e..ae89795 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -939,11 +939,23 @@ int snd_pcm_hwsync(snd_pcm_t *pcm)
  * \param delayp Returned delay in frames
  * \return 0 on success otherwise a negative error code
  *
- * Delay is distance between current application frame position and
- * sound frame position.
- * It's positive and less than buffer size in normal situation,
- * negative on playback underrun and greater than buffer size on
- * capture overrun.
+ * For playback the delay is defined as the time that a frame that is written
+ * to the PCM stream shortly after this call will take to be actually
+ * audible. It is as such the overall latency from the write call to the final
+ * DAC.
+ *
+ * For capture the delay is defined as the time that a frame that was
+ * digitized by the audio device takes until it can be read from the PCM
+ * stream shortly after this call returns. It is as such the overall latency
+ * from the initial ADC to the read call.
+ *
+ * Please note that hence in case of a playback underrun this value will not
+ * necessarily got down to 0.
+ *
+ * If the application is interested in the fill level of the playback buffer
+ * of the device, it should use snd_pcm_avail_update(). The
+ * value returned by that call is not directly related to the delay, since the
+ * latter might include some additional, fixed latencies the former does not.
  *
  * Note this function does not update the actual r/w pointer
  * for applications. The function #snd_pcm_avail_update()
-- 
1.6.0.1



Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
