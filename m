From: Chris Cannam <cannam@all-day-breakfast.com>
Subject: ALSA sequencer event types?
Date: Tue, 9 Dec 2003 16:14:51 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312091614.51285.cannam@all-day-breakfast.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Is there any documentation for the squillions of interesting-looking 
event types defined in snd_seq_event_type?  I'm only familiar at all 
with the MIDI-based types, and I've failed to find anything referring 
to most of the others except for the trivial generated documentation.

I'm particularly intrigued by the SND_SEQ_EVENT_INSTR_* types which 
look suspiciously like they might be intended for something useful 
such as enabling soft-synths or samplers to report on their available 
program or patch sets.  Are they?  Do any applications use them?


Chris



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
