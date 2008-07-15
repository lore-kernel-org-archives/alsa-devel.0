From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: Still have choppy audio using 1.0.17
Date: Tue, 15 Jul 2008 14:31:59 -0700
Message-ID: <487D174F.70104@cox.net>
References: <4856C768.1060404@tet.com.br>	<485952C5.30307@tet.com.br>	<485965B0.9020102@tet.com.br>	<485A58A1.6040002@tet.com.br>	<48622AF1.3000304@tet.com.br>	<s5hprq5qz2t.wl%tiwai@suse.de>	<486A7757.4060907@tet.com.br>	<486E1A26.1030802@tet.com.br>	<487B9379.5030200@tet.com.br>	<487BF452.2090301@cox.net>	<487C9065.9080800@tet.com.br>
	<487CEF00.1050207@tet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao106.cox.net (fed1rmmtao106.cox.net [68.230.241.40])
	by alsa0.perex.cz (Postfix) with ESMTP id AB8BA1037FD
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 23:32:01 +0200 (CEST)
In-Reply-To: <487CEF00.1050207@tet.com.br>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Gustavo da Silva Serra wrote:
>> _______________________________________________
>>   
> It silences a whole period because the pointer inside aloop behaves like 
> that. Logging the pointer inside aloop I discovered that it is 
> incremented so fast inside timer function that when pointer function is 
> called, the pointer is not being incremented anymore. It is like a 
> concurrency issue: first the pointer will be incremented many times, 
> after that, the pointer function will be called many times with the same 
> pointer value. Later, the pointer will be incremented some more, and so 
> on...
> I wonder if this is not the problem, logging the pointer for my sound 
> card I see a different behavior: the pointer function return offset 
> between two periods.
> _______________________________________________

Sounds like this is a critical section that has no 
protection.  So the sequence is messed up.  In the 
regular sound card, there must be a semaphore or block 
to prevent this kind of behavior.  You could probably 
add the logic from the regular card to the aloop 
function and fix it.
