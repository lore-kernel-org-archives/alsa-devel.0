From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] ppc32: Small build fix for alsa powermac
Date: Mon, 02 May 2005 11:40:30 +1000
Message-ID: <1114998030.7112.364.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi !

My newer iMac mini driver doesn't build with verbose debug enabled. This
fixes it, and removes an erroneous error printk (since it's normal on
some machine to not find some gpios on the "first try").

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/sound/ppc/toonie.c
===================================================================
--- linux-work.orig/sound/ppc/toonie.c	2005-05-02 10:51:00.000000000 +1000
+++ linux-work/sound/ppc/toonie.c	2005-05-02 11:38:22.000000000 +1000
@@ -279,8 +279,7 @@
 	if (! base) {
 		base = (u32 *)get_property(np, "reg", NULL);
 		if (!base) {
-			DBG("(E) cannot find address for device %s !\n", device);
-			snd_printd("cannot find address for device %s\n", device);
+			DBG("(E) cannot find address for device %s !\n", name);
 			return -ENODEV;
 		}
 		addr = *base;




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
