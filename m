From: Nick Ing-Simmons <nick@ing-simmons.net>
Subject: Which API to use for simple clients?
Date: Fri, 02 Jan 2004 18:15:12 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040102181512.9272.3@llama.ing-simmons.net>
Reply-To: Nick Ing-Simmons <nick@ing-simmons.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-audio-dev@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I have two Audio related projects that need updating.

1. "rsynth" formant based text-to-speech synthesis

2. Audio::* Perl modules.

Both have existing /dev/dsp style backends at present, which have been work=
ing
fine. But recently (SuSE 9.0 install?) when run under ALSA emulation of=20
/dev/dsp they both started producing segfaults - "after program had exited",
(neither valgrind nor gdb can give any info on the fault).

So I decided it was time to do a native ALSA backend(s).
I have rsynth backend working, and perl Audio:: one almost working.
But before going forward I would like to solicit opinions on what=20
is the "right" API to use.

The Linux audio world seems to be in a state of flux with these options
(please tell me if I missed any):

1. Venerable OSS stuff
   - Widely available :-)
   - Some cards have quasi or truely commecial drivers rather than
     free / opensource ones :-(
   - emulation via ALSA (at least as shipped by SuSE) seems broken :-(

2. ALSA
   - Reasonably widely available :-|, and improving
   - Opensource :-)
   - Documentation is lacking :-(
     Everything hinges on the=20
     "Configuration Space" concept, but I can't find an explanation of=20
     how that works. This is the sticking point with perl code - I can't fi=
nd=20
     how to change the sample rate / channels, so _seems_ I need to=20
     close and re-open.=20=20

3. JACK=20
   - Gets lots of excited "this is cool" kind of coverage :-)
   - realtime :-)
   - Callback style not ideal for speech synthesis or play-from-file
     of my simple apps. complex :-(
=20=20=20=20
4. Enlightenment Sound Demon
   - Seems to be used by KDE etc.
   - haven't looked into it further.

5. Network Audio System=20
   - Works on many platforms Linux/Solaris/X Terminals :-)
   - X-like "imake" style rather than configure :-(
   - Linux version still seems to be based on OSS - so recurse ;-)

6. Presumably there is some kind of telephony API as well, for sending=20
   sound to incomming phone calls via modem / ISDN

Complexity and callbacks don't scare me - I do perl/Tk after all!
But this is a 2nd-string project so I don't want to do a lot of=20
complex stuff for an API that is vanishing - I would rather either=20
use a simple stable interface, or pitch in and help on the "comming"
complex API.

Suggestions anyone? (I just subscribed to both lists - so reply to your
favourite list.)

=20=20


=20


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
