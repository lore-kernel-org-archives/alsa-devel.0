From: Martijn Sipkema <msipkema@sipkema-digital.com>
Subject: Re: MTP-AV problems (Re: intel8x0 sequencer & MTP-AV)
Date: Thu, 13 Feb 2003 16:05:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <002c01c2d371$47e5e890$161b14ac@boromir>
References: <1044258789.30428.61.camel@littlewolf2.littlewolf>
 <s5h3cn5ino4.wl@alsa2.suse.de>
 <1044273602.2013.6.camel@littlewolf2.littlewolf> <s5hheb8l05o.wl@alsa2.suse.de>
Reply-To: Martijn Sipkema <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Allan Klinbail <allank@labyrinth.net.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> recently a technical information about emagic unitor8 was revealed,

I suppose this doesn't mention AMT? Can I have this information. It
might contain more than what I already have.

> and it includes a small desription about MTP, too.
> there, the initialization sysex is mentionted, so perhaps this may
> influence on the behavior of the device.  (also, the smpte sysex is
> described!)

I think both devices act as a single MIDI device where the 0xf5 message
that is undefined in the MIDI spec is used for cable selection. Thus the
running status is for the MIDI stream and not per cable. I don't think
these devices use running status on transmitting (to the host at least)
themselves.

> before i start coding, i would like to ask you summarize the existing
> problems of mtpav driver (which most likely i forgot :)
> 
> i hope this time the bugs can be fixed, or at least improved...

Is it possible to open files from the kernel? I'd suggest having support
for devices like the Unitor in user-space to be able to support them on
any serial port if this is not the case.

--ms





-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
