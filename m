From: Chris Cannam <cannam@all-day-breakfast.com>
Subject: Re: Alsa sequencer port type flags
Date: Wed, 10 Dec 2003 13:11:22 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312101311.22675.cannam@all-day-breakfast.com>
References: <200312101113.52566.david.garcia@iua.upf.es> <3FD70734.6060502@boosthardware.com> <200312101335.39428.dgarcia@iua.upf.es>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312101335.39428.dgarcia@iua.upf.es>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Garcia Garzon <dgarcia@iua.upf.es>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 10 Dec 2003 12:35 pm, David Garcia Garzon wrote:
> [...]
> Each port has also the type bitmasks defined as follows:
> SND_SEQ_PORT_TYPE_SPECIFIC Hardware specific port
> SND_SEQ_PORT_TYPE_MIDI_GENERIC Generic MIDI device
> SND_SEQ_PORT_TYPE_MIDI_GM General MIDI compatible device
> [etc]

I am absolutely not an expert on this, but it's very similar to a 
question I've asked before on this list so I'll summarise my 
understanding of it and hope for corrections.

These flags indicate what sorts of sequencer events the port expects 
to be able to handle.  The fact that they refer to types of event 
rather than what the port does with those events seems to be quite an 
important distinction: for example, a port setting TYPE_SYNTH is 
saying nothing about whether it handles MIDI events or implements a 
MIDI synth, it's only saying that it can handle the direct synthesis 
class of event.  Equally it appears that an application should not 
necessarily set TYPE_APPLICATION unless it expects 
application-specific events, and so on.

For my purposes, the upshot was that I could not rely on these flags 
to find out what sort of application was implementing the port; I had 
hoped to test for soft synths with TYPE_SYNTH and TYPE_APPLICATION, 
for example, and that proved not to be possible.

> - Are they merely informative?

I think so.  I'm just not sure who the information is for.

> - Will Alsa coerce or enhance the port usage depending on that
> type?

I don't think so.

> - Can the user see that information in any way?

I don't know.  I don't think it would be terribly useful though.


Chris



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
