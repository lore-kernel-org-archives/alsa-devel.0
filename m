From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: backwards incompatible ALSA api change?
Date: Tue, 10 Sep 2002 20:42:46 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209101958360.29024-100000@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

[sent also to alsa-dev - maybe I missed an announcement about this?]

The jack (Jack Audio Connection Kit, cvs from around the beginning of
September) code no longer compiles with the most recent alsa cvs:

alsa_driver.c: In function `alsa_driver_set_parameters':
alsa_driver.c:403: too few arguments to function 
`snd_pcm_hw_params_get_format'
alsa_driver.c:404: too few arguments to function 
`snd_pcm_hw_params_get_access'
alsa_driver.c:416: too few arguments to function 
`snd_pcm_hw_params_get_format'
alsa_driver.c:417: too few arguments to function 
`snd_pcm_hw_params_get_access'

There has been a backwards incompatible alsa api change. This is recent, I
guess, it compiles with cvs of 20020820.180035 (USA Pacific time). I know
there MUST a perfectly good reason for a backwards incompatible api change
at this point (some new extended format structure?), but may I say,
respectfully, something?

 ARGHHHHHHHHHH!!!!!

:-)

When trying to run a jack server with a newly compiled alsa driver and 
library I get a not very informative diagnostic from jack:

  jackd 0.37.2
  Copyright 2001-2002 Paul Davis and others.
  jackd comes with ABSOLUTELY NO WARRANTY
  This is free software, and you are welcome to redistribute it
  under certain conditions; see the file COPYING for details

  creating alsa driver ... hw|1024|2|48000|swmon
  programming error: unhandled format type

It is not segfaulting (why? is it just chance that it did not?)

To the alsa gurus: could a message be sent to alsa-dev when there are
backwards incompatible changes in the API please? It'd be good to know, I
think (at least _I_ would like to know). Please?

-- Fernando



-------------------------------------------------------
In remembrance
www.osdn.com/911/
