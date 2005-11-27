From: John Rigg <ad@sound-man.co.uk>
Subject: envy24control word clock error
Date: Sun, 27 Nov 2005 19:24:50 +0000
Message-ID: <E1EgS8o-0001CV-7k@localhost.localdomain>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

When I start envy24control from xterm I get an endless stream of
"Unable to determine wordclock status: No such file or directory" and
"Unable to read word clock sync selection: No such file or directory" error
messages.
These don't stop until I shut down envy24control. The same occurs regardless
of what clock source I set in the GUI, or whether I link my two Delta1010s 
with SPDIF or wordclock in/out. It's the same with -c0, -c1 or both launched
from separate xterms.
The messages appear to come from master_clock_status_timeout_callback()
in envy24control/hardware.c (lines 160-175).

This is with alsa-tools-1.0.10 (also happens with rc2), alsa-lib-1.0.10,
kernel 2.6.14-rt20 x86_64 SMP (alsa 1.0.10rc1 drivers).
Anyone got any ideas?

John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
