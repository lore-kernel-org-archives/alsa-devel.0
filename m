From: Chris Cannam <cannam@all-day-breakfast.com>
Subject: Re: Sequencer documentation follow-up
Date: Mon, 30 Jun 2003 16:12:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F00534C.7060706@all-day-breakfast.com>
References: <20030608220629.A7532@octothorpe.dyndns.org> <s5hof0fljw0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Drake Wilson <drake@libcom.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Sun, 8 Jun 2003 22:06:30 -0400,
> Drake Wilson wrote:
> 
>>... I have a draft, or part thereof.  It is in similar spirit to the
>>module overviews in the API reference, and I hope it to be of some
>>use, if not optimal.
>>[...]

I missed this until now.  Just to add that the meanings of the
various SND_SEQ_PORT_TYPE flags were covered in a discussion on
this list a few weeks ago.

It seems that the SND_SEQ_PORT_TYPE_* flags describe the sort of
events that a port understands and not necessarily what it does
with them.  The discussion here arose from a desire to query
these flags in order to attempt to distinguish MIDI soft synths
and on-card hardware synths from other MIDI applications such as
sequencers: it turns out that this is not possible.

For example, I believe it turned out that PORT_TYPE_APPLICATION
indicates a port expecting application-specific events, not just
a port that happens to belong to a software application.  That is,
a MIDI soft synth would not necessarily be expected to set this
flag.  Similarly, PORT_TYPE_SYNTH indicates that the port has the
ability to do (non-MIDI) direct synthesis, and again a MIDI soft
synth or a driver for a soundcard MIDI synth would not be expected
to set this flag unless it was also capable of direct synthesis.
So "port is attached to a synthesizer device" is unfortunately an
inadequate and misleading description for PORT_TYPE_SYNTH, as
ports attached to MIDI synth devices will generally not have this
flag set.  I found all this most confusing, but that's probably
because I don't really know anything about non-MIDI clients.

Look for the subject "Sequencer port type flags" in the archives
(in early May this year) for more details.


Chris



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
