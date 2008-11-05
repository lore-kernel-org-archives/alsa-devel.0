From: "Brian Welch" <Brian-Welch@cox.net>
Subject: Re: Monitoring ALSA's write pointer (appl_ptr)?
Date: Tue, 4 Nov 2008 20:10:13 -0700
Message-ID: <000701c93ef4$05428e40$6501a8c0@stefoffice>
References: <20081103234028.PAVUM.84220.imail@fed1rmwml28>
	<s5hprlbqwm1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao105.cox.net (fed1rmmtao105.cox.net [68.230.241.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FAA52412E
	for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2008 04:10:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>> Is there a definitive/safe way to monitor ALSA's write pointer in the
>> dma_area?  It seems like the ack callback and the appl_ptr is the
>> correct way, but I was told by another developer that appl_ptr doesn't
>> work in all cases.
>>
>> As a future optimization for my hardware, I may want to tell ALSA to use
>> a specific area of physical memory for it's dma_area, what is the best
>> way to do that?
>
> A good question.  The ack callback is called only when the explicit
> read/write method is used.  When mmap access is used, it won't be
> called.
>
> One hack would be to check appl_ptr in the pointer callback.  This
> callback is called in snd_pcm_hwsync(), too.  So, if you watch the
> appl_ptr change as frequently as possible, it'd be a good place for
> that.
>
> Takashi

Thanks.  I'll try reading appl_ptr from within the pointer callback.

Brian 
