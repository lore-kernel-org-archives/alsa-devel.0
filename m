From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: Invalid MIDI recordings and silent external playback
Date: Mon, 26 Aug 2002 12:04:28 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <004a01c24cf0$5fe8a7a0$0400a8c0@martijn>
References: <Pine.LNX.4.33.0208261015290.567-100000@pnote.perex-int.cz>
Reply-To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, Will <walsac@liam2.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > 4) BTW, is anyone working on MIDI RESET for ALSA 1.0.0?
> >    alsa-kernel/core/rawmidi.c says MIDI reset is in the
> >    TODO stage. I have instruments that sometimes need
> >    MIDI reset.  OSS/Linux 2.0.x had a handy seq_reset()
> >    in drivers/sound/sequencer.c which mostly worked well.
> 
> I've removed these unimplemented functions. Actually, the current 
> implementation sends 0xfe byte (active sensing) at close(). Sure, we
> may modify this code to satisfy some non-standard devices.

I don't understand. Can't an application that wants to reset a device
just send 0xff? And why send 0xfe at close? So the receiving device
will detect a connection loss 300msec later?
Shouldn't this all be left to the application?

--martijn





-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
