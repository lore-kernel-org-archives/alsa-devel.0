From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: [linux-audio-user] Evolution UC16 problems,
 modules.conf for usb-midi and usb-audio together
Date: Wed, 23 Oct 2002 15:00:22 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210231352020.18156-100000@studcom.urz.uni-halle.de>
References: <1035368915.3177.40.camel@hamish.iriXx.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1035368915.3177.40.camel@hamish.iriXx.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: m <m@iriXx.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

"m" wrote:
> > 	alias sound-slot-1 snd-card-1
> > 	alias snd-card-1 snd-usb-audio
>
> the only thing i'm confused on is that i've now got 2 entries that say
>
> alias sound-slot-0 snd-card-0
> alias snd-card-0 snd-usb-audio
>
> alias sound-slot-1 snd-card-1
> alias snd-card-1 snd-usb-audio
>
> im wondering if this is actually necessary when i've got only one USB
> port - if usb midi now uses the snd-usb-audio driver, then theoretically
> i only actually need to put in one card entry, the same driver should
> work for both?...

I assumed that you wanted to use a Quattro and a UC16 together. In this
case, you need one entry for each card, although they're handled by the
same driver.

The snd-card-x entries are used for autoloading: when you try to access
PCM device hw:x,y and this device doesn't yet exist, ALSA knowns that it
should load the driver specified by snd-card-x.


HTH
Clemens



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
