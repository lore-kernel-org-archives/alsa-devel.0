From: Werner Schweer <ws@seh.de>
Subject: Re: tascam us-122 midi in does not work
Date: Wed, 16 Jun 2004 19:25:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406161925.26126.ws@seh.de>
References: <200406131307.21072.ws@seh.de> <20040614224314.GA625@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040614224314.GA625@tuba.home>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Martin Langer <martin-langer@gmx.de>
List-Id: alsa-devel@alsa-project.org

On Tuesday 15 June 2004 00:43, Martin Langer wrote:
> On Sun, Jun 13, 2004 at 01:07:20PM +0200, Werner Schweer wrote:
> > Hello,
> >
> > Some strange effect occurs on my tascam us-122 audio/midi usb
> > device:
> >    After starting JACK the midi input does not work anymore. Not even
> > the midi in led on the us-122 flashes. Midi output is always fine.
> > After stopping JACK midi input still does not work. Midi input works
> > again after disconnect/reconnect the usb cable.
> > I'm using current ALSA cvs and kernel 2.6.7rc3.
> >
> > Can anyone confirm this to work on a normal system?
>
> Hmm. US122, 2.6.6 with ALSA 1.0.5 and jack works here. Another machine with
> us122 and ALSA CVS on 2.4.25rc1 is also fine.
>
> What about reconnecting midi clients without removing usb cable?

does not work either.

/Werner



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
