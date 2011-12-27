From: Sangsu Park <sangsu@gmail.com>
Subject: Re: [PATCH] ASoC: Allocate PCM operations dynamically
 to support multiple DAIs
Date: Tue, 27 Dec 2011 16:49:46 +0900
Message-ID: <CANh+=Y8HVjkChnMQLzHmGbpbxRu3wxqbUDp2SQ3SpQhpC-0oug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DCF41038FA
	for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2011 08:49:47 +0100 (CET)
Received: by ggnv5 with SMTP id v5so7783884ggn.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 23:49:46 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, lrg@ti.com, sangsu4u.park@samsung.com
List-Id: alsa-devel@alsa-project.org

> On Fri, Dec 23, 2011 at 10:37:51AM +0900, Sangbeom Kim wrote:
>
> > +	soc_pcm_ops = kzalloc(sizeof(*soc_pcm_ops), GFP_KERNEL);
> > +	if (soc_pcm_ops == NULL) {
> > +		snd_printk(KERN_ERR "Cannot allocate PCM OPS\n");
> > +		return -ENOMEM;
> > +	}
>
> This patch is good and fixes a real problem but can you please change it
> slightly so that instead of dynamically allocating the soc_pcm_ops we
> just embed it directly in the runtime structure.  Since every runtime
> needs an ops structure we may as well just have it embedded directly and
> not write the allocation, freeing and error handling code.


Hi, I'm Sangsu Park. (sangsu4u.park@samsung.com)
I'm using gmail because of company's firewall problems...

I've implement your guide like follows.

//--------------------------------------------------------------------------------------------------------------------------------
        struct snd_soc_dai *codec_dai = rtd->codec_dai;
        struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+       struct snd_pcm_ops *soc_pcm_ops = platform->driver->ops;
        struct snd_pcm *pcm;
        char new_name[64];
        int ret = 0, playback = 0, capture = 0;

        if (playback)
-               snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &soc_pcm_ops);
+               snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, soc_pcm_ops);

        if (capture)
-               snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &soc_pcm_ops);
+               snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, soc_pcm_ops);
--------------------------------------------------------------------------------------------------------------------------------//

But, it seems to make mutex dead lock.
When starting playback, it tells some messages.

//--------------------------------------------------------------------------------------------------------------------------------
# aplay -twav Test.wav
INFO: task aplay:1071 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
aplay           D c01d1ba4     0  1071   1051 0x00000000
[<c01d1ba4>] (__schedule+0x244/0x6cc) from [<c01d2db0>]
(__mutex_lock_slowpath+0x180/0x360)
[<c01d2db0>] (__mutex_lock_slowpath+0x180/0x360) from [<c01d2f9c>]
(mutex_lock+0xc/0x24)
[<c01d2f9c>] (mutex_lock+0xc/0x24) from [<c01c10c4>] (soc_pcm_open+0x38/0x48c)
[<c01c10c4>] (soc_pcm_open+0x38/0x48c) from [<c01c1114>]
(soc_pcm_open+0x88/0x48c)
[<c01c1114>] (soc_pcm_open+0x88/0x48c) from [<c01b0fcc>]
(snd_pcm_open_substream+0x60/0xa0)
[<c01b0fcc>] (snd_pcm_open_substream+0x60/0xa0) from [<c01b1134>]
(snd_pcm_open+0x128/0x270)
[<c01b1134>] (snd_pcm_open+0x128/0x270) from [<c01a4034>] (snd_open+0x130/0x2ec)
[<c01a4034>] (snd_open+0x130/0x2ec) from [<c00b00e4>] (chrdev_open+0x10c/0x1f0)
[<c00b00e4>] (chrdev_open+0x10c/0x1f0) from [<c00aad24>]
(__dentry_open+0x220/0x328)
[<c00aad24>] (__dentry_open+0x220/0x328) from [<c00aaef4>]
(nameidata_to_filp+0x60/0x68)
[<c00aaef4>] (nameidata_to_filp+0x60/0x68) from [<c00bb5d4>]
(do_last+0x214/0xcc0)
[<c00bb5d4>] (do_last+0x214/0xcc0) from [<c00bc13c>] (path_openat+0xbc/0x3a8)
[<c00bc13c>] (path_openat+0xbc/0x3a8) from [<c00bc510>] (do_filp_open+0x30/0x84)
[<c00bc510>] (do_filp_open+0x30/0x84) from [<c00aa954>] (do_sys_open+0xe4/0x184)
[<c00aa954>] (do_sys_open+0xe4/0x184) from [<c000f3c0>]
(ret_fast_syscall+0x0/0x30)
--------------------------------------------------------------------------------------------------------------------------------//

"sound/core/" uses soc_pcm_ops using substream->ops,
and "sound/soc/" uses soc_pcm_ops using platform->driver->ops.
So, I think that they must have their own soc_pcm_ops object.
How do you think about this?
