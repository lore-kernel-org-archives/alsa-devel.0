From: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Subject: Re: Re: ice1712 driver broken in 2.6.1-mm kernels
Date: Sun, 25 Jan 2004 22:59:11 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.OSF.4.58.0401252229580.419724@kosh.hut.fi>
References: <1074633766.6579.2.camel@moria.arnor.net>
 <Pine.LNX.4.58.0401202308390.2010@pnote.perex-int.cz>
 <1074637277.6579.16.camel@moria.arnor.net> <Pine.LNX.4.58.0401210908220.2010@pnote.perex-int.cz>
 <1074712729.5895.11.camel@moria.arnor.net> <Pine.OSF.4.58.0401212214060.155462@kosh.hut.fi>
 <1074808462.13428.14.camel@moria.arnor.net> <Pine.OSF.4.58.0401230000480.447402@kosh.hut.fi>
 <1074811750.13428.68.camel@moria.arnor.net> <Pine.OSF.4.58.0401230051410.447402@kosh.hut.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp-1.hut.fi (root@smtp-1.hut.fi [130.233.228.91])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA25955
	for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2004 21:59:18 +0100
In-Reply-To: <Pine.OSF.4.58.0401230051410.447402@kosh.hut.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > The one problem is I still can't play different wave files
> > simultaneously through the two outputs.
> >
> > If I start "aplay -D maudio_spdif 12.wav &" and then try to do "aplay -D
> > plug:maudio_analog 11.wav" at the same time, the second one just blocks
> > until the first one is done.
> >
> > This is unfortunate, since I'd really like to be able to run two-room
> > sound from my computer into different amplifiers and speakers.  I'm sure
> > there's a way to do it, since the hardware is capable of it...

Now after thinking this, I think ecasound is the right tool for this.

Create a device to .asoundrc: (with correct card number of course)

pcm.2496_4ch
{
        type plug
        ttable.0.0 1
        ttable.1.1 1
        ttable.2.8 1
        ttable.3.9 1
        slave.pcm {
        type hw
        card 0
        device 0
        }
}

Then use ecasound with this device, and take input from two sources and
send them to the appropriate channels, first input to channels 1&2, second
to channels 3&4.

I don't know the right way to do this, but I know that it can be done.
Since ecasound can split 4 channel wav to separate channels, I don't see
why it wouldn't join two stereo samples to one 4 channel sample.

Maybe you'll have to ask this from ecasound-list

http://www.eca.cx/mlists.html


Tommi


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
