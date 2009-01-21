From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re:
	=?iso-8859-1?q?=5BPATCH_1/2=5D_Remove_definition_for?=
	=?iso-8859-1?q?_surround_sound=09devices_on_ICE1712=2E?=
Date: Wed, 21 Jan 2009 16:45:29 +0000
Message-ID: <200901211645.29939.gineera@aspect135.co.uk>
References: <1232455075-27712-1-git-send-email-flameeyes@gmail.com>
	<m2d4ei9bu3.fsf@gmail.com> <s5h4ozt2d3r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-1.talktalk.net [62.24.128.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 908172415A
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 17:28:43 +0100 (CET)
In-Reply-To: <s5h4ozt2d3r.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: ALSA devel <alsa-devel@alsa-project.org>, flameeyes@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wednesday 21 January 2009 10:00, Takashi Iwai wrote:
> At Tue, 20 Jan 2009 17:33:24 +0100,
>
> Diego E. 'Flameeyes' Petten=F2 wrote:
> > Jaroslav Kysela <perex@perex.cz> writes:
> > > Note that front and surround devices does not support automatic sample
> > > conversion. Use plug:front, plug:surround40 etc. devices.
> >
> > Using the correct format, front:IDX should work with two channels sound
> > files, and it doesn't, nor surround40:IDX works with four channels or
> > surround71:IDX with eight channels.
> >
> > [I'm using IDX because I have it on :1 rather than :0]
>
> I thought plug:front:IDX works, at least on 1.0.19, too...

It does work here on older Alsa.

I think Diego's point though is that 'surround40:IDX' might be expected to =
be =

a 4-channel stream, whereas it is as dependant on the hardware as 'hw:IDX' =

is.  In the later case it is clear that the user must provide audio in =

whatever format/channels the hardware uses.  However it is unexpected that =
eg =

on ice1712 'surround40:IDX' requires a 10-channel playback stream and ignor=
es =

6 of them, and will not play a 4-channel stream.

It is also not symetrical, so if you capture it has to be a 12-channel stre=
am, =

which it is then not possible to play without using the plug: devices.

Unless I am mistaken...

Alan
