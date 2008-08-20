From: Brian Rhodes <bgr@acdstar.com>
Subject: Re: pcm write from posix threads
Date: Wed, 20 Aug 2008 03:39:18 -0500
Message-ID: <48ABD836.5020309@acdstar.com>
References: <48AB4806.8030002@acdstar.com> <s5h3al0nm22.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from manowar.linespeed.net (linespeed.net [75.146.159.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 06F912463A
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Aug 2008 10:39:19 +0200 (CEST)
In-Reply-To: <s5h3al0nm22.wl%tiwai@suse.de>
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

Thanks for reassuring me that there isn't some sort of incompatibility 
with alsa lib and threading.  I am not able to reproduce the issue on an 
x86 system and it only seems to happen when built with a specific 
toolchain for ARM.

Takashi Iwai wrote:
> At Tue, 19 Aug 2008 17:24:06 -0500,
> Brian Rhodes wrote:
>   
>> When calling snd_pcm_write* from a thread how do you safely cancel the 
>> thread?  I've tried masking the signals which are used in alsa lib, yet 
>> I am getting a segfault on pthread_exit().  My thread is looping doing 
>> the following.
>>
>> testcancel
>> snd_pcm_wait
>> snd_pcm_avail
>> snd_pcm_writei
>>
>> I am checking return values to handle those functions being woken up by 
>> pthread cancel and attempting to exit.  In testing the process it 
>> performs fine until I start actually writing data.  Once I write some 
>> data, a pthread_exit will segfault.  My cancellation routine is calling 
>> snd_pcm_drop, then doing a cancel followed by join.
>>     
>
> No, alsa-lib functions don't care threads in general.
> Some codes have uses pthread_mutex, but not in the PCM core code, at
> least.
>
> You need to handle and protect threads by yourself.
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>   
