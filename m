From: "Jack O'Quin" <joq@io.com>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: 17 Sep 2002 20:08:05 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87ptvc14wa.fsf@sulphur.joq.us>
References: <Pine.LNX.4.33.0209171436440.537-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sulphur.joq.us (dsl-65-188-41-49.telocity.com [65.188.41.49])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA12149
	for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2002 03:08:15 +0200
In-Reply-To: <Pine.LNX.4.33.0209171436440.537-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Is this a "Release-Critical" bug fix?  

If not, I think source- and binary-incompatible changes are highly
inappropriate right now.  A "release candidate" is supposed to
*stabilize* the interface and implementation.  Making an incompatible
change between rc3 and rc4 looks like a big step backwards.

If at all possible, let's postpone this cleanup until after ALSA 0.9.0
is released.  Put the release in maintenance mode, then clean up these
functions in the 1.0.0 development tree.  That will also be a good
time to increment the library version number.

Jaroslav Kysela <perex@perex.cz> writes:

> 	I've made a simple cleanup which unifies all snd_pcm_hw_params_* 
> functions. The first set of changes are in CVS a few days, but some 
> developers pointed that the backwards compatibility is a right thing.
> 	After some thoughs, I think that this sort of cleanups is good for 
> implementing at any time. It doesn't break the implementation (in the 
> sense of behaviour), but it makes that older code is not compilable. 
> Fortunately, any C programmer can fix the compilation in this case, so 
> it's definitely not a big problem.
> 	The much bigger drawback is that we have no binary compatibility 
> with older applications. I decided to use the versioned symbols in the 
> future versions of alsa library and to keep the binary compatibility with 
> older versions of library (function declarations). At the time, we have 
> two symbol versions: ALSA_0.9.0 and ALSA_0.9.0rc4.
> 	These solutions exists for co-existing older and newer 
> applications:
> 
> 1) New "versioned" library is libasound.so.3, so that older applications 
>    uses older libasound.so.2. 
> 2) Recompile older applications with "compatible library" which contains
>    versioned symbols ALSA_0.9, but headers are compatible with 0.9.0rc3. 
>    This library will be also libasound.so.3, but ALL symbols have ALSA_0.9 
>    tag which allows to override functions in future. The compatible library
>    will be built when '--with-compat-rc3' argument is passed to the 
>    configure script in alsa-lib. This solution allows keeping binary 
>    compatibility and allows to update alsa-lib with recent one (built 
>    without --with-compat-rc3).
> 
> I suggest to use the second solution from this time.
> 
> Objections/further discussion is welcome.

Regards,
-- 
  Jack O'Quin
  Austin, Texas, USA
  http://www.stellajazz.com


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
