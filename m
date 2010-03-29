From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: digiface vs. multiface vs. jack vs. other cards
Date: Mon, 29 Mar 2010 10:49:47 -0700
Message-ID: <1269884987.354.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <jack-devel-bounces@lists.jackaudio.org>
List-Unsubscribe: <http://lists.jackaudio.org/options.cgi/jack-devel-jackaudio.org>,
	<mailto:jack-devel-request@lists.jackaudio.org?subject=unsubscribe>
List-Archive: <http://lists.jackaudio.org/private.cgi/jack-devel-jackaudio.org>
List-Post: <mailto:jack-devel@lists.jackaudio.org>
List-Help: <mailto:jack-devel-request@lists.jackaudio.org?subject=help>
List-Subscribe: <http://lists.jackaudio.org/listinfo.cgi/jack-devel-jackaudio.org>,
	<mailto:jack-devel-request@lists.jackaudio.org?subject=subscribe>
Sender: jack-devel-bounces@lists.jackaudio.org
Errors-To: jack-devel-bounces@lists.jackaudio.org
To: ALSA development <alsa-devel@alsa-project.org>, Jack devel <jack-devel@lists.jackaudio.org>, linux-audio-dev@lists.linuxaudio.org
List-Id: alsa-devel@alsa-project.org

At CCRMA we have several studios with linux computers in them (in
addition to computers sprinkled throughout the building). Some of the
studios have digiface interfaces, some multiface. All of them are
connected to the sound system or mixer digitally through adat
lightpipes. Workstations have Delta 66 or Gina3G soundcards. 

It would be nice for a user to be able to play, say, a stereo Ardour
session in any of them without any changes to the session or routing. 

The digifaces send channels 1-24 out the adat ports. The multifaces on
the other hand send 9-16 on the adat port. Deltas and Ginas send out
stuff on channels 1-4 or 1-6. 

You can see the multiface interfaces are a problem. To get sound out of
them you have to send on channels 9-16 which is different from _all_
others! 

I tried several workarounds without much success:

a) fix this at the alsa level. Should be the way to go, right? Create
an /etc/asound.conf that uses ttable to translate channels for the
multifaces so that the digital out is actually sent through channels 1-8
(and create the same name plug interface in all other computers that
does nothing so that the user can set that name as the default in
qjackctl and will get the same behavior in all computers). 

Works, but not quite. When I try to use that "fake" plug interface with
jack2 I get a warning that I'm using a plug interface (sort of fair) and
jack only opens it with _2_ i/o channels (even though the ttable is 18
channels wide!). If I _force_ input and output channels in jack to 18 it
does work fine. But now it will _not_ work on other computers that have
less (or more) than 18 channels. Argh. 

b) fix it in hdspmixer. Well, it turns out that hdspmixer does not read
the default matrix gains from a file so I can't really override the
default. AFAICT the gains are calculated algorithmically in the code and
there is no command line option to load presets from a file. 

Or I could write a small script that will set the right gains for 1-8 to
go out through 9-16 but if a user starts hdspmixer that gets undone with
no warning. 

And, of course:

c) give up and connect an 8 channel analog snake to the analog outputs
of the multifaces and do away with a digital connection to the mixer...

Anyone has any other suggestions??
This should be easy to fix, right?
:-)
-- Fernando
