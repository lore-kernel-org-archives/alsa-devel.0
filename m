From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: Re: How to "connect" two audio devices with alsa?
Date: Mon, 10 Jun 2002 17:05:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D04C057.63BD6E51@folkwang-hochschule.de>
References: <Pine.LNX.3.96.1020609214246.10467A-100000@mickey.hamnixda.de>
Reply-To: lad <linux-audio-dev@music.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: linux-audio-dev@music.columbia.edu, Richard Guenther <richard.guenther@student.uni-tuebingen.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, lau <linux-audio-user@music.columbia.edu>
List-Id: alsa-devel@alsa-project.org

[cc:ing alsa-dev and lau]

Richard Guenther wrote:
> =

> Hi!
> =

> I'd like to create a virtual 2-(stereo)-channel alsa device from one
> ISA SB AWE and one on-board VIA alsa device. Has anyone figured out
> how to do this using .asoundrc magic? [I know Jaroslav knows and told
> Joern, but I think this is of greater interest]
> =

> Joern/Jaroslav, can you post a quick howto on this topic? Preferrably
> including some .asoundrc quoting...

just to clarify, this will not create the mythical "multi-channel
soundcard out of el-cheapo consumer cards". you will drift out of sync
over time. still, it is sometimes helpful to make applications see one
4channel card to allow for flexible routing if they can't easily be made
to talk to multiple cards (jack being one example).

here's how you do it (thanks to jaroslav and takashi for explaining it
to me). =


cat << EOF >> ~/.asoundrc

# create a virtual four-channel device with two soundcards:
# iiuc, this is in fact two interleaved stereo streams in
# different memory locations, so jack will complain that it
# cannot get mmap-based access. see below.
pcm.multi {
        type multi;
        slaves.a.pcm "hw:0,0";
        slaves.a.channels 2;
        slaves.b.pcm "hw:1,0";
        slaves.b.channels 2;
        bindings.0.slave a;
        bindings.0.channel 0;
        bindings.1.slave a;
        bindings.1.channel 1;
        bindings.2.slave b;
        bindings.2.channel 0;
        bindings.3.slave b;
        bindings.3.channel 1;
}
# i do not really understand what it means to have
# a ctl interface to a multi device. but jack will be
# unhappy if there is no mixer to talk to, so we set
# this to card 0.
ctl.multi {
	type hw;
        card 0;
}

# this creates a 4channel interleaved pcm stream based on
# the multi device. jack will work with this one.
pcm.ttable {
        type route;
        slave.pcm "multi";
        ttable.0.0 1;
        ttable.1.1 1;
        ttable.2.2 1;
        ttable.3.3 1;
}
# see above.
ctl.ttable {
        type hw;
        card 0;
}

EOF


a syntax description is in =

	http://www.alsa-project.org/alsa-doc/alsa-lib/conf.html .
the available plugins (i.e. the "type" entries) are described in the
doxygen docs at
	http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.htm .
it seems there is now also a LADSPA plugin plugin :) i have not tried it
yet, but it looks interesting.

to test the above setting, i feed a signal to both soundcards, play it
back and listen to it via with my external mixer:
# arecord -f cd -D multi -c 4 | aplay -D multi
this will give you loads of xruns, but it's probably ok for testing.

to start jack with the new device, use
# jackd [-a] -R [-v] -d alsa -d ttable [-p 1024]
=2E

i hope i got it right...
the settings Work For Me (tm), although i can't get ardour to record
from the device, but then i can't get it to record at all at the moment.
jack starts ok, though.

best,

j=F6rn

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
