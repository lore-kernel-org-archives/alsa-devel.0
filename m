From: Georgi Georgiev <chutz@gg3.net>
Subject: Re: Broken AC3 on EMU10K1 since July 2-nd
Date: Tue, 28 Sep 2004 01:20:24 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040927162024.GA5768@lion.gg3.net>
References: <20040927160314.GA16100@lion.gg3.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040927160314.GA16100@lion.gg3.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

maillog: 28/09/2004-01:03:14(+0900): Georgi Georgiev types
> I checked out the CVS in my kernel source tree, and after playing with
> different dates:
> 
> cvs up -D "1  Jul 2004" -- sound plays OK
> cvs up -D "2  Jul 2004" -- sound skips heavily

I did some more checking:

cvs up -dP -D "1 Jul 2004 18:0:0" -- OK
cvs up -dP -D "1 Jul 2004 19:0:0" -- BAD

Still, I cannot understand the changes made to emu10k1, so I don't know
what the problem might be. I hope someone finds the fix.

-- 
|    Georgi Georgiev   |  You will be given a post of trust and        |
|     chutz@gg3.net    |  responsibility.                              |
|   +81(90)6266-1163   |                                               |


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
