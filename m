From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: Fri, 20 Sep 2002 15:40:21 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209201437300.12518-100000@vaino.wakkanet.fi>
References: <s5hn0qdotcz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0qdotcz.wl@alsa2.suse.de>
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

On Fri, 20 Sep 2002, Takashi Iwai wrote:

>> 	your almost all negative messages persuaded me to wait awhile with 
>> new function prototypes. Here is the result:
> thanks for quick reaction.
> the new library works fine with the old applications.

Btw; with ld from binutils-2.9.5.0.22-6 (rh62) I get the
following error when linking libasound:

/usr/bin/ld: .libs/libasound.so.2.0.0: undefined versioned symbol name snd_pcm_hw_params_get_rate_min@ALSA_0.9.0rc4
/usr/bin/ld: failed to set dynamic section sizes: Bad value collect2: ld returned 1 exit status

And this with a fresh CVS-update of alsa-lib. Might
be a clear ld bug. 

>>   (not available for default linking); these new functions are explicitly
>>   available when ALSA_PCM_NEW_HW_PARAMS_API is defined before inclusion of
> will this condition be removed in the future release as default?
> we can put ALSA_PCM_OLD_HW_PARAM_API for the backward compatibility
> later, instead.

It's too bad there isn't better language-level support for versioned
interfaces. You can do all kinds of things with the preprocessor and
linker, but this really should be something all developers are all aware
of and know how to use.

The basic scenario is:

1. library implements a set of interfaces (v1, v2, ...) 
2. application using the library uses one of the
   interface versions (and note, it's important that 
   application code always explicitly defines what
   interface is wants to use)

Age of each interface should span multiple major releases of the library,
but not nocessarily more than that (maintaining (especially testing!) more
than two or three different versions in the same physical package starts
to be a mess).

This scenario has numerous benefits:

- application developer can decide the time when 
  to port from interface x to x+1 (note! after
  the change, app will then require library 
  version x+1 to be installed)
- library developer can continue to improve 
  the library interfaces without causing
  suprises to app developers

Unfortunately implementing the above is anything but easy. Although there
are mechanisms to do (1) (ld scripts, shared-lib versioning), they add
significant overhead to the maintenance work.

But the real problem is (2). There are no commonly used mechanisms for
applications to announce what interface versions of an library package
they want to use. Installing library versions to different directories is
one option, but certainly not an easy one (application developers are not
the ones writing library installation scripts).

Another approach for (2) is the one now used by alsa-lib. In other words,
before including the library headers, we define what library interface
version we want to use.

So should we make this into a standard practise? In other words all apps
should define SND_PCM_SELECT_API_X, where X is the version number, before
including asoundlib.h. This would provide a framework for future API
extensions and changes (there's bound to be some, sooner or later).
If an app tries to select an interface that has already been dropped
from the latest alsa-lib, the compiler can then print an informative 
error message about the problem.

But as I mentioned in the beginning, a good argument against this
is that we are talking about a non-standard feature. Without good 
and visible documentation, developers don't know how to use the
SND_PCM_SELECT_API_X API selector. Ugh. :(

--
 http://www.eca.cx
 Audio software for Linux!
 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
