From: Gerhard Dirschl <gerhard.dirschl@gmx.de>
Subject: [PATCH] missing spin_unlock in ice1712
Date: Fri, 22 Nov 2002 15:12:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021122141245.GA4286@euh11a303.stud.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 Hi!

The ice1712 driver (0.9.0rc6 and CVS) crashes on my Dual-SMP machine
(Kernel 2.4.20-rc2) due to a missing spin_unlock_irq in 
snd_ice1712_pro_internal_clock_put.

This patch fixed it for me (but I don't know if this is the right way).

  ciao

-- 
Gerhard Dirschl
Karlsruhe
Germany

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ice1712.c.diff"

--- alsa-driver-0.9.0rc6/alsa-kernel/pci/ice1712/ice1712.c	2002-11-14 11:52:31.000000000 +0100
+++ alsa/alsa-kernel/pci/ice1712/ice1712.c	2002-11-17 16:41:44.000000000 +0100
@@ -1787,13 +1787,18 @@
 	oval = inb(ICEMT(ice, RATE));
 	if (ucontrol->value.enumerated.item[0] == 13) {
 		outb(oval | ICE1712_SPDIF_MASTER, ICEMT(ice, RATE));
+		spin_unlock_irq(&ice->reg_lock);
 	} else {
 		PRO_RATE_DEFAULT = xrate[ucontrol->value.integer.value[0] % 13];
+		spin_unlock_irq(&ice->reg_lock);
 		snd_ice1712_set_pro_rate(ice, PRO_RATE_DEFAULT, 1);
 	}
+	spin_lock_irq(&ice->reg_lock);
 	change = inb(ICEMT(ice, RATE)) != oval;
-
+	
 	if ((oval & ICE1712_SPDIF_MASTER) != (inb(ICEMT(ice, RATE)) & ICE1712_SPDIF_MASTER)) {
+		spin_unlock_irq(&ice->reg_lock);
+		
 		/* change CS8427 clock source too */
 		if (ice->cs8427) {
 			snd_ice1712_cs8427_set_input_clock(ice, is_spdif_master(ice));
@@ -1801,6 +1806,8 @@
 		/* notify ak4524 chip as well */
 		if (is_spdif_master(ice) && ice->ak4524.ops.set_rate_val)
 			ice->ak4524.ops.set_rate_val(ice, 0);
+	} else {
+		spin_unlock_irq(&ice->reg_lock);
 	}
 
 	return change;

--TB36FDmn/VVEgNH/--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
