From: m <m@iriXx.org>
Subject: Re: Re: [linux-audio-user] Evolution UC16 problems,
	modules.conf for usb-midi and usb-audio together
Date: 23 Oct 2002 11:28:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1035368915.3177.40.camel@hamish.iriXx.org>
References: <Pine.HPX.4.33n.0210231130360.10224-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0210231130360.10224-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

hi, and thanks,

> However, the alias for sound-slot-1 is wrong, "audio" is the name of
> the OSS driver. Make that line
> 	alias sound-slot-1 snd-card-1
> And you need to say which driver to use for snd-card-1. For the UC16 with
> 0.9.0rc3, it would be
> 	alias snd-card-1 snd-usb-midi
> For 0.9.0rc4, it would be
> 	alias snd-card-1 snd-usb-audio

thats great, thanks... i have 0.9.0rc4

the only thing i'm confused on is that i've now got 2 entries that say

alias sound-slot-0 snd-card-0
alias snd-card-0 snd-usb-audio

alias sound-slot-1 snd-card-1
alias snd-card-1 snd-usb-audio

im wondering if this is actually necessary when i've got only one USB
port - if usb midi now uses the snd-usb-audio driver, then theoretically
i only actually need to put in one card entry, the same driver should
work for both?...
> 
> And when you have more than one card, you should tell the driver at which
> index they should load.
> If you have 0.9.0rc3, add these lines:
> 	options snd-usb-audio snd_index=0
> 	options snd-usb-midi snd_index=1
> If you have 0.9.0rc4, add this line instead:
> 	options snd-usb-audio index=0,1 pid=0x2001

thats great, thanks so much

m~
-- 
iriXx
www.iriXx.org

copyleft: creativity, technology and freedom?
info@copyleftmedia.org.uk
www.copyleftmedia.org.uk

 _
( )  ascii ribbon against html email
 X
/ \    cat /dev/sda1 > /dev/dsp


  *** stopping make sense ***



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
