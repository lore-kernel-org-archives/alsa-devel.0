From: Lars Lindqvist <lars.lindqvist@yandex.ru>
Subject: EBADFD caused by commit
	dec428c352217010e4b8bd750d302b8062339d32
Date: Mon, 11 Apr 2016 17:08:01 +0200
Message-ID: <20160411150758.GA24579@ksenia.jxvz.lan>
References: <20160410215708.GA2647@ksenia.jxvz.lan>
 <s5h37qs454y.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward19h.cmail.yandex.net (forward19h.cmail.yandex.net
 [87.250.230.161])
 by alsa0.perex.cz (Postfix) with ESMTP id 160FF26055E
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 17:08:06 +0200 (CEST)
Received: from smtp4h.mail.yandex.net (smtp4h.mail.yandex.net [84.201.186.21])
 by forward19h.cmail.yandex.net (Yandex) with ESMTP id 6306E214C6
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 18:08:05 +0300 (MSK)
Received: from smtp4h.mail.yandex.net (localhost [127.0.0.1])
 by smtp4h.mail.yandex.net (Yandex) with ESMTP id 1978A2C320A
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 18:08:04 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <s5h37qs454y.wl-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

On 2016-04-11 Takashi Iwai wrote:
> [Added Qing Cai to Cc, who was the author of the patch in question]
> 
> On Sun, 10 Apr 2016 23:57:11 +0200,
> Lars Lindqvist wrote:
> > 
> > Hi!
> > 
> > Since alsa-lib commit  dec428c352217010e4b8bd750d302b8062339d32, I've
> > occationally been hit by an EBADFD whenever any program tries to play
> > sound.  The  situation  I get is  that the  first shmget succeds,  so
> > dmix->shmid >= 0, therefore first_instance = 0.
> 
> I wonder how does this succeed?  It's a leftover shmem?
> But then why it contains the garbage...?

I seem to be able to trigger it by having one client open, starting another,
and quickly closing the first one. I'm not sufficiently familiar with the
alsa source, but I would guess that shmget succeeds since someone is already
attached, and then the shmem gets deconstructed when the first one closes.
Leaving it in a bad state for the second client. So a new type of race
situation is possible.
However, in this scenario, if I just stop playback or kill the processes,
on the next startup of an alsa-lib user everything is fine again. So
first_instance == 1 and buf.shm_nattch == 1.

This is in contrast to the occational problem I've been having, that I don't
know exactly how to trigger, where shmget apparently always succeeds, giving
first_instace == 0 and buf.shm_nattch == 1. Which I've only been able to
fix by completely resetting the driver by rmmod + modprobe.

> 
> > But buf.shm_nattach = 1,  so before the commit shmptr would have been
> > zeroed out, but isn't anymore. And since I still have:
> > dmix->shmptr->magic == SND_PCM_DIRECT_MAGIC,  I don't get EINVAL, but
> > EBADFD, somewhere down the line.
> 
> Could you give which line actually gives EBADFD?

In the case where I can trigger it by will, it is from pcm_dmix.c:1074, where
snd_pcm_open_slave returns -EBADFD.
But I don't know where it comes from in the spontaneous, more persistent,
case. I'm sure it is not the same place, since SNDERR("unable to open slave")
is run when snd_pcm_open_slave() < 0, but I get no such message in this case.
I'll try to pinpoint it the next chance I get.

> 
> > >From what I understand,  the race condition that was fixed would still
> > be avoided if shmptr was zeroed on (first_instance || buf.shm_nattch == 1).
> > If that is the case, would you please consider applying attached diff?
>  
> This may work, but I still would like to see how another unexpected
> situation happens.
> 
> 
> thanks,
> 
> Takashi
> 
> > Regards,
> > Lars Lindqvist
> > diff -Naur alsa-lib-1.1.1.orig/src/pcm/pcm_direct.c alsa-lib-1.1.1/src/pcm/pcm_direct.c
> > --- alsa-lib-1.1.1.orig/src/pcm/pcm_direct.c	2016-03-31 15:10:39.000000000 +0200
> > +++ alsa-lib-1.1.1/src/pcm/pcm_direct.c	2016-04-10 17:44:08.815456305 +0200
> > @@ -125,7 +125,7 @@
> >  		snd_pcm_direct_shm_discard(dmix);
> >  		return err;
> >  	}
> > -	if (first_instance) {	/* we're the first user, clear the segment */
> > +	if (first_instance || buf.shm_nattch == 1) {	/* we're the first user, clear the segment */
> >  		memset(dmix->shmptr, 0, sizeof(snd_pcm_direct_share_t));
> >  		if (dmix->ipc_gid >= 0) {
> >  			buf.shm_perm.gid = dmix->ipc_gid;
