From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA sequencer event types?
Date: Wed, 10 Dec 2003 15:35:28 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0312101528240.776-100000@studcom.urz.uni-halle.de>
References: <200312101323.28101.cannam@all-day-breakfast.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200312101323.28101.cannam@all-day-breakfast.com>
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
> On Wednesday 10 Dec 2003 7:38 am, Clemens Ladisch wrote:
> > Chris Cannam wrote:
> > > I'm particularly intrigued by the SND_SEQ_EVENT_INSTR_* types
> > > which look suspiciously like they might be intended for something
> > > useful such as enabling soft-synths or samplers to report on
> > > their available program or patch sets.  Are they?
> >
> > Yes, they are exactly that, i.e., _intended_ for something useful.
>
> So in the hypothetical situation where a soft synth application really
> wanted to be able to tell the world of ALSA sequencer clients about
> what instruments, controllers etc it had available, it would have to
> use some other communication layer than the ALSA sequencer?

It could use some user-defined event (but as you wrote, it's hard to
detect support for this).  Or somebody could define the format and the
semantics of the _INSTR_INFO/FINFO/LIST events, and use those.

> I suppose one could define a simple protocol for something like
> the above based on the existing unused instrument event types
> [...] but how would you then discover whether or not a client
> supported that protocol?

This protocol would be part of the official ALSA API (just like
INSTR_PUT already is), so ALSA could define a new port type flag.


Regards,
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
