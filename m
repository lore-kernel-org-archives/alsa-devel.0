From: Paul Davis <pbd@Op.Net>
Subject: Re: Need some hints for simple MIDI communication
Date: Fri, 08 Feb 2002 09:52:13 -0500
Message-ID: <200202081452.JAA27949@renoir.op.net>
In-reply-to: Your message of "Fri, 08 Feb 2002 00:55:33 +0100."
             <E16YyMU-00028E-00@smtp.web.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Frank Neumann <beachnase@web.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Anyway, I believe going with the sequencer is the better solution anyway;

IMHO, its not. i had to do this to download a huge firmware update via
sysex to our Alesis M20 ADAT's last year, and ran into all kinds of
problems. Unless your Sysex messages are all rather short, the
sequencer is not your friend, and raw MIDI is.

its possible that the memory allocation/management code in the
sequencer (both in the kernel and in alsa-lib) have been fixed, and
what i tried would now work, but given that the sequencer is really
there to perform 2 (orthogonal) functions [time sequencing of event
delivery; data routing/multiplexing] neither of which have anything to
do with sending/receiving patch sets, i can't see why you'd choose to
use it.

--p [ "sequence this!" ]

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
