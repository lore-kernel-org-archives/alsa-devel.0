From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: [PATCH]snd_seq_midi_event: Unknown symbol cleanup_module
 [PATCH]
 Unknown symbol init_module and cleanup_module in snd_seq_midi_event
Date: Sun, 20 Feb 2005 17:56:51 +0100
Message-ID: <4218C153.6030207@glocalnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

I had problems loading the snd_seq_midi_event compiled from ALSA cvs. 
I'm using Debian Sarge with the following kernel packages:

kernel-headers-2.6.10-1-k7 2.6.10-4
kernel-image-2.6.10-1-k7 2.6.10-4

The problem was caused by undefined symbols in snd_seq_midi_event.

  snd_seq_midi_event: Unknown symbol cleanup_module
  snd_seq_midi_event: Unknown symbol init_module

I solved it by adding an init and exit function to seq_midi_event.c. Is 
this a bug in ALSA or Debian?

Regards,
Mikael

Index: ../alsa-kernel/core/seq/seq_midi_event.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/seq/seq_midi_event.c,v
retrieving revision 1.14
diff -u -r1.14 seq_midi_event.c
--- ../alsa-kernel/core/seq/seq_midi_event.c    29 Nov 2004 14:09:45 -0000
         1.14
+++ ../alsa-kernel/core/seq/seq_midi_event.c    20 Feb 2005 16:51:01 -0000
@@ -511,6 +511,19 @@
         return idx;
  }

+
+static int __init alsa_seq_midi_event_init(void)
+{
+       return 0;
+}
+
+static void __exit alsa_seq_midi_event_exit(void)
+{
+}
+
+module_init(alsa_seq_midi_event_init)
+module_exit(alsa_seq_midi_event_exit)
+
  /*
   *  exports
   */


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
