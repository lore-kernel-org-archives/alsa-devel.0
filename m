From: Dirk.Kalis@t-online.de
Subject: RE: ice1712 Card ID problem next
Date: Thu,  9 Sep 2004 19:41:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1C5Sus-1Z6jpI0@cmpmail03.bbul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
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

Hello Ross,

not needed patch for envy24control must be corrected as follows.

regards
Dirk
**********************************************************************
--- envy24control.h.ori Thu Sep  9 10:02:50 2004
+++ envy24control.h     Thu Sep  9 09:50:42 2004
@@ -31,6 +31,7 @@
 #define ICE1712_SUBDEVICE_DELTADIO2496 0x121431d6
 #define ICE1712_SUBDEVICE_DELTA66      0x121432d6
 #define ICE1712_SUBDEVICE_DELTA44      0x121433d6
+#define ICE1712_SUBDEVICE_DELTA44_2    0x121433a0
 #define ICE1712_SUBDEVICE_AUDIOPHILE    0x121434d6
 #define ICE1712_SUBDEVICE_DELTA410      0x121438d6
 #define ICE1712_SUBDEVICE_DELTA1010LT   0x12143bd6
********************************************************************




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
