From: Gerhard Dirschl <gerhard.dirschl@gmx.de>
Subject: Audiophile 2496 DAC volume control and routing
Date: Sat, 23 Nov 2002 12:43:58 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021123114358.GA19317@euh11a303.stud.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

 Hi!

DAC volume control for Audiophile2496 has been broken with the changes for
Delta410 support. This one reenables it.

--- CVS/alsa/alsa-kernel/pci/ice1712/ak4524.c	2002-11-15 21:25:24.000000000 +0100
+++ alsa/alsa-kernel/pci/ice1712/ak4524.c	2002-11-22 18:09:22.000000000 +0100
@@ -81,7 +81,7 @@
 		udelay(1);
 	}
 
-	if (ak->type == SND_AK4524) {
+	if ((ak->type == SND_AK4524) || (ak->type == SND_AK4528)) {
 		if ((addr != 0x04 && addr != 0x05) || (data & 0x80) == 0)
 			ak->images[chip][addr] = data;
 		else

And now to the routing behaviour on my Audiophile2496.
Try this one:
[H/W Out 1] <- [Digital Mix L]
[H/W Out 2] <- [S/PDIF In ...] or [H/W In ..,]

And what you really get ist this:
[H/W Out 1] <- [Digital Mix L]
[H/W Out 2] <- [PCM Out 2]

Only if you put both "H/W Outs" on "S/PDIF In L/R" you get the S/PDIF input.
I am not familiar with the envy24 hardware but I don't think this is 
the right behaviour.

  ciao
    gerhard


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
