From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [24/29] ALSA: dice: check clock change timeout
Date: Mon, 21 Oct 2013 21:34:26 +0200
Message-ID: <526581C2.4050001@ladisch.de>
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

Output a warning if the wait for the clock change notification times
out.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 61dd00c..3395c8b 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -551,8 +551,9 @@ static int dice_change_rate(struct dice *dice, unsigned int clock_rate)
 	if (err < 0)
 		return err;

-	wait_for_completion_timeout(&dice->clock_accepted,
-				    msecs_to_jiffies(100));
+	if (!wait_for_completion_timeout(&dice->clock_accepted,
+					 msecs_to_jiffies(100)))
+		dev_warn(&dice->unit->device, "clock change timed out\n");

 	return 0;
 }

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
