From: Chris Cannam <cannam@all-day-breakfast.com>
Subject: Re: ALSA sequencer event types?
Date: Wed, 10 Dec 2003 13:23:28 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312101323.28101.cannam@all-day-breakfast.com>
References: <Pine.HPX.4.33n.0312100827410.3830-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0312100827410.3830-100000@studcom.urz.uni-halle.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 10 Dec 2003 7:38 am, Clemens Ladisch wrote:
> Chris Cannam wrote:
> > Is there any documentation for the squillions of
> > interesting-looking event types defined in snd_seq_event_type?
>
> The source.

Ah.

> > I'm particularly intrigued by the SND_SEQ_EVENT_INSTR_* types
> > which look suspiciously like they might be intended for something
> > useful such as enabling soft-synths or samplers to report on
> > their available program or patch sets.  Are they?
>
> Yes, they are exactly that, i.e., _intended_ for something useful.

Ah.

So in the hypothetical situation where a soft synth application really 
wanted to be able to tell the world of ALSA sequencer clients about 
what instruments, controllers etc it had available, it would have to 
use some other communication layer than the ALSA sequencer?

I had always assumed that was the case, but then I just thought I 
might not have been paying enough attention to all those other wacky 
event types.  I guess the fact that they're not used within ALSA 
doesn't mean they wouldn't be delivered to any client that decided to 
use them for its own nefarious purposes?  I suppose one could define 
a simple protocol for something like the above based on the existing 
unused instrument event types, or the existing user-defined event 
types... but how would you then discover whether or not a client 
supported that protocol?


Chris



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
