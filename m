From: =?UTF-8?B?QWRhbSBUbGHFgmth?= <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Tue, 28 Sep 2004 08:10:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4159003F.2080401@pg.gda.pl>
References: <200409272014.i8RKEu2i019062@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200409272014.i8RKEu2i019062@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> you're simply wrong about this. if an interrupt is blocked for longer
> than the buffer size, GETOPTR can't help you.
So how is ALSA doing this if its hw handler is not callet at proper 
time? How snd_pcm_delay is working if no hw_ptr nor appl_ptr is moved?

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
