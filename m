From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] ac97_patch: compilation warning fix
Date: Sun, 28 Oct 2007 17:20:44 +0100
Message-ID: <20071028172044.86499c13.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.poczta.interia.pl (smtp35.poczta.interia.pl [80.48.65.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E0922491E
	for <alsa-devel@alsa-project.org>; Sun, 28 Oct 2007 16:10:36 +0100 (CET)
Received: from poczta.interia.pl (mi03.poczta.interia.pl [10.217.12.3])
	by smtp4.poczta.interia.pl (INTERIA.PL) with ESMTP id 6C09042EABC
	for <alsa-devel@alsa-project.org>; Sun, 28 Oct 2007 16:10:35 +0100 (CET)
Received: from krzysio.net (host-87-99-61-239.lanet.net.pl [87.99.61.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 561CD45231
	for <alsa-devel@alsa-project.org>; Sun, 28 Oct 2007 16:10:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch kills these two compilation warnings if
power management is disabled:

sound/pci/ac97/ac97_patch.h:86: warning: 'snd_ac97_restore_status'
declared 'static' but never defined
sound/pci/ac97/ac97_patch.h:87: warning: 'snd_ac97_restore_iec958'
declared 'static' but never defined
 
Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

The patch was done against kernel 2.6.24-rc1-git4.

diff -urp linux-ref/sound/pci/ac97/ac97_patch.h linux-new/sound/pci/ac97/ac97_patch.h
--- linux-ref/sound/pci/ac97/ac97_patch.h	2007-10-28 11:11:20.000000000 +0100
+++ linux-new/sound/pci/ac97/ac97_patch.h	2007-10-28 12:46:34.000000000 +0100
@@ -83,8 +83,10 @@ static int snd_ac97_swap_ctl(struct snd_
 			     const char *s2, const char *suffix);
 static void snd_ac97_rename_vol_ctl(struct snd_ac97 *ac97, const char *src,
 				    const char *dst);
+#ifdef CONFIG_PM
 static void snd_ac97_restore_status(struct snd_ac97 *ac97);
 static void snd_ac97_restore_iec958(struct snd_ac97 *ac97);
+#endif
 static int snd_ac97_info_enum_double(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_info *uinfo);
 static int snd_ac97_get_enum_double(struct snd_kcontrol *kcontrol,
