From: Chris Cannam <cannam@all-day-breakfast.com>
Subject: Re: [Rosegarden-devel] Re: Sequencer port type flags
Date: Fri, 09 May 2003 13:00:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EBB9841.8090805@all-day-breakfast.com>
References: <Pine.LNX.4.44.0305091237280.1237-100000@pnote.perex-int.cz>
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
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, rosegarden-devel <rosegarden-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> SNDRV_SEQ_PORT_TYPE_MIDI_* defines are for client which understands the 
> midi v1.0 commands and extensions

Right, so these flags are all about the events that a client
understands, not about describing the client as I had first
imagined.

So there is no way for a MIDI-based soft synth (that does not
support GM etc and does not do direct wavetable synthesis) to
indicate that it is a synth, for the benefit of an application
such as Rosegarden that would like to be able to show the user
a distinction between a soft synth and e.g. a record port on
another sequencer?

Similarly, since the APPLICATION type is not a MIDI_* type,
does that mean that it indicates a port that only understands
application-specific non-MIDI events?  So the numerous existing
soft synths that set APPLICATION on their MIDI input ports --
including the ALSA 0.9 programming howto example -- are actually
giving false (rather than merely incomplete) information?

And harking back to the other part of Pedro's initial question,
does this also mean that we shouldn't rely on the presence of
the SND_SEQ_PORT_TYPE_SYNTH flag to identify soundcard-hosted
MIDI synths that accept MIDI events (in order to distinguish
them from external MIDI devices), because that flag will not be
there if MIDI is all the synth's driver understands?


Chris



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
