From: Torrey Hoffman <thoffman@arnor.net>
Subject: Re: Re: ice1712 driver broken in 2.6.1-mm kernels
Date: Thu, 22 Jan 2004 13:54:23 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074808462.13428.14.camel@moria.arnor.net>
References: <1074633766.6579.2.camel@moria.arnor.net>
	 <Pine.LNX.4.58.0401202308390.2010@pnote.perex-int.cz>
	 <1074637277.6579.16.camel@moria.arnor.net>
	 <Pine.LNX.4.58.0401210908220.2010@pnote.perex-int.cz>
	 <1074712729.5895.11.camel@moria.arnor.net>
	 <Pine.OSF.4.58.0401212214060.155462@kosh.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from devil.servak.biz (devil.servak.biz [209.124.81.2])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA16374
	for <alsa-devel@alsa-project.org>; Thu, 22 Jan 2004 22:54:36 +0100
In-Reply-To: <Pine.OSF.4.58.0401212214060.155462@kosh.hut.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Cc: Jaroslav Kysela <perex@suse.cz>, ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-01-21 at 12:25, Tommi Sakari Uimonen wrote:
...
> > [thoffman@moria thoffman]$ cat /proc/asound/pcm
> > 01-00: ICE1712 multi : ICE1712 multi : playback 1 : capture 1
> >
> > Shouldn't there be separate devices for the analog & SPDIF inputs and
> > outputs?  If not, how do I send different signals to the analog &
> > digital outputs?
> 
> You have to create .asoundrc to your home directory.

(example as below)

Thanks for the tip.  I tried your suggestion, but it doesn't work for
me.  My .asoundrc now has this in it:

pcm.maudio_analog {
	type hw
	card 1
	device 0
}

pcm.maudio_spdif {
	type plug
        ttable.0.8 1
        ttable.1.9 1
        slave.pcm {
                type hw
                card 1
                device 0
        }
}

I can play sound fine through the analog channel:
[thoffman@moria thoffman]$ aplay -D plug:maudio_analog 12.wav
Playing WAVE '12.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo

But when I try to use the spdif channel, I get an error:

[thoffman@moria thoffman]$ aplay -D plug:maudio_spdif 12.wav
Playing WAVE '12.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
aplay: pcm_write:1083: write error: Invalid argument

So, still no success using the digital output channel...

-- 
Torrey Hoffman <thoffman@arnor.net>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
