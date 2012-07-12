From: Marek Belisko <marek.belisko@open-nandra.com>
Subject: [PATCH 1/2] sound:soc:soc-dmap: Fix compilation warning.
Date: Thu, 12 Jul 2012 23:00:16 +0200
Message-ID: <1342126816-22308-1-git-send-email-marek.belisko@open-nandra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lrg@ti.com
Cc: broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Marek Belisko <marek.belisko@open-nandra.com>
List-Id: alsa-devel@alsa-project.org

=46ix following:
sound/soc/soc-dapm.c: In function =E2=80=98dapm_clock_event=E2=80=99:
sound/soc/soc-dapm.c:1021:1: warning: control reaches end of non-void f=
unction [-Wreturn-type]

Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
---
 sound/soc/soc-dapm.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f829d6f..eded657 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1018,6 +1018,7 @@ int dapm_clock_event(struct snd_soc_dapm_widget *=
w,
 		return 0;
 	}
 #endif
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dapm_clock_event);
=20
--=20
1.7.9.5
