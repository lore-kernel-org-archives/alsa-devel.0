From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: Remove 2 unused members
	from stream_info struct" to the asoc tree
Date: Thu, 01 Mar 2018 18:07:18 +0000
Message-ID: <E1erSbu-0005yp-NX@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DCB59267B33
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 19:07:20 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sst: Remove 2 unused members from stream_info struct

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From bd47469c9985b50831a55bdda5a36f4672452764 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 18 Feb 2018 23:01:39 +0100
Subject: [PATCH] ASoC: Intel: sst: Remove 2 unused members from stream_info
 struct

Remove the unused ops and str_id members from the stream_info struct.

While at it also remove some kernel-doc comments for members which have
already been removed in the past.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst.h     | 7 -------
 sound/soc/intel/atom/sst/sst_pvt.c | 1 -
 2 files changed, 8 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index e02e2b4cc08f..1f3107909044 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -181,21 +181,15 @@ struct sst_block {
  *
  * @status : stream current state
  * @prev : stream prev state
- * @ops : stream operation pb/cp/drm...
- * @bufs: stream buffer list
  * @lock : stream mutex for protecting state
  * @pcm_substream : PCM substream
  * @period_elapsed : PCM period elapsed callback
  * @sfreq : stream sampling freq
- * @str_type : stream type
  * @cumm_bytes : cummulative bytes decoded
- * @str_type : stream type
- * @src : stream source
  */
 struct stream_info {
 	unsigned int		status;
 	unsigned int		prev;
-	unsigned int		ops;
 	struct mutex		lock;
 
 	void			*pcm_substream;
@@ -212,7 +206,6 @@ struct stream_info {
 
 	unsigned int		num_ch;
 	unsigned int		pipe_id;
-	unsigned int		str_id;
 	unsigned int		task_id;
 };
 
diff --git a/sound/soc/intel/atom/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
index b1e6b8f34a6a..d7d38b0f68db 100644
--- a/sound/soc/intel/atom/sst/sst_pvt.c
+++ b/sound/soc/intel/atom/sst/sst_pvt.c
@@ -365,7 +365,6 @@ void sst_init_stream(struct stream_info *stream,
 {
 	stream->status = STREAM_INIT;
 	stream->prev = STREAM_UN_INIT;
-	stream->ops = ops;
 }
 
 int sst_validate_strid(
-- 
2.16.2
