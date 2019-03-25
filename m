From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd_pcm_writei 0 frames
Date: Mon, 25 Mar 2019 16:14:46 +0100
Message-ID: <31a51ad0-4740-7ba7-7b2d-a9cd9262b1fc@perex.cz>
References: <AM5P192MB01806DDBC9D07CD4C6425187C55E0@AM5P192MB0180.EURP192.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37D7EF808F6
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2019 16:14:50 +0100 (CET)
In-Reply-To: <AM5P192MB01806DDBC9D07CD4C6425187C55E0@AM5P192MB0180.EURP192.PROD.OUTLOOK.COM>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Giuliano Zannetti - ART S.p.A." <giuliano.zannetti@artgroup-spa.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Dne 25. 03. 19 v 15:16 Giuliano Zannetti - ART S.p.A. napsal(a):
> Hi,
> 
> I've the following configuration in my asound.conf:
> 
> |-----| - - > |-----| - - > |-----| - - > |-----| - - > |-----| - - > |----------|
> |plug |       |     | - - > |     | - - > |     | - - > |     | - - > | (output) |
> |-----| - - > |     | - - > |     | - - > |     | - - > |     | - - > |    hw    |
>               |     | - - > |     | - - > |     | - - > |     | - - > |          |
>               |     |       |     |       |route| - - > |dmix | - - > |          |
>               |     |       |     |       |     | - - > |     | - - > |          |
>               |     |       |     |       |     | - - > |     | - - > |          |
>               |     |       |     |       |-----| - - > |-----| - - > |----------|
>               |route|       |multi|
>               |     | - - > |     |
>               |     | - - > |     | - - > |----| - - > |----| - - > |----------|
>               |     | - - > |     | - - > |    | - - > |    | - - > |(loopback)|
>               |-----| - - > |     | - - > |plug| - - > |dmix| - - > |    hw    |
>                             |-----| - - > |----| - - > |----| - - > |----------|
> 
> As you can see I'm using a loopback interface.
> I open the pcm plug in the block mode to write.
> 
> writtenFrames = snd_pcm_writei(handle, bufferToWrite, bufferToWriteSize);
> 
> Using the configuration above I have several "writes" with 0 written frames.
> It seems like the snd_pcm_writei does not hold until data will be written.
> 
> In general, 0 written frames sounds weird to me, because snd_pcm_writei should block itself if no space is available in the circular buffer right?
> 
> So, my questions are two:
> 
>   1.  Writing 0 frames is an expected behaviour (regardless of my configuration in the asound.conf)? In what scenarios can I have that?
>   2.  How my configuration could trigger this behaviour?

I guess that snd_pcm_multi_may_wait_for_avail_min() implementation is the culprit. It should take in account all slaves - not only the master one.

Could you test this modification?

diff --git a/src/pcm/pcm_multi.c b/src/pcm/pcm_multi.c
index 28440378..0afd31bf 100644
--- a/src/pcm/pcm_multi.c
+++ b/src/pcm/pcm_multi.c
@@ -775,11 +775,15 @@ static int snd_pcm_multi_mmap(snd_pcm_t *pcm)
        return 0;
 }

-static int snd_pcm_multi_may_wait_for_avail_min(snd_pcm_t *pcm, snd_pcm_uframes_t avail ATTRIBUTE_UNUSED)
+static int snd_pcm_multi_may_wait_for_avail_min(snd_pcm_t *pcm, snd_pcm_uframes_t avail)
 {
        snd_pcm_multi_t *multi = pcm->private_data;
-       snd_pcm_t *slave = multi->slaves[multi->master_slave].pcm;
-       return snd_pcm_may_wait_for_avail_min(slave, snd_pcm_mmap_avail(slave));
+       unsigned int i;
+       for (i = 0; i < multi->slaves_count; ++i) {
+               if (snd_pcm_may_wait_for_avail_min(multi->slaves[i].pcm, avail))
+                       return 1;
+       }
+       return 0;
 }

 static snd_pcm_chmap_query_t **snd_pcm_multi_query_chmaps(snd_pcm_t *pcm)

					Jaroslav


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
