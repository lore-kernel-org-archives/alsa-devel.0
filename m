From: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Subject: Re: Re: ice1712 driver broken in 2.6.1-mm kernels
Date: Fri, 23 Jan 2004 00:02:49 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.OSF.4.58.0401230000480.447402@kosh.hut.fi>
References: <1074633766.6579.2.camel@moria.arnor.net>
 <Pine.LNX.4.58.0401202308390.2010@pnote.perex-int.cz>
 <1074637277.6579.16.camel@moria.arnor.net> <Pine.LNX.4.58.0401210908220.2010@pnote.perex-int.cz>
 <1074712729.5895.11.camel@moria.arnor.net> <Pine.OSF.4.58.0401212214060.155462@kosh.hut.fi>
 <1074808462.13428.14.camel@moria.arnor.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp-2.hut.fi (root@smtp-2.hut.fi [130.233.228.92])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA16578
	for <alsa-devel@alsa-project.org>; Thu, 22 Jan 2004 23:02:51 +0100
In-Reply-To: <1074808462.13428.14.camel@moria.arnor.net>
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

> Thanks for the tip.  I tried your suggestion, but it doesn't work for
> me.  My .asoundrc now has this in it:
>
> pcm.maudio_analog {
> 	type hw
> 	card 1
> 	device 0
> }
>
> pcm.maudio_spdif {
> 	type plug
>         ttable.0.8 1
>         ttable.1.9 1
>         slave.pcm {
>                 type hw
>                 card 1
>                 device 0
>         }
> }
>
> I can play sound fine through the analog channel:
> [thoffman@moria thoffman]$ aplay -D plug:maudio_analog 12.wav
> Playing WAVE '12.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
> Stereo
>
> But when I try to use the spdif channel, I get an error:
>
> [thoffman@moria thoffman]$ aplay -D plug:maudio_spdif 12.wav
> Playing WAVE '12.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
> Stereo
> aplay: pcm_write:1083: write error: Invalid argument

It should be -D maudio_spdif, so lose the plug: and it will work. I think
the analog should also work without plug.

Tommi


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
