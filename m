From: Lance Blisters <geoff@hurl.ugcs.caltech.edu>
Subject: Re: 16-channel recording w/ LAYLA, ALSA, JACK, ARDOUR
Date: Fri, 14 Apr 2006 01:26:32 -0700
Message-ID: <20060414082632.GA21247@hurl.ugcs.caltech.edu>
References: <20060412200957.GA4090@hurl.ugcs.caltech.edu> <1144873089.27496.22.camel@mindpipe> <1144878001.27496.33.camel@mindpipe> <20060413031705.GA9160@hurl.ugcs.caltech.edu> <1144898970.10666.139.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1144898970.10666.139.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Well, I did have to patch JACK with MMAP_COMPLEX, I did have to
patch alsa-lib pcm_multi.c to enable duplex, I did some more
tests with .asoundrc.  I had to use echomixer to change some of
the settings before i could access the 8 digital outputs even directly.
I also discovered that during testing the LAYLA would get into 
bad states where even simple access no longer worked, and would 
have to reboot to get it working.  My multi declaration couldn't
refer directly to hw:2,0 but rather to a different pcm definition 
which in turn referred to hw:2,0.  I must open all channels of the
multi devices.

Now I have latest JACK from CCRMA in /usr/lib and JACK from CVS
patched for MMAP in a local directory.  I have alsa-lib RPM from
fedora core updates, patched for duplex multi access.  I can run
my patched JACK, and i can open multi_playback and multi_capture
with 16 channels each, JACK runs and reports the rare XRUN.  But
I can't connect from any clients; starting with QJACKCTL yields
"Cannot connect to JACK server as client" and ardour tries to start
its own server then fails because one is already running, then
"Could not connect to JACK server as  "ardour"".  I get the
same JACK connection problem whether using direct card access
or ALSA multi device.

Must be related to permissions / capabilities?  I'm running
everything as root, which works with CCRMA's JACK.  CCRMA doesn't
seem to offer SRPMS anymore, so I can't recreate how it was built.
Maybe some autogen.sh args will yield a compatible JACK?  I
built with and without --enable-capablities and got same results.

  -geoff



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
