From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 6/6] sound: lx_core: Translate comments from french to english
Date: Thu, 17 Apr 2014 11:51:21 +0200
Message-ID: <1397728281-26050-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1397728281-26050-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397728281-26050-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, iwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

=46or some reason, some of the comments were actually in poorly encoded=
 french.
Translate them in english like they should have been in the first place=
=2E

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 sound/pci/lx6464es/lx_core.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.=
c
index 7c070864dc62..e8f38e5df10a 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -1024,17 +1024,17 @@ static int lx_interrupt_handle_async_events(str=
uct lx6464es *chip, u32 irqsrc,
 	int err;
 	u32 stat[9];		/* answer from CMD_04_GET_EVENT */
=20
-	/* On peut optimiser pour ne pas lire les evenements vides
-	 * les mots de r=C3=83=C2=83=C3=82=C2=A9ponse sont dans l'ordre suiva=
nt :
-	 * Stat[0]	mot de status g=C3=83=C2=83=C3=82=C2=A9n=C3=83=C2=83=C3=82=
=C2=A9ral
-	 * Stat[1]	fin de buffer OUT pF
-	 * Stat[2]	fin de buffer OUT pf
-	 * Stat[3]	fin de buffer IN pF
-	 * Stat[4]	fin de buffer IN pf
-	 * Stat[5]	underrun poid fort
-	 * Stat[6]	underrun poid faible
-	 * Stat[7]	overrun poid fort
-	 * Stat[8]	overrun poid faible
+	/* We can optimize this to not read dumb events.
+	 * Answer words are in the following order:
+	 * Stat[0]	general status
+	 * Stat[1]	end of buffer OUT pF
+	 * Stat[2]	end of buffer OUT pf
+	 * Stat[3]	end of buffer IN pF
+	 * Stat[4]	end of buffer IN pf
+	 * Stat[5]	MSB underrun
+	 * Stat[6]	LSB underrun
+	 * Stat[7]	MSB overrun
+	 * Stat[8]	LSB overrun
 	 * */
=20
 	u64 orun_mask;
--=20
1.9.1
