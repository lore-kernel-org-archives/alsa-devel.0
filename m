From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [26/29] ALSA: dice: document quadlet alignment
Date: Mon, 21 Oct 2013 21:35:25 +0200
Message-ID: <526581FD.5080006@ladisch.de>
References: <52657E3B.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52657E3B.7040205@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Doing accesses without quadlet alignment is a bad idea because the
firmware's byte-swapping would garble the data; clarify this in the
documentation.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice-interface.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/dice-interface.h b/sound/firewire/dice-interface.h
index af916b9..27b044f 100644
--- a/sound/firewire/dice-interface.h
+++ b/sound/firewire/dice-interface.h
@@ -7,9 +7,9 @@

 /*
  * Generally, all registers can be read like memory, i.e., with quadlet read or
- * block read transactions with any alignment or length.  Writes are not
- * allowed except where noted; quadlet-sized registers must be written with
- * a quadlet write transaction.
+ * block read transactions with at least quadlet-aligned offset and length.
+ * Writes are not allowed except where noted; quadlet-sized registers must be
+ * written with a quadlet write transaction.
  *
  * All values are in big endian.  The DICE firmware runs on a little-endian CPU
  * and just byte-swaps _all_ quadlets on the bus, so values without endianness

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
