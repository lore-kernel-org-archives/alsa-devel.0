From: =?ISO-8859-2?Q?Adam_Tla=B3ka?= <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Tue, 28 Sep 2004 07:11:44 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4158F290.3050301@pg.gda.pl>
References: <200409270300.i8R30Ro1016070@localhost.localdomain> <4157B56F.9000905@pg.gda.pl> <Pine.LNX.4.58.0409271433490.1733@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0409271433490.1733@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 >>I tried to modify AOSS to use
>>callbacks (works almost good but scheduling/swapping effects still 
>>there)
> Are you using fully loaded ring buffer on the ALSA side with a decent 
> size?
No because of low latency mixing requirements. Buffer is filled with two 
periods of data at the beginning and the callback refills it to maintain 
delay to be about this size.

>>but I found an app which disables SIGIO for example.
> It might be solved with the loopback device and a RT mixing daemon.
But now? Just ,,Enjoy The Silence''.

> I don't think that it's something which cannot be solved.
Maybe, but clock is ticking, compability is broken
and MS Windows system still is a better solution
in sound area. I personally want to offer Linux solution as a desktop 
multimedia system but at this time I just can't.
Sorry to say that.

Evolution is what is going in the nature. From my point of view (and 
many others for sure) I don't need a new API. I just need better 
functionality and some additional features expanding existing API.

OK. If you don't want mixing in kernel space doing this and other 
effects in some special RT daemon looks like step in right direction.
If an app could comunicate with it through /dev interface it could be 
unchanged and compability will be saved.

Regards

-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
