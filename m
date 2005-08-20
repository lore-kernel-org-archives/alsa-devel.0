From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] HP nx6110 quirks
Date: Sat, 20 Aug 2005 22:17:30 +0400
Message-ID: <20050820181730.GA12485@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

The HP nx6110 laptop needs to have Headphone Jack Sense enabled so
that the internal speakers will be turned off when headphones are
plugged in.

Also ac97_quirk=hp_only is needed to make a single Master volume in
the mixer instead of separate volumes for internal speakers and
headphones, which just confuses the user.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---

The patch is for the current alsa-kernel CVS.

 pci/ac97/ac97_patch.c |    1 +
 pci/intel8x0.c        |    6 ++++++
 2 files changed, 7 insertions(+)

--- alsa-kernel/pci/ac97/ac97_patch.c.alt-hp-nx6110	2005-08-18 23:09:55 +0400
+++ alsa-kernel/pci/ac97/ac97_patch.c	2005-08-20 22:08:46 +0400
@@ -1629,6 +1629,7 @@ static void check_ad1981_hp_jack_sense(a
 	u32 subid = ((u32)ac97->subsystem_vendor << 16) | ac97->subsystem_device;
 	switch (subid) {
 	case 0x103c0890: /* HP nc6000 */
+	case 0x103c099c: /* HP nx6110 */
 	case 0x103c006d: /* HP nx9105 */
 	case 0x17340088: /* FSC Scenic-W */
 		/* enable headphone jack sense */
--- alsa-kernel/pci/intel8x0.c.alt-hp-nx6110	2005-08-20 22:08:49 +0400
+++ alsa-kernel/pci/intel8x0.c	2005-08-20 22:14:23 +0400
@@ -1826,6 +1826,12 @@ static struct ac97_quirk ac97_quirks[] _
 	},
 	{
 		.subvendor = 0x103c,
+		.subdevice = 0x099c,
+		.name = "HP nx6110",	/* AD1981B */
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.subvendor = 0x103c,
 		.subdevice = 0x129d,
 		.name = "HP xw8000",
 		.type = AC97_TUNE_HP_ONLY


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
