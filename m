From: Martin Langer <martin-langer@gmx.de>
Subject: Re: bugs in usb midi alsa code?
Date: Wed, 6 Nov 2002 12:43:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021106114346.GA541@tuba.home>
References: <Pine.LNX.4.44.0211051140430.21282-100000@cmn37.stanford.edu> <200211061152.05605.ws@seh.de>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id MAA28308
	for <alsa-devel@alsa-project.org>; Wed, 6 Nov 2002 12:43:19 +0100
Content-Disposition: inline
In-Reply-To: <200211061152.05605.ws@seh.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Werner Schweer <ws@seh.de>, alsa-devel@alsa-project.org, clemens@ladisch.de, nando@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 06, 2002 at 11:52:05AM +0100, Werner Schweer wrote:
> 
> On Tuesday 05 November 2002 21:22, Fernando Pablo Lopez-Lezcano wrote:
> > The MIDI interface I'm using is a Midisport 2x2 (same results with a 1x1).
> >
> > It works fine with alsa cvs of 2002-08-20, has problems with alsa cvs of
> > 2002-10-28.
> >
> > This is a summary of what I have found so far.
> ...
> > ALSA:
> >   input does not seem to work at all. I'm using the Muse MIDI sequencer,
> >   with  the older alsa version it works fine (input), with the newer alsa
> >   version it does not record midi input at all. Output works fine on both
> >   alsa versions.
> 
> same on my Roland/Edirol UA100 (audio + 2 midi ports). Midi Input does
> not work.
> 

last but not least: same on my Evolution MK-249C keyboard using OPL3 or
amSynth. midi input doesn't work with alsa cvs ATM. we have a bug!


martin



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
