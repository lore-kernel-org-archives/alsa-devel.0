From: "Ed Wildgoose" <Ed@Wildgooses.com>
Subject: Re: HDSP 9632 driver and expansion cards
Date: Thu, 22 Jan 2004 15:06:05 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <012301c3e0f9$42e41bf0$5d40a8c0@FRiskMan.com>
References: <1074650862.6893.10.camel@rivendell.home.local> <400E74F6.1040803@undata.org> <02f701c3e04e$1f39d2e0$5d40a8c0@FRiskMan.com> <1074711322.4129.4.camel@rivendell.home.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > > Florin Andrei wrote :
> > > > Anyone using the latest RME HDSP 9632 driver in ALSA, while also
using
> > > > the expansion cards? I mean, the newer AI4S-192 and/or AO4S-192
which
> > > > are required to get the 192kHz sampling on all analogs.
>
> > I have a 9632 now and also the 4 port analogue expansion card.
>
> The new, 192kHz ones?

Hi, tested this very briefly last night (I only have enough plugs to wire up
a single channel...), and got sound out of it!!  Wahey!

Yes, it is the new 192Khz one, and the card has balanced, large 1/4" phono
sockets out of the back (which is useful, yet inconvenient).

For what it is worth, I have an RME 96/8PAD card, and the sound quality
(analogue out) is basically identical.  Test done using a fairly decent hifi
system with speakers.  Perhaps with headphones you could discern a
difference?

I would suggest that you could save money and stick with the 96khz 96/8PAD
card unless you need some of the 9632 features

Both however, have excellent sound quality and are easily on a par with my
Meridian 508.24 CD player.  I can hear practically no difference on the
analogue output of each.  I would very much recommend the card to anyone
looking to implement a high end hifi system and not wanting to have to feed
CD's into the machine (rip 'em all to the HD and play them all from the
couch with a remote control...)

However, as a negative to the 9632 card, I find that I can't use it with
many apps such as Mythtv, mplayer, etc.  The sound just stutters.  I suspect
that the driver defaults to a short period size and some of these apps don't
request anything other than the default?  Is there any way to use the
asound.conf file to force a specific period size?  Since this is just doing
home music duties, I don't really need or care for the ultra-low latency
capabilities of the 9632...

It would also be extremely cool if there was a simple master mixer control
in the alsa mixer.  This would reduce all channels simultaneously and allow
easy use as a 5.1 surround component.

Thanks very much to Thomas for writing this driver!

Ed W



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
