From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: Wed, 18 Sep 2002 11:12:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209181104270.534-100000@pnote.perex-int.cz>
References: <87ptvc14wa.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA17514
	for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2002 11:12:54 +0200
In-Reply-To: <87ptvc14wa.fsf@sulphur.joq.us>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jack O'Quin <joq@io.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 17 Sep 2002, Jack O'Quin wrote:

> Is this a "Release-Critical" bug fix?  
> 
> If not, I think source- and binary-incompatible changes are highly
> inappropriate right now.  A "release candidate" is supposed to
> *stabilize* the interface and implementation.  Making an incompatible
> change between rc3 and rc4 looks like a big step backwards.
> 
> If at all possible, let's postpone this cleanup until after ALSA 0.9.0
> is released.  Put the release in maintenance mode, then clean up these
> functions in the 1.0.0 development tree.  That will also be a good
> time to increment the library version number.

You're right, if we don't provide the possibility to build a compatible 
library. If you don't like our changes, simply configure your library with 
--with-compat-rc3 and your - not yet updated - applications will be happy.
Note that these binaries will use newer (0.9.0rc4) library without any 
problems so the co-existence between older and newer applications is 
assured. The binary compatibility is really important thing for us, so I 
spend a few of days to create this compatibility layer.

I really regret to make this sort of modifications at the time, but:

- any later modifications will cause more changes for applications 
  developers (the amount software around alsa-lib grows)
- the symbol versioning is really a good thing; the fact that the basic
  glibc 2.0 is build with this method is a good approved example to keep
  the binary compatibility with all applications build on top of this 
  library, look for implementation of some functions there, the syntax 
  slightly changed for many of them

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
