From: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Subject: Re: Re: ice1712 driver broken in 2.6.1-mm kernels
Date: Fri, 23 Jan 2004 01:17:55 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.OSF.4.58.0401230051410.447402@kosh.hut.fi>
References: <1074633766.6579.2.camel@moria.arnor.net>
 <Pine.LNX.4.58.0401202308390.2010@pnote.perex-int.cz>
 <1074637277.6579.16.camel@moria.arnor.net> <Pine.LNX.4.58.0401210908220.2010@pnote.perex-int.cz>
 <1074712729.5895.11.camel@moria.arnor.net> <Pine.OSF.4.58.0401212214060.155462@kosh.hut.fi>
 <1074808462.13428.14.camel@moria.arnor.net> <Pine.OSF.4.58.0401230000480.447402@kosh.hut.fi>
 <1074811750.13428.68.camel@moria.arnor.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp-2.hut.fi (root@smtp-2.hut.fi [130.233.228.92])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA18195
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2004 00:17:57 +0100
In-Reply-To: <1074811750.13428.68.camel@moria.arnor.net>
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

> > It should be -D maudio_spdif, so lose the plug: and it will work. I think
> > the analog should also work without plug.
>
> Thanks!  That did it, mostly...  I now can play sound through the SPDIF!
>
> The analog doesn't work without "plug", I get an error "aplay:
> set_params:827: Sample format non available".  I think it's because the
> 2496 driver only does 24bit, so 16bit pcm requires translation.

Yes, of course.

> But that's not a problem - plug works fine.
>
> The one problem is I still can't play different wave files
> simultaneously through the two outputs.
>
> If I start "aplay -D maudio_spdif 12.wav &" and then try to do "aplay -D
> plug:maudio_analog 11.wav" at the same time, the second one just blocks
> until the first one is done.
>
> This is unfortunate, since I'd really like to be able to run two-room
> sound from my computer into different amplifiers and speakers.  I'm sure
> there's a way to do it, since the hardware is capable of it...

Well, some kind of dmix approach might do it.

app1 >--      --> analog
        \    /
         dmix
        /    \
app2 >--      --> spdif

I don't know how to do it. I think this kind of plug device would be
popular among 5.1 owners, where you could define what input goes to what
output. Something like:

-D dmix_rear
-D dmix_front

etc..

But how to separate them from the mix? Anyway, dmix allows multiple
instances to use the soundcard, so it's a start.

Maybe the plugins can be linked so that output of one goes to input of the
other. I guess this can be done, but I'm not any .asoundrc magician.

Or ttable & bindings...

http://www.alsa-project.org/alsa-doc/doc-php/asoundrc.php3



Tommi


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
