From: Lars Lindqvist <lars.lindqvist@yandex.ru>
Subject: Re: EBADFD caused by
	commit	dec428c352217010e4b8bd750d302b8062339d32
Date: Tue, 12 Apr 2016 16:52:28 +0200
Message-ID: <20160412145225.GA2446@ksenia.jxvz.lan>
References: <20160410215708.GA2647@ksenia.jxvz.lan>
 <s5h37qs454y.wl-tiwai@suse.de>
 <20160411150758.GA24579@ksenia.jxvz.lan>
 <s5htwj67wbs.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward14j.cmail.yandex.net (forward14j.cmail.yandex.net
 [5.255.227.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 93CA8265189
 for <Alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 16:52:38 +0200 (CEST)
Received: from smtp14.mail.yandex.net (smtp14.mail.yandex.net [95.108.131.192])
 by forward14j.cmail.yandex.net (Yandex) with ESMTP id 7C63F213B8
 for <Alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 17:52:31 +0300 (MSK)
Received: from smtp14.mail.yandex.net (localhost [127.0.0.1])
 by smtp14.mail.yandex.net (Yandex) with ESMTP id 3EE0A1B60668
 for <Alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 17:52:31 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <s5htwj67wbs.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Den 2016-04-12 skrev Takashi Iwai:
> On Mon, 11 Apr 2016 17:08:01 +0200,
> Lars Lindqvist wrote:
> > 
> > On 2016-04-11 Takashi Iwai wrote:
> > > [Added Qing Cai to Cc, who was the author of the patch in question]
> > > 
> > > On Sun, 10 Apr 2016 23:57:11 +0200,
> > > Lars Lindqvist wrote:
> > > > 
> > > > Hi!
> > > > 
> > > > Since alsa-lib commit  dec428c352217010e4b8bd750d302b8062339d32, I've
> > > > occationally been hit by an EBADFD whenever any program tries to play
> > > > sound.  The  situation  I get is  that the  first shmget succeds,  so
> > > > dmix->shmid >= 0, therefore first_instance = 0.
> > > 
> > > I wonder how does this succeed?  It's a leftover shmem?
> > > But then why it contains the garbage...?
> > 
> > I seem to be able to trigger it by having one client open, starting another,
> > and quickly closing the first one.
> 
> One possible case is that the second stream is opened almost at the
> same time as the first stream, and the second stream reaches to the
> point checking SND_PCM_DIRECT_MAGIC before the first one finishes the
> initialization.  Does a hackish patch like below make any difference?

No it doesn't, the magic check succeeds. The situation is that the first
one has been open for "a long time" when I open the second one. So I
would think that initialization has been completed properly. If the
second one opens just as the first closes, it might be that the second
assigns (correctly) first_instance = 0, but by the time it reaches the
"if (first_instance)" check, the first one has closed, and left garbage.

Lars

> diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
> index 14de734d98eb..d0aa4258004f 100644
> --- a/src/pcm/pcm_direct.c
> +++ b/src/pcm/pcm_direct.c
> @@ -92,6 +92,7 @@ int snd_pcm_direct_shm_create_or_connect(snd_pcm_direct_t *dmix)
>  {
>  	struct shmid_ds buf;
>  	int tmpid, err, first_instance = 0;
> +	int repeat = 0;
>  	
>  retryget:
>  	dmix->shmid = shmget(dmix->ipc_key, sizeof(snd_pcm_direct_share_t),
> @@ -136,6 +137,9 @@ retryget:
>  	} else {
>  		if (dmix->shmptr->magic != SND_PCM_DIRECT_MAGIC) {
>  			snd_pcm_direct_shm_discard(dmix);
> +			/* might be racy, let's retry for a few times */
> +			if (++repeat < 10)
> +				goto retryget;
>  			return -EINVAL;
>  		}
>  	}
