From: Paul Davis <paul@linuxaudiosystems.com>
Subject: using the sequencer with raw byte streams?
Date: Sun, 20 Jul 2003 19:28:02 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307202328.h6KNS2I01842@linuxaudiosystems.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

is there a relatively simple way to use the sequencer with raw byte
streams? i want to create an "ASEQ_Port" type for libmidi++, but
unlike the current support port types, the sequencer seems to be
totally based on typed events. libmidi++ allows applications to format
arbitrary messages and have them delivered to a port. it also has its
own sophisticated parser that includes heavy use of libsigc++ to allow
anonymous notification of many more event types than the sequencer
code currently defines. 

i'd like to find a way to connect these two abstractions together
somehow, since it would make Ardour play "nice" in the set of
sequencer clients that already exist. i can see the "RAW" event type
flag, which looks as if it might work for delivery data to the
sequencer, but i can't see any mechanism for retrieving unparsed data
from the system. can it be done?


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
