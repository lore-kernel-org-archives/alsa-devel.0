From: thomas charbonnel <thomas@undata.org>
Subject: [PATCH] HDSP: fix typo in midi code
Date: Sat, 12 Feb 2005 12:15:18 +0100
Message-ID: <1108206919.30766.9.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-1fFLZJjZqit/5+5YJr6n"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-1fFLZJjZqit/5+5YJr6n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

This fixes a typo I introduced with the previous patch (preventing the
second midi device to work properly when processing midi from the
interrupt handler (this is not enabled by default)). Sorry about that.

Thomas


Summary: fix typo in midi code

Signed-off-by: Thomas Charbonnel <thomas@undata.org>



--=-1fFLZJjZqit/5+5YJr6n
Content-Disposition: attachment; filename=hdsp_typo_fix.patch
Content-Type: text/x-patch; name=hdsp_typo_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- hdsp.c.cvs	2005-02-12 12:08:47.000000000 +0100
+++ hdsp.c	2005-02-12 12:09:40.000000000 +0100
@@ -3678,7 +3678,7 @@
 			hdsp->midi[1].pending = 1;
 			schedule = 1;
 		} else {
-			snd_hdsp_midi_input_read (&hdsp->midi[0]);
+			snd_hdsp_midi_input_read (&hdsp->midi[1]);
 		}
 	}
 	if (hdsp->use_midi_tasklet && schedule)

--=-1fFLZJjZqit/5+5YJr6n--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
