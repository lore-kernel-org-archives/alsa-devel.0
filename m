From: Paul Davis <pbd@op.net>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: Wed, 18 Sep 2002 09:49:55 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17rfBE-0001EJ-00@usw-sf-list1.sourceforge.net>
References: <Pine.LNX.4.33.0209181416130.534-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 18 Sep 2002 14:21:44 +0200."
             <Pine.LNX.4.33.0209181416130.534-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Chris Rankin <rankincj@yahoo.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>1) build library with --with-compat-rc3 and place it to some
>   other directory
>3) build library without --with-compat-rc3, place it to
>   /usr/lib as usuall
>4) build alsa-utils and newer applications
>5) build older applications with compatible library compiled
>   with --with-compat-rc3
>
>Old and new software will co-exist without any problems. Perhaps, we
>can have some good default place for rc3 compatible library and add an 
>autoconfiguration code to alsa.m4. My suggestion is to use /opt/alsa/rc3 
>directory for this job. Comments?

the use of autoconf files like alsa.m4 is now deprecated by the very
people who invented them. can we please use pkgconfig instead? its
much more flexible.

i don't like the above scheme at all. 

what's going on here is the same thing that was happening a year ago,
only now *some* level of attention is being paid to the notion of
binary compatibility. the problem is, its not the right kind of
attention. the changes that have been made break the API. a year ago,
there was no problem telling us app developers that we just had to
keep following the API changes. now, because we are at 0.9.0rcN, there
is some sense that this isn't OK to do. the problem is that the
solution being provided as an alternative to "change your code" is
really rather cumbersome and awkward.

how should we carry out step (5) when we may not "know" where the rc3
library is to be found? this necessitates having alsa-rc3.m4 (or
better, alsa-rc3.pc) floating around, and STILL changing apps - just
their configure files, not their source. its worse, however, because a
lot of apps don't use alsa.m4 (i didn't even know it existed, for
example). they just use AC_CHECK_LIB, which will almost certainly look
in the place where the rc4 library is probably installed. its not easy
to make it do anything else.

look, once again the API has been modified without any attempt to
notify application developers ahead of time, without any attempt to
collect input from application developers and without any prior plan
for how to maintain back-compatability. this is very very regrettable.

but the changes have been made, they appear to be for a good reason,
and i think that its probably best to just forget about trying to
maintain back-compatibility in any way. the problem i see coming up is
that the attitude that these kinds of changes are OK to do seems quite
ingrained in jaroslav. i am worried what will happen when 1.0.0 comes
out, and then it *really* becomes unacceptable to do this kind of
thing any more than once a year (roughly speaking).

at the very least, move to pkgconfig so that apps can find the alsa
libs easily.

--p



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
