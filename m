From: jack craig <jackc@linuxlighthouse.com>
Subject: Re: pulseaudio workaround for alsa-driver bug
Date: Wed, 29 Jul 2009 09:08:50 -0700
Message-ID: <4A707412.3040604@linuxlighthouse.com>
References: <4A6F479F.7080804@linuxlighthouse.com>	<s5h4oswm0xl.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0907290947190.4225@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from linuxlighthouse.com (gate.linuxlighthouse.com [63.249.90.144])
	by alsa0.perex.cz (Postfix) with ESMTP id C9691103849
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 18:09:09 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.0907290947190.4225@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "Community assistance, encouragement,
	and advice for using Fedora." <fedora-list@redhat.com>
List-Id: alsa-devel@alsa-project.org

On 07/29/2009 12:47 AM, Jaroslav Kysela wrote:
>>> I wanted to report my recent issues with audio on fc11.
>>>
>>> after an update from fc10, my audio started failing. not the failure to
>>> year any audio,
>>> but instead, it would start off fine and then tail spin. i am using
>>> mplayer to
>>> play an internet asf stream to the local audio.
>>>
>>> the stream processing failure is described in
>>> https://bugzilla.redhat.com/show_bug.cgi?id=514213
>>>
>>> i was able to get a workaround from the #pulseaudio guys, but!
>>>
>>> they encouraged me to report my experience and its fix to you to
>>> encourage the fix of this snd_pcm_delay() defect.
>>>        
>> Could you please summarize and post together?  In that way, we can
>> better discuss on ML.
>>      
>
> It seems that this issue is already fixed in mainstream:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=506075
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f708eb1d71dc8ffb184da9f0bc53461c6dc10653
>
>   						Jaroslav
>
> -----
>    
gentlemen,

thx for your response to this issue; as it does appear to have a fix in 
the pipe, i will watch for the next update to verify it.
i am cc'ing the fedora-list so they know to watch for the update as well...

thx again, jackc...

-- 
    jack craig
       jackc@LinuxLightHouse.com
          831-684-1375 (Office)
             831-596-6924 (cell)
                IM: jackcraigaptos (AIM)
