From: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Subject: Re: Still have choppy audio using 1.0.17
Date: Tue, 15 Jul 2008 15:40:00 -0300
Message-ID: <487CEF00.1050207@tet.com.br>
References: <4856C768.1060404@tet.com.br>	<485952C5.30307@tet.com.br>	<485965B0.9020102@tet.com.br>	<485A58A1.6040002@tet.com.br>	<48622AF1.3000304@tet.com.br>	<s5hprq5qz2t.wl%tiwai@suse.de>	<486A7757.4060907@tet.com.br>	<486E1A26.1030802@tet.com.br>	<487B9379.5030200@tet.com.br>	<487BF452.2090301@cox.net>
	<487C9065.9080800@tet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einstein.tteng.com.br (mail.tteng.com.br [201.86.232.130])
	by alsa0.perex.cz (Postfix) with ESMTP id C067324500
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 20:40:03 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by einstein.tteng.com.br (Postfix) with ESMTP id D99A0DE846E
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 15:40:00 -0300 (BRST)
Received: from [192.168.0.84] (gserra.tteng.com.br [192.168.0.84])
	by einstein.tteng.com.br (Postfix) with ESMTP id 5FEDCDE846A
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 15:39:57 -0300 (BRST)
In-Reply-To: <487C9065.9080800@tet.com.br>
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

Gustavo da Silva Serra escreveu:
> stan escreveu:
>   
>> Gustavo da Silva Serra wrote:
>>   
>>     
>>> I have discovered something else. Choppy audio occurs when 
>>> snd_pcm_playback_silence, in pcm_lib.c, will silence the same period 
>>> than the capture pointer is pointing at. I am printing this variables 
>>> "ofs" in snd_pcm_playback_silence and what is returned from 
>>> snd_card_loopback_pointer when the substream is capture.
>>>
>>> How snd_pcm_playback_silence is supposed to work? Must it silence the 
>>> next period from the playback pointer? How is ensured that this 
>>> situation (ofs == capture pointer) does not happen with sound cards?
>>>
>>> Thanks ANY help... any...
>>>
>>>     
>>>       
>> The way the API docs describe it the silence function 
>> fills the play buffer with a set amount of silence when 
>> the buffer has fewer than threshold frames to play. 
>> So, if your playback is running close to that 
>> threshold, it will be continuously injecting chunks of 
>> silence into the stream.  That would certainly sound 
>> choppy.  From the docs it sounds like the silence is 
>> always injected into the existing stream at the current 
>> pointer.
>>
>> Note:  this is just from reading the docs.  I haven't 
>> actually used this.
>>     
>
> I don't know if the silence function snd_pcm_playback_silence is the 
> same from alsa library. It uses the threshold, but it is not clear for 
> me how. It seems that this function clears the buffer for the new stream 
> arriving, because, from time to time, it silences a whole period.
>
> Thanks for the attention :)
> _______________________________________________
>   
It silences a whole period because the pointer inside aloop behaves like 
that. Logging the pointer inside aloop I discovered that it is 
incremented so fast inside timer function that when pointer function is 
called, the pointer is not being incremented anymore. It is like a 
concurrency issue: first the pointer will be incremented many times, 
after that, the pointer function will be called many times with the same 
pointer value. Later, the pointer will be incremented some more, and so 
on...
I wonder if this is not the problem, logging the pointer for my sound 
card I see a different behavior: the pointer function return offset 
between two periods.
