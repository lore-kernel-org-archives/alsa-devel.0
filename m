From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: loopback snd_pcm_writei
Date: Tue, 9 Apr 2019 10:36:50 +0200
Message-ID: <e1b9d718-c997-d162-ff49-74f74b407878@perex.cz>
References: <AM5P192MB0180EB66182156CF2353C0FFC5550@AM5P192MB0180.EURP192.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B699F80C17
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 10:36:53 +0200 (CEST)
In-Reply-To: <AM5P192MB0180EB66182156CF2353C0FFC5550@AM5P192MB0180.EURP192.PROD.OUTLOOK.COM>
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
List-Id: alsa-devel@alsa-project.org

Dne 01. 04. 19 v 15:51 Giuliano Zannetti - ART S.p.A. napsal(a):
> Hi,
> 
> I have the configuration in the asound.conf above.
> 
> my_plug - - > my_route - - > my_multi - - > slave0 (forward)
>                                       - - > slave1 (loopback)
> 
> I open the plug my_plug in the block mode:
> 
>     writtenFrames = snd_pcm_writei(handle, bufferToWrite, bufferToWriteSize);
> 
> The issue I see is that there are several "writes" with 0 written frames. It seems like the snd_pcm_writei does not hold until data will be written. In general, 0 written frames sounds weird to me, because snd_pcm_writei should block itself if no space is available in the circular buffer right?
> 
> I have tried to fix the following method in pcm_multi.c, as Jaroslav Kysela suggests.
> 
> -static int snd_pcm_multi_may_wait_for_avail_min(snd_pcm_t *pcm, snd_pcm_uframes_t avail ATTRIBUTE_UNUSED)
> +static int snd_pcm_multi_may_wait_for_avail_min(snd_pcm_t *pcm, snd_pcm_uframes_t avail)
> {
>         snd_pcm_multi_t *multi = pcm->private_data;
> -       snd_pcm_t *slave = multi->slaves[multi->master_slave].pcm;
> -       return snd_pcm_may_wait_for_avail_min(slave, snd_pcm_mmap_avail(slave));
> +       unsigned int i;
> +       for (i = 0; i < multi->slaves_count; ++i) {
> +               if (snd_pcm_may_wait_for_avail_min(multi->slaves[i].pcm, avail))
> +                       return 1;
> +       }
> +       return 0;
> }
> 
> But unfortunately the issue has not been resolved.

Hi,

  I did some debugging (it's pretty reproducible) and the real fixes are here:

https://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=4694a6643dc09c5e41969d33ed98f42278a02d40
https://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=c7fc3fdbe23e63757b0e2c88c0d7c029c660923b
https://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=369df322577034ea872978d6470edbadf30d81a9
https://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=0bfad420efea328a50361bb3ed11487acf69da25

  Just get the latest alsa-lib and it should work correctly now. Let me know the result.

					Thanks.
						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
