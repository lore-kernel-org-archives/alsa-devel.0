From: "Ed Wildgoose" <Ed@Wildgooses.com>
Subject: Re: HDSP 9632 driver and expansion cards
Date: Fri, 23 Jan 2004 17:16:27 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <01e001c3e1d4$a32393c0$5d40a8c0@FRiskMan.com>
References: <1074650862.6893.10.camel@rivendell.home.local> <400E74F6.1040803@undata.org> <02f701c3e04e$1f39d2e0$5d40a8c0@FRiskMan.com> <400EEDE9.80208@undata.org> <013301c3e0fc$f4ea92e0$5d40a8c0@FRiskMan.com> <4010F57E.7070207@undata.org>
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
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Thanks, this is good news. Could you also please test hdspmixer with the
> expansion board and confirm there's no problem here either ?

Yes, hdspmixer does all the right things with the extra channels.

There appears to be a minor bug in that the input channels 8 and 9 (I
think?), ie the top right two inputs (right of the spdif input), do not draw
properly initially.  The numbers, and bits of the outline appear, but the
sliders and bars don't draw.  At some later stage it all appears properly.

Since this is done using a remote xsession to a windows PC and cygwin I
can't be sure that this isn't just an X problem on win32...  It's a minor
issue anyway

Actually more of an issue is that there is a ton of X traffic when stuff is
playing which overwhelms my 802.11a network.  PC gets maxed out with a high
cpu load just trying to squirt all the traffic over SSH.  I wonder if we
could have variable refresh rates on the bouncing level meters?  Or perhaps
you could investigate whether less of the screen could be updated perhaps
(optimised drawing of boxes might reduce X traffic?)

Anyway, just a nice to have.  Thanks for what we have already though!


> Just to make it clear that this is a software problem and not the
> problem that Tim, Paul and Mark reported, could you please try to route
> an incoming signal (through analog or digital in) to your amp using
> hdspmixer and tell me if the routed sound suffers from the same audio
> corruption as the one being played back ? (this test should be done
> while you're playing back a stuttering software stream)

Sure, will do.  For what it's worth the same film works under xine, but not
mplayer.

Alsaplayer also works fine I think (on different files), as does aplay.  I
would be pretty sure that for a given FLAC file, alsaplayer would play it
fine and mplayer would stutter.

I will try and grab the mplayer source and have a peer at the audio output
code.


> I think the nicest feature you'd get with this design is the ability to
> manipulate totalmix/hdspmixer's enhanced mixer (with this output stage)
> from several applications in a coherent way (hdspmixer, ladpsa plugin,
> script, midi automation, etc...), a feature that people constantly ask
> for on the RME forum. This could also very well "sell" a few linux
> installs to RME customers :)

Please consider dropping me a line if you do any work on this.  I would love
to test it as you go along.

Thanks again



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
