From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: Wed, 18 Sep 2002 17:23:36 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209181641541.796-100000@ecabase.localdomain>
References: <Pine.LNX.4.33.0209171436440.537-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0209171436440.537-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 17 Sep 2002, Jaroslav Kysela wrote:

> 	After some thoughs, I think that this sort of cleanups is good for 
> implementing at any time. It doesn't break the implementation (in the 
> sense of behaviour), but it makes that older code is not compilable. 
> Fortunately, any C programmer can fix the compilation in this case, so 
> it's definitely not a big problem.

I understand this change needed to be done, but I'd still like to humbly
remind of the effects of breaking source-level compatibility, even if
the binary-level compatibility is preserved.

I'm currently maintaining nearly a dozen applications that use the ALSA
0.9 PCM API. These apps have hundreds of users that have the latest 0.9rc
or a CVS-snapshot installed. Now I'm facing a situation where I need to
patch all these apps with new and old code plus ifdefs, test, release new
versions and possibly inform users that "if you want to upgrade to 
0.9-rc4/CVS, you must also upgrade app X, or otherwise compiling X will 
fail".

In any case this will be bad PR for ALSA and generate a lot of work 
for developers working on ALSA and apps using ALSA. You wouldn't believe 
how much I still get mail from people who are...

- trying to compile 0.5.x only apps against 0.9.x
- trying to compile 0.9.x apps against 0.5.x
- have 0.9.x packages installed but a 0.5.x style modules.conf 
- have different versions of alsa-driver/alsa-lib/alsa-utils installed

... and most of time the problem report is as detailed as "ALSA is not
working on my machine". ;) And now I can add the "rc[1-3] vs rc[4-]" to
the list.

And I must say that there are quite a few people out there who have a
really negative attitude against ALSA, because of old API changes and/or
documentation issues. This, of course, is not the fault of ALSA
developers, but it's still something that affects all of us, who are
interested in a succesful future for ALSA.

Some random ideas for future:

- Python style interface changing, where old interfaces are first 
  deprecated for one major release (with clearly visible warnings), 
  and removed from the next major release [1]
- make the API changes between major releases
	-> less of an suprise for both users and developers

[1] You could for instance have a ALSA_USE_API_V1_1 (or some such)
    preprocessor definition that would select the new
    API (ie. apps would define ALSA_USE_API_V1_1 before including
    alsa/asoundlib.h). This would allow apps to start using 
    a new API between major releases, without causing any source
    nor binary level incompabilities.

PS In any case, thanks to Jaroslav for adding symbol
   versioning to alsa-lib. Things like this are also good
   from PR perspective... ;)

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
