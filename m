From: "Jack O'Quin" <joq@io.com>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: 18 Sep 2002 11:06:32 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87bs6v1dvb.fsf@sulphur.joq.us>
References: <Pine.LNX.4.33.0209181416130.534-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0209181416130.534-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav,

I must respectfully point out that your response proves that there
*is* a problem.  This solution is *compicated*.  You're a smart guy.
You probably feel you understand all its implications.  Perhaps you
do.  But, most ALSA users and developers *do not* and *will not*.

I am sorry to report that ALSA has a bad reputation on other forums
(like debian-users).  People appreciate the technology, but they can't
get it working, usually because of some silly problem like this one.
For every "clueless newbie" who asks for help on alsa-users there are
nine more who just shrug their shoulders and give up on ALSA.

ALSA 0.9.0-rc3 was released with a trivial mistake that prevented the
source from even compiling.  We should have immediately released rc4
with a fix for this error.  Instead, we're replacing the broken rc3
source with an rc4 that requires changes in source or configuration to
compile anything.  Pretty soon, no one outside this list is even going
to take ALSA 0.9.0 seriously.  If we don't, why should they?

Clearly, making this non-release-critical interface cleanup has
created a release-critical level of confusion.

I ask you again: *please* back out this change.

Jaroslav Kysela <perex@perex.cz> writes:
> It seems, that you're not understand the compatibility.
> 
> 1) build library with --with-compat-rc3 and place it to some
>    other directory
> 3) build library without --with-compat-rc3, place it to
>    /usr/lib as usuall
> 4) build alsa-utils and newer applications
> 5) build older applications with compatible library compiled
>    with --with-compat-rc3
> 
> Old and new software will co-exist without any problems. Perhaps, we
> can have some good default place for rc3 compatible library and add an 
> autoconfiguration code to alsa.m4. My suggestion is to use /opt/alsa/rc3 
> directory for this job. Comments?

-- 
  Jack O'Quin
  Austin, Texas, USA
  http://www.stellajazz.com


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
