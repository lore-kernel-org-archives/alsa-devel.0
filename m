From: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Subject: Re: Re: ice1712 driver broken in 2.6.1-mm kernels
Date: Wed, 21 Jan 2004 22:25:13 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.OSF.4.58.0401212214060.155462@kosh.hut.fi>
References: <1074633766.6579.2.camel@moria.arnor.net>
 <Pine.LNX.4.58.0401202308390.2010@pnote.perex-int.cz>
 <1074637277.6579.16.camel@moria.arnor.net> <Pine.LNX.4.58.0401210908220.2010@pnote.perex-int.cz>
 <1074712729.5895.11.camel@moria.arnor.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp-3.hut.fi (root@smtp-3.hut.fi [130.233.228.93])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA22006
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2004 21:25:15 +0100
In-Reply-To: <1074712729.5895.11.camel@moria.arnor.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Jaroslav Kysela <perex@suse.cz>, ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> Just one problem remains to be solved for this card:  The Audiophile
> 24/96 is a 4-in, 4-out card (stereo analog input and output, plus
> independent SPDIF input and output).  But only one set of inputs and
> outputs is showing up for use:
>
> [thoffman@moria thoffman]$ cat /proc/asound/pcm
> 01-00: ICE1712 multi : ICE1712 multi : playback 1 : capture 1
>
> Shouldn't there be separate devices for the analog & SPDIF inputs and
> outputs?  If not, how do I send different signals to the analog &
> digital outputs?

You have to create .asoundrc to your home directory.

for spdif, put:

pcm.2496_spdif
{
        type plug
        ttable.0.8 1
        ttable.1.9 1
        slave.pcm {
                type hw
                card 1
                device 0
        }
}

(If I remember correctly, your card was no. 1, if not, change 'card 1')

This device can be used like this:

aplay -D 2496_spdif foo.wav
arecord -D 2496_spdif -f dat bar.wav

For combined analog & digital performance (4 channels):

pcm.2496_4ch
{
        type plug
        ttable.0.0 1
        ttable.1.1 1
        ttable.2.8 1
        ttable.3.9 1
        slave.pcm {
        type hw
        card 1
        device 0
        }
}

then record 4 channels:

arecord -D 2496_4ch -c 4 -f cd foobar.wav


I'm not sure how you can easily send different signals to analog & digital
outputs. I guess if you have 4 channel wav, the first two channels will be
played to analog and 3&4 to digital output.

Tommi Uimonen


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
