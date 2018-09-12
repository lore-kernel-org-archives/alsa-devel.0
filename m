From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2][RFC] ALSA: firewire-lib: adopt
	SYNC_APPLPTR flag to flush packets after queueing/dequeueing
	PCM frames
Date: Thu, 13 Sep 2018 00:04:49 +0900
Message-ID: <20180912150450.16334-2-o-takashi@sakamocchi.jp>
References: <20180912150450.16334-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C7FE267795
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2018 17:05:07 +0200 (CEST)
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so1197959pgp.11
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2018 08:05:06 -0700 (PDT)
In-Reply-To: <20180912150450.16334-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In Linux kernel v4.13, ALSA PCM core was improved in an aspect of
updating appl_ptr at a commit 9027c4639ef1('ALSA: pcm: Call ack()
whenever appl_ptr is updated'). This commit ensures a callback of
'struct snd_pcm_ops.ack()' when updating appl_ptr in process context.
This callback can be done in below ioctl(2) requests:
 - SNDRV_PCM_IOCTL_REWIND
 - SNDRV_PCM_IOCTL_FORWARD
 - SNDRV_PCM_IOCTL_SYNC_PTR
 - SNDRV_PCM_IOCTL_READ[I|N]_FRAMES
 - SNDRV_PCM_IOCTL_WRITE[I|N]_FRAMES

In a commit 875becf8412c('ALSA: firewire: process packets in
'struct snd_pcm_ops.ack' callback'), I committed implementation
of .ack() callback to reduce timing gap between queueing/dequeueing
PCM frames and processing packets. However, in usual mmap
programming scenario of ALSA PCM applications, the above operations
are not always used in event dispatcher and the commit is not
necessarily effective to this engine.

At the same time of the appl_ptr improvement, a new flag of PCM
hardware definition was introduced at a commit 42f945970af9('ALSA:
pcm: Add the explicit appl_ptr sync support'), and relevant changes
were added to ALSA PCM core and alsa-lib v1.1.5. This flag expects
userspace to call ioctl(2) with SNDRV_PCM_IOCTL_SYNC_PTR request per
iteration of PCM frame handling in mmap programming scenario below:

while (1):
  ->poll()
  ->snd_pcm_hwsync()
    ->ioctl(HWSYNC)
  ->snd_pcm_mmap_begin()
  (queue/dequeue PCM frames here)
  ->snd_pcm_mmap_commit()
    ->ioctl(SYNC_PTR)

Although adoption of this flag to this engine increases the number
of system calls in an iteration, it's useful in an aspect of packet
processing.

This commit adopts the flag. As a result, this engine has two
chances to process packets in process context at one iteration of
the above calls.

while (1):
  ->poll()
  ->snd_pcm_hwsync()
    ->ioctl(HWSYNC)
      ->struct snd_pcm_ops.pointer()
      = amdtp_stream_pcm_pointer()
        ->fw_iso_context_flush_completions()
  ->snd_pcm_mmap_begin()
  (queue/dequeue PCM frames here)
  ->snd_pcm_mmap_commit()
    ->ioctl(SYNC_PTR)
      ->struct snd_pcm_ops.ack()
      = amdtp_stream_pcm_ack()
        ->fw_iso_context_flush_completions()

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index cb9acfe60f6a..3520dc2bec61 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -156,7 +156,8 @@ int amdtp_stream_add_pcm_hw_constraints(struct amdtp_stream *s,
 		   SNDRV_PCM_INFO_INTERLEAVED |
 		   SNDRV_PCM_INFO_JOINT_DUPLEX |
 		   SNDRV_PCM_INFO_MMAP |
-		   SNDRV_PCM_INFO_MMAP_VALID;
+		   SNDRV_PCM_INFO_MMAP_VALID |
+		   SNDRV_PCM_INFO_SYNC_APPLPTR;
 
 	/* SNDRV_PCM_INFO_BATCH */
 	hw->periods_min = 2;
-- 
2.17.1
