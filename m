From: Arnaud Patard <rtp-mailing@wanadoo.fr>
Subject: Audigy card & digital out
Date: Sun, 19 Jan 2003 15:56:09 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301191540580.7738-100000@labevue.coinnetwork.dl>
Reply-To: Arnaud Patard <rtp-mailing@wanadoo.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Hi,

I own an audigy card (Class 0401: 1102:0004 (rev 03),Subsystem: 1102:0051)
and the DTT3500 speakers. I tried to use the digital out of the card but
it works only with the creative oss/free drivers. But not with alsa.
In the docs from creative oss drivers I found that :

IOCFG Register (fn0 - 0x18)
--------------

The upper 8 bits are inputs, lower 8 are outputs.

Inputs
------


The following are used to detect if something is plugged into the
card (use 'dbgemu -d f' to see this register (0x18)):

0x2000   - center-sub/digital-out Jack
0x4000   - Front Jack
0x8000   - Rear Jack
0x0100   - Audigy Drive's Headphone Jack


Output
------

0x0040   -   Disable front + rear + center/sub analog output
0x0004   -   Enable digital out

So there was a possible mistake in the alsa driver. I made that patch but
it didn't work :(

--- emu10k1.orig.h      2002-12-23 14:25:30.000000000 +0100
+++ emu10k1.h   2003-01-19 14:39:51.000000000 +0100
@@ -232,7 +232,7 @@
 #define A_IOCFG                        0x18            /* GPIO on Audigy
card (16bits)                 */
 #define A_GPINPUT_MASK         0xff00
 #define A_GPOUTPUT_MASK                0x00ff
-#define A_IOCFG_GPOUT0         0x0040          /* analog/digital? */
+#define A_IOCFG_GPOUT0         0x0044          /* analog/digital? */

 #define TIMER                  0x1a            /* Timer terminal count
register                */
                                                /* NOTE: After the rate is
changed, a maximum   */


Any idea to get this output working ?


P.S. : sorry for this long mail and my poor english



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
