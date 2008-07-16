From: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Subject: Re: Still have choppy audio using 1.0.17
Date: Wed, 16 Jul 2008 11:19:02 -0300
Message-ID: <487E0356.3060605@tet.com.br>
References: <4856C768.1060404@tet.com.br>	<485952C5.30307@tet.com.br>	<485965B0.9020102@tet.com.br>	<485A58A1.6040002@tet.com.br>	<48622AF1.3000304@tet.com.br>	<s5hprq5qz2t.wl%tiwai@suse.de>	<486A7757.4060907@tet.com.br>	<486E1A26.1030802@tet.com.br>	<487B9379.5030200@tet.com.br>	<487BF452.2090301@cox.net>	<487C9065.9080800@tet.com.br>	<487CEF00.1050207@tet.com.br>
	<487D174F.70104@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einstein.tteng.com.br (mail.tteng.com.br [201.86.232.130])
	by alsa0.perex.cz (Postfix) with ESMTP id BCE73243D6
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jul 2008 16:19:06 +0200 (CEST)
In-Reply-To: <487D174F.70104@cox.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: stan <ghjeold_i_mwee@cox.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



stan escreveu:
> Gustavo da Silva Serra wrote:
>   
>>> _______________________________________________
>>>   
>>>       
>> It silences a whole period because the pointer inside aloop behaves like 
>> that. Logging the pointer inside aloop I discovered that it is 
>> incremented so fast inside timer function that when pointer function is 
>> called, the pointer is not being incremented anymore. It is like a 
>> concurrency issue: first the pointer will be incremented many times, 
>> after that, the pointer function will be called many times with the same 
>> pointer value. Later, the pointer will be incremented some more, and so 
>> on...
>> I wonder if this is not the problem, logging the pointer for my sound 
>> card I see a different behavior: the pointer function return offset 
>> between two periods.
>> _______________________________________________
>>     
>
> Sounds like this is a critical section that has no 
> protection.  So the sequence is messed up.  In the 
> regular sound card, there must be a semaphore or block 
> to prevent this kind of behavior.  You could probably 
> add the logic from the regular card to the aloop 
> function and fix it.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
I will add that to the list of things I am trying, thanks : )
I wish I could understand the silencer function seems to fills the 
buffer with zeroes to the left of the playback offset. Why it doesn't 
care where is the capture pointer. Very strange. It would be antoher 
approach to the problem. Everything that I am trying are workarounds to 
the problem, instead of understanding why the problem happens and why it 
seems that the aloop behavior (returning only pointers to full periods) 
is the cause of the problem.

Thanks again.
