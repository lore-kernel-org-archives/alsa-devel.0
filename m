From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] AWACS driver, missing macro
Date: Tue, 24 Aug 2004 14:45:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040824144547.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


(Sorry if you already received this message, but all mail I
send to alsa-devel from my ISP's smtp server bounces. I'm
sending this through the server at work)



In the pmac AWACS driver of ALSA-1.0.6a there are two references to
num_controls():

[Giu@Jay ppc]$ grep num_controls *
awacs.c:                err = build_mixers(chip, num_controls(snd_pmac_screamer_mixers2),
awacs.c:                err = build_mixers(chip, num_controls(snd_pmac_awacs_mixers2),

But it is not defined anywhere. The following patch restores that macro that
I took from ALSA 1.0.5a. It looks fine here, too.  Tested ok (dual G4-MDD
with Snapper audio).



--- alsa-kernel/ppc/awacs.c_orig      Mon Aug  2 12:06:38 2004
+++ alsa-kernel/ppc/awacs.c     Tue Aug 17 15:46:24 2004
@@ -45,6 +45,8 @@
 
 #endif /* PMAC_AMP_AVAIL */
 
+#define num_controls(ary) (sizeof(ary) / sizeof(snd_kcontrol_new_t))
+
 
 static void snd_pmac_screamer_wait(pmac_t *chip)
 {




--
Giuliano.


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
