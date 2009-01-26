From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re:
	=?iso-8859-1?q?=5BPATCH_1/2=5D_Remove_definition_for?=
	=?iso-8859-1?q?_surround_sound=09devices_on_ICE1712=2E?=
Date: Mon, 26 Jan 2009 17:43:03 +0000
Message-ID: <200901261743.03945.gineera@aspect135.co.uk>
References: <1232455075-27712-1-git-send-email-flameeyes@gmail.com>
	<200901211645.29939.gineera@aspect135.co.uk>
	<s5hmydk7h5v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-4.talktalk.net [62.24.128.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 238E31037EE
	for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2009 18:24:52 +0100 (CET)
In-Reply-To: <s5hmydk7h5v.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>, flameeyes@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wednesday 21 January 2009 16:33, you wrote:
> At Wed, 21 Jan 2009 16:45:29 +0000,
> Alan Horstmann wrote:
> > On Wednesday 21 January 2009 10:00, Takashi Iwai wrote:
> > > At Tue, 20 Jan 2009 17:33:24 +0100,
> > > Diego E. 'Flameeyes' Petten=F2 wrote:
> > > > Using the correct format, front:IDX should work with two channels
> > > > sound files, and it doesn't, nor surround40:IDX works with four
> > > > channels or surround71:IDX with eight channels.

<snip>

> > I think Diego's point though is that 'surround40:IDX' might be expected
> > to be a 4-channel stream, whereas it is as dependant on the hardware as
> > 'hw:IDX' is.  In the later case it is clear that the user must provide
> > audio in whatever format/channels the hardware uses.  However it is
> > unexpected that eg on ice1712 'surround40:IDX' requires a 10-channel
> > playback stream and ignores 6 of them, and will not play a 4-channel
> > stream.
> >
> > It is also not symetrical, so if you capture it has to be a 12-channel
> > stream, which it is then not possible to play without using the plug:
> > devices.
> >
> > Unless I am mistaken...
>
> Right, ice1712 is tricky as is.  I myself feel having plug inside the
> front, etc, definitions would be more intuitive.  However, the plug
> over plug doesn't (didn't? -- need checks) work.  And, the definition
> should be as slim as possible.  These are counter arguments.

It may be that you want to drop this completely, but I have done a little m=
ore =

testing and thinking, in case not.

The purpose of the 'front', 'surround' etc definitions is presumably to =

provide pre-configured routing to certain standard outputs where this is =

possible with the card hardware.  Therefore it seems reasonable for the use=
r =

to expect channel number conversion to be handled by these devices, as =

Diego's original proposal for 'front'.  One might augue the format conversi=
on =

should not be included since that really is the job of 'plug:front'.

In the case of ice1712 it is particularly useful due to the asymmetry of =

channels playback and capture.  That raises another question -what is the =

meaning of capture from a device such as 'surround'?  Would anyone want to =
do =

it and what would they expect (stereo/4-channel)?  Should the devices be =

playback only?  Capture would be very dependant on the specific board.  Is =

there any way to handle different conf files dependant on different ice1712 =

cards?

I have tested a modified ICE1712.conf with front definition similar to =

Diego's, essentially:-

	type asym
	playback.pcm {
		type route
		ttable.0.0 1
		ttable.1.1 1
		slave.pcm {
			type hw
			card $CARD
		}
		slave.channels 10
	}
	capture.pcm {
		type route
		ttable.0.0 1
		ttable.1.1 1
		slave.pcm {
			type hw
			card $CARD
		}
		slave.channels 12
	}

and can confirm playback of files with various channel numbers is possible =

fine.  Also, plug:front in this case still works fine.

I wondered what your thoughts are on this?

Alan
