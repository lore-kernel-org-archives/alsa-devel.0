From: Lars Lindqvist <lars.lindqvist@yandex.ru>
Subject: Re: EBADFD caused
	by	commit	dec428c352217010e4b8bd750d302b8062339d32
Date: Tue, 12 Apr 2016 18:46:17 +0200
Message-ID: <20160412164614.GA7789@ksenia.jxvz.lan>
References: <20160410215708.GA2647@ksenia.jxvz.lan>
 <s5h37qs454y.wl-tiwai@suse.de>
 <20160411150758.GA24579@ksenia.jxvz.lan>
 <s5htwj67wbs.wl-tiwai@suse.de>
 <20160412145225.GA2446@ksenia.jxvz.lan>
 <s5hh9f67t9q.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward6h.cmail.yandex.net (forward6h.cmail.yandex.net
 [87.250.230.217])
 by alsa0.perex.cz (Postfix) with ESMTP id AE208265141
 for <Alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 18:46:22 +0200 (CEST)
Received: from smtp2h.mail.yandex.net (smtp2h.mail.yandex.net [84.201.187.145])
 by forward6h.cmail.yandex.net (Yandex) with ESMTP id 0A0F421371
 for <Alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 19:46:21 +0300 (MSK)
Received: from smtp2h.mail.yandex.net (localhost [127.0.0.1])
 by smtp2h.mail.yandex.net (Yandex) with ESMTP id 4B5911703896
 for <Alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 19:46:21 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <s5hh9f67t9q.wl-tiwai@suse.de>
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
> Actually we have a semaphore before shm access, so the race at two
> opens shouldn't happen.  I noticed it after I sent my previous mail.
> 
> But the semaphore is taken also at snd_pcm_dmix_close().  So I wonder
> where the race actually happens.  Both open and close must be
> protected while another stream is opening or closing.
> 
> Could you try to check where you get the exact error...?

The execution tree, as far as I can find is the following:

snd_pcm_dmix_open:
 * Line 1009 snd_pcm_direct_shm_create_or_connect with the code in question,
 * which returns 0. So we end up in line 1058, dmix->shmtr->use_server is 0,
 * so go to line 1072.. running:
snd_pcm_open_slave, running:
snd_pcm_open_named_slave, running:
snd_pcm_open_conf
 * where snd_dlobj_cache_get gives open_func = snd_pcm_hw_open, so
snd_pcm_hw_open()
snd_open_device("/dev/snd/pcmC0D0p")
 * where open() returns -1 with errno = EBADFD

Regards,
Lars
