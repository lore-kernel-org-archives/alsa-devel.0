From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: [linux-audio-user] Evolution UC16 problems,
 modules.conf for usb-midi and usb-audio together
Date: Wed, 23 Oct 2002 11:50:37 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210231130360.10224-100000@studcom.urz.uni-halle.de>
References: <1035337793.2875.116.camel@hamish.iriXx.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1035337793.2875.116.camel@hamish.iriXx.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: m <m@iriXx.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, Patrick Shirkey <pshirkey@boosthardware.com>
List-Id: alsa-devel@alsa-project.org

"m" wrote:
> Patrick Shirkey wrote:
>
> > There are some changes that need to be made regarding the modules.conf
> > file and the options for the driver. Specifically all snd_xxx references
> > have been changed to just xxx. Ie remove the snd_ prefix. This has been
> > done to ensure the alsa modules options are inline with the Kernel
> > standard. NB this is completely seperate from the module name which is
> > snd-xxx. That has not been changed.
> >
>
> hi Patrick, thanks again,
>
> my modules.conf for rc3 was as follows:
>
> # ALSA portion
>  alias char-major-116 snd
>  alias snd-card-0 snd-usb-audio
>
> ## oss/Free portion
>  alias char-major-14 soundcore
>  alias sound-slot-0 snd-card-0
>
> # card 1
>  alias sound-service-0-0 snd-mixer-oss
>  alias sound-service-0-1 snd-seq-oss
>  alias sound-service-0-3 snd-pcm-oss
>  alias sound-service-0-8 snd-seq-oss
>  alias sound-service-0-12 snd-pcm-oss
>  alias sound-slot-1 audio
>
> so i assume i change only need to change the second line to
>
> alias snd-card-0 usb-audio

No, this is a module name, which didn't change. The change is for module
options, but you're not using any, so the renaming doesn't affect you.
(There is a subtle difference between snd_xxx and snd-xxx.)

However, the alias for sound-slot-1 is wrong, "audio" is the name of
the OSS driver. Make that line
	alias sound-slot-1 snd-card-1
And you need to say which driver to use for snd-card-1. For the UC16 with
0.9.0rc3, it would be
	alias snd-card-1 snd-usb-midi
For 0.9.0rc4, it would be
	alias snd-card-1 snd-usb-audio

And when you have more than one card, you should tell the driver at which
index they should load.
If you have 0.9.0rc3, add these lines:
	options snd-usb-audio snd_index=0
	options snd-usb-midi snd_index=1
If you have 0.9.0rc4, add this line instead:
	options snd-usb-audio index=0,1 pid=0x2001


HTH
Clemens



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
