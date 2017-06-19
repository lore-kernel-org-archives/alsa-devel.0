From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: pcm: Fix possible inconsistent
 appl_ptr update via mmap
Date: Mon, 19 Jun 2017 21:10:00 +0900
Message-ID: <e4c13350-ad41-92ac-8c09-a641ec03f519@sakamocchi.jp>
References: <20170616204055.31036-1-tiwai@suse.de>
 <f101e9f3-b243-51d0-400c-907bbcb90367@sakamocchi.jp>
 <s5hr2yhmcpn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id BAC9D26705A
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 14:10:06 +0200 (CEST)
In-Reply-To: <s5hr2yhmcpn.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Jun 19 2017 02:23, Takashi Iwai wrote:
>> I'll post a patch to take 'snd_pcm_reset()' to use
>> 'snd_pcm_action_lock_irq()' instead of
>> 'snd_pcm_action_nonatomic()'. How do you think about it?
> 
> Conceptually seen, that's not right.  snd_pcm_reset() calls PCM ioctl
> ops, and this is supposed to be always non-atomic (it's a kind of
> ioctl wrapper, after all).  So the correct fix would be simply to wrap
> only the snd_pcm_playback_silence() call with the stream lock.

I once investigated for this idea. But I was discouraged because of 
several resons:

1. There's a semantic contradiction. 'snd_pcm_action_nonatomic()' 
includes atomic operation. The idea perhaps puzzles developers.
2. In 'snd_pcm_pre_reset()', 'snd_pcm_do_reset()' and 
'snd_pcm_post_reset()', parameters of runtime for PCM substream are also 
changed or referred. They can be changed in other functions 
concurrently, thus should be locked.
3. Currently there're a few drivers which implements the local ioctl. 
All of them handle the callback without calling task scheduler. It's 
reasonable against the cost to have an additional restraint just for
context with the reset command.

Well, this is a revised version.

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 7e8f3656b695..c74bee099155 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1593,7 +1593,11 @@ static int snd_pcm_pre_reset(struct 
snd_pcm_substream *substream, int state)
  static int snd_pcm_do_reset(struct snd_pcm_substream *substream, int 
state)
  {
         struct snd_pcm_runtime *runtime = substream->runtime;
-       int err = substream->ops->ioctl(substream, 
SNDRV_PCM_IOCTL1_RESET, NULL);
+       int err;
+
+       snd_pcm_stream_unlock_irq(substream);
+       err = substream->ops->ioctl(substream, SNDRV_PCM_IOCTL1_RESET, 
NULL);
+       snd_pcm_stream_lock_irq(substream);
         if (err < 0)
                 return err;
         runtime->hw_ptr_base = 0;
@@ -1621,7 +1625,7 @@ static const struct action_ops 
snd_pcm_action_reset = {

  static int snd_pcm_reset(struct snd_pcm_substream *substream)
  {
-       return snd_pcm_action_nonatomic(&snd_pcm_action_reset, 
substream, 0);
+       return snd_pcm_action_lock_irq(&snd_pcm_action_reset, substream, 0);
  }

  /*

There's still a contradiction about atomicity but as a whole better than 
before.


Regards

Takashi Sakamoto
