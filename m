From: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Subject: Re: Still have choppy audio using 1.0.17
Date: Wed, 16 Jul 2008 12:43:18 -0300
Message-ID: <487E1716.2080808@tet.com.br>
References: <4856C768.1060404@tet.com.br>	<485952C5.30307@tet.com.br>	<485965B0.9020102@tet.com.br>	<485A58A1.6040002@tet.com.br>	<48622AF1.3000304@tet.com.br>	<s5hprq5qz2t.wl%tiwai@suse.de>	<486A7757.4060907@tet.com.br>	<486E1A26.1030802@tet.com.br>	<487B9379.5030200@tet.com.br>	<487BF452.2090301@cox.net>	<487C9065.9080800@tet.com.br>	<487CEF00.1050207@tet.com.br>	<487D174F.70104@cox.net>	<487E0356.3060605@tet.com.br>
	<s5hzlohzw13.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einstein.tteng.com.br (mail.tteng.com.br [201.86.232.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 4156924429
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jul 2008 17:43:18 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by einstein.tteng.com.br (Postfix) with ESMTP id 6066FDE8453
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jul 2008 12:43:16 -0300 (BRST)
Received: from [192.168.0.84] (gserra.tteng.com.br [192.168.0.84])
	by einstein.tteng.com.br (Postfix) with ESMTP id EF365DE806F
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jul 2008 12:43:12 -0300 (BRST)
In-Reply-To: <s5hzlohzw13.wl%tiwai@suse.de>
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

Takashi Iwai escreveu:
> At Wed, 16 Jul 2008 11:19:02 -0300,
> Gustavo da Silva Serra wrote:
>>
>>
>> stan escreveu:
>>> Gustavo da Silva Serra wrote:
>>>   
>>>>> _______________________________________________
>>>>>   
>>>>>       
>>>> It silences a whole period because the pointer inside aloop behaves like 
>>>> that. Logging the pointer inside aloop I discovered that it is 
>>>> incremented so fast inside timer function that when pointer function is 
>>>> called, the pointer is not being incremented anymore. It is like a 
>>>> concurrency issue: first the pointer will be incremented many times, 
>>>> after that, the pointer function will be called many times with the same 
>>>> pointer value. Later, the pointer will be incremented some more, and so 
>>>> on...
>>>> I wonder if this is not the problem, logging the pointer for my sound 
>>>> card I see a different behavior: the pointer function return offset 
>>>> between two periods.
>>>> _______________________________________________
>>>>     
>>> Sounds like this is a critical section that has no 
>>> protection.  So the sequence is messed up.  In the 
>>> regular sound card, there must be a semaphore or block 
>>> to prevent this kind of behavior.  You could probably 
>>> add the logic from the regular card to the aloop 
>>> function and fix it.
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> I will add that to the list of things I am trying, thanks : )
>> I wish I could understand the silencer function seems to fills the 
>> buffer with zeroes to the left of the playback offset. Why it doesn't 
>> care where is the capture pointer. Very strange.
>
> Because the PCM core doesn't assume that any access is there after the
> playback.  It's the area that should be cleared.
>
> That said: aloop is buggy and racy.  It has to serialize the playback
> and capture streams in the right order, and make sure that the data is
> surely copied before silencing.
>
>
> Takashi

Thanks so much!

About the first statment I only have a question: if both capture and 
playback pointers are moving to the right, shouldn't the silence too be 
to the right of the playback pointer? I don't know how it works, but it 
seems to me that the silence is set to the left of playback and to the 
right of capture, thus, capture would read silence sometime. Something like:

Audio buffer:

+-----------------------------------------------------------+
|         |         |         |         |         |         |
+-----------------------------------------------------------+
^                             ^         ^
capture                    silence    playback

( I hope that font configurations mess the drawing, I used monospaced 
fonts). So this is what I think that happens, but that doesn't make 
sense to me.

Thanks again, Takashi.
