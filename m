From: Werner Schweer <ws@seh.de>
Subject: Re: tascam us-122 midi in does not work
Date: Fri, 18 Jun 2004 20:51:35 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406182051.35634.ws@seh.de>
References: <200406131307.21072.ws@seh.de> <200406161920.53116.ws@seh.de> <200406180609.02388.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200406180609.02388.annabellesgarden@yahoo.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 18 June 2004 06:09, Karsten Wiese wrote:
> Am Mittwoch 16 Juni 2004 19:20 schrieb Werner Schweer:
> > On Tuesday 15 June 2004 01:10, Karsten Wiese wrote:
> > > Am Sonntag 13 Juni 2004 13:07 schrieb Werner Schweer:
> > > > Hello,
> > > >
> > > > Some strange effect occurs on my tascam us-122 audio/midi usb
> > > > device:
> > > >    After starting JACK the midi input does not work anymore. Not even
> > > > the midi in led on the us-122 flashes. Midi output is always fine.
> > > > After stopping JACK midi input still does not work. Midi input works
> > > > again after disconnect/reconnect the usb cable.
> > > > I'm using current ALSA cvs and kernel 2.6.7rc3.
>
> <snip>
>
> > and after loading jack the logfile has an "urb status" message of -108
> > (ESHUTDOWN?) followed by a "usb_submit_urb: -32" (EPIPE) message.
> > From the above code i assume snd_usbmidi_urb_error() returns 0 for
> > status -108.
>
> Attachached is a raw-fix@cvs-head .
> Proofs here using aplay on 2.6.7 on fc1.
> PLease try it.

thank you, works fine!

/Werner



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
