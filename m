From: Jaroslav Kysela <perex@perex.cz>
Subject: new "in-compatible" alsa-lib PCM API
Date: Tue, 17 Sep 2002 14:58:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209171436440.537-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA32766
	for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2002 14:58:46 +0200
Received: from pnote.perex-int.cz ([192.168.105.2])
	by gate.perex.cz (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA08470
	for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2002 14:58:43 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

	I've made a simple cleanup which unifies all snd_pcm_hw_params_* 
functions. The first set of changes are in CVS a few days, but some 
developers pointed that the backwards compatibility is a right thing.
	After some thoughs, I think that this sort of cleanups is good for 
implementing at any time. It doesn't break the implementation (in the 
sense of behaviour), but it makes that older code is not compilable. 
Fortunately, any C programmer can fix the compilation in this case, so 
it's definitely not a big problem.
	The much bigger drawback is that we have no binary compatibility 
with older applications. I decided to use the versioned symbols in the 
future versions of alsa library and to keep the binary compatibility with 
older versions of library (function declarations). At the time, we have 
two symbol versions: ALSA_0.9.0 and ALSA_0.9.0rc4.
	These solutions exists for co-existing older and newer 
applications:

1) New "versioned" library is libasound.so.3, so that older applications 
   uses older libasound.so.2. 
2) Recompile older applications with "compatible library" which contains
   versioned symbols ALSA_0.9, but headers are compatible with 0.9.0rc3. 
   This library will be also libasound.so.3, but ALL symbols have ALSA_0.9 
   tag which allows to override functions in future. The compatible library
   will be built when '--with-compat-rc3' argument is passed to the 
   configure script in alsa-lib. This solution allows keeping binary 
   compatibility and allows to update alsa-lib with recent one (built 
   without --with-compat-rc3).

I suggest to use the second solution from this time.

Objections/further discussion is welcome.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
