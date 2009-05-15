From: Marek Peca <marek@duch.cz>
Subject: Re: Should snd_pcm_drop() interrupt snd_pcm_writei()
 call?
Date: Fri, 15 May 2009 16:28:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0905151625320.3095@tesla>
References: <Pine.LNX.4.64.0905121806240.8364@tesla>
	<Pine.LNX.4.64.0905151555550.3095@tesla>
	<s5hd4aa9z19.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from max.feld.cvut.cz (max.feld.cvut.cz [147.32.192.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 22CA8103971
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 17:23:40 +0200 (CEST)
In-Reply-To: <s5hd4aa9z19.wl%tiwai@suse.de>
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

>> This explains the problems I encountered. I missed the information, that
>> these functions are not meant to be thread-safe.
>
> Although it's not recommended, the behavior you described sounds strange.
> Could you check whether this still happens with the very latest
> alsa-lib version?

Yes, we will try to, but I need some cooperation with colleague, so it 
will take some time.

> Also I guess this depends on the plugin to be used, e.g. dmix or not.

I see. Please, can you tell me, whether I should rewrite my program to 
purely single-thread acces to snd_pcm_write & snd_pcm_drop, or should I 
expect, that in ALSA (with proper plugin) it should work in correct 
releases?

Thank you for your answers,
Marek.
