From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA sequencer event types?
Date: Wed, 10 Dec 2003 08:38:54 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0312100827410.3830-100000@studcom.urz.uni-halle.de>
References: <200312091614.51285.cannam@all-day-breakfast.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200312091614.51285.cannam@all-day-breakfast.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Cannam <cannam@all-day-breakfast.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Chris Cannam wrote:
> Is there any documentation for the squillions of interesting-looking
> event types defined in snd_seq_event_type?

The source.

> I'm particularly intrigued by the SND_SEQ_EVENT_INSTR_* types which
> look suspiciously like they might be intended for something useful
> such as enabling soft-synths or samplers to report on their available
> program or patch sets.  Are they?

Yes, they are exactly that, i.e., _intended_ for something useful.

> I'm only familiar at all with the MIDI-based types, and I've
> failed to find anything referring to most of the others except for
> the trivial generated documentation.

Things like client/port/subscription notifications should be obvious.
After grepping for the others, it turns out those are rather easy to
describe:

SYSTEM:	"system status" -- Not used.

SYNC_POS: "sync position changed" -- Not used.

BOUNCE: Not used.

SAMPLE_xxx: Used by gus and trident drivers to directly access
	hardware voices.

INSTR_BEGIN, INSTR_END, INSTR_PUT, INSTR_FREE:
	Used by opl3, gus, trident drivers to load instrument data.
	(Neither gus nor trident drivers implement a MIDI synthesizer.)
	(The emu8/10k drivers use an hardware-specific mechanism which is
	available via the OSS sequencer emulation only.)

RESULT: Sent to signal the result of an INSTR_BEGIN/END/PUT/FREE
	event.

INSTR_INFO, INSTR_FINFO, INSTR_RESET, INSTR_STATUS, INSTR_GET,
INSTR_LIST, INSTR_CLUSTER, INSTR_CLUSTER_GET:
	Not implemented.

INSTR_INFO_RESULT, INSTR_FINFO_RESULT, INSTR_STATUS_RESULT,
INSTR_GET_RESULT, INSTR_LIST_RESULT, INSTR_CLUSTER_RESULT:
	Pffft.


Regards,
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
