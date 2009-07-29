From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: pulseaudio workaround for alsa-driver bug
Date: Wed, 29 Jul 2009 09:47:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0907290947190.4225@eeebox2.perex-int.cz>
References: <4A6F479F.7080804@linuxlighthouse.com>
	<s5h4oswm0xl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id D39AF10383F
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 09:47:52 +0200 (CEST)
In-Reply-To: <s5h4oswm0xl.wl%tiwai@suse.de>
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
Cc: jack craig <jackc@linuxlighthouse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 29 Jul 2009, Takashi Iwai wrote:

> At Tue, 28 Jul 2009 11:46:55 -0700,
> jack craig wrote:
>>
>> Hi alsa-developers,
>>
>> I wanted to report my recent issues with audio on fc11.
>>
>> after an update from fc10, my audio started failing. not the failure to
>> year any audio,
>> but instead, it would start off fine and then tail spin. i am using
>> mplayer to
>> play an internet asf stream to the local audio.
>>
>> the stream processing failure is described in
>> https://bugzilla.redhat.com/show_bug.cgi?id=514213
>>
>> i was able to get a workaround from the #pulseaudio guys, but!
>>
>> they encouraged me to report my experience and its fix to you to
>> encourage the fix of this snd_pcm_delay() defect.
>
> Could you please summarize and post together?  In that way, we can
> better discuss on ML.

It seems that this issue is already fixed in mainstream:

https://bugzilla.redhat.com/show_bug.cgi?id=506075

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f708eb1d71dc8ffb184da9f0bc53461c6dc10653

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
