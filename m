From: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Subject: Re: Still have choppy audio using 1.0.17
Date: Mon, 14 Jul 2008 14:57:13 -0300
Message-ID: <487B9379.5030200@tet.com.br>
References: <4856C768.1060404@tet.com.br>	<485952C5.30307@tet.com.br>	<485965B0.9020102@tet.com.br>	<485A58A1.6040002@tet.com.br>	<48622AF1.3000304@tet.com.br>	<s5hprq5qz2t.wl%tiwai@suse.de>	<486A7757.4060907@tet.com.br>
	<486E1A26.1030802@tet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einstein.tteng.com.br (mail.tteng.com.br [201.86.232.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 820772440C
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jul 2008 19:57:14 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by einstein.tteng.com.br (Postfix) with ESMTP id 3D85EDE8004
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jul 2008 14:57:12 -0300 (BRST)
Received: from [192.168.0.84] (gserra.tteng.com.br [192.168.0.84])
	by einstein.tteng.com.br (Postfix) with ESMTP id BE73F120008
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jul 2008 14:57:08 -0300 (BRST)
In-Reply-To: <486E1A26.1030802@tet.com.br>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have discovered something else. Choppy audio occurs when 
snd_pcm_playback_silence, in pcm_lib.c, will silence the same period 
than the capture pointer is pointing at. I am printing this variables 
"ofs" in snd_pcm_playback_silence and what is returned from 
snd_card_loopback_pointer when the substream is capture.

How snd_pcm_playback_silence is supposed to work? Must it silence the 
next period from the playback pointer? How is ensured that this 
situation (ofs == capture pointer) does not happen with sound cards?

Thanks ANY help... any...

Gustavo da Silva Serra escreveu:
> I forgot a very important detail, when I can choose the output plugin 
> (alsa or oss in Kaffeine, for example), only alsa has choppy audio. oss 
> plugin works perfectly, only using kernel module emulation.
>
> Gustavo da Silva Serra escreveu:
>   
>> I have tried to implement the solution you proposed. However I still 
>> get choppy audio, just like before, otherwise the sound is clear.
>>
>> Basically I moved the timer to the cable struct, and updated the timer 
>> function to update both playback and capture.
>> I am sending the code attached so you can see if I implemented what 
>> you suggested. The code is not very clean, nor completely functional, 
>> as I never programmed to kernel before, and might cause kernel panic 
>> when closing a stream.
>>
>> Any other suggestions?
>> Thanks for the help and the attention.
>>
>> Takashi Iwai escreveu:
>>     
>>> At Wed, 25 Jun 2008 08:24:33 -0300,
>>> Gustavo da Silva Serra wrote:
>>>  
>>>       
>>>> If I keep the difference between the playback and capture pointers 
>>>> at one period, no choppy audio occurs. If the difference is 0, 2 or 
>>>> 5 periods for example, choppy audio will always occur. Any ideas why?
>>>>     
>>>>         
>>> Through a quick look at the code, it's likely the problem of the
>>> timing of timer handlers for playback/capture streams.  In the current
>>> code, the timer handlers are invoked individually.
>>>
>>> One possible fix would be to force to synchronize the updates of both
>>> directions instead of individual timers.  That is, share the same
>>> timer for the connected streams so that the update order is
>>> guaranteed.
>>>
>>>
>>> Just my $0.02.
>>>
>>> Takashi
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>       
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> __________ NOD32 3241 (20080704) Information __________
>
> This message was checked by NOD32 antivirus system.
> http://www.eset.com
>
>
>
>   
