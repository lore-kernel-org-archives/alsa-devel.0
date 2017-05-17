From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ALSA: cs46xx: constify snd_kcontrol_new
	structures
Date: Wed, 17 May 2017 17:39:03 +0530
Message-ID: <1495022943-24898-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BA7A02664EB
 for <alsa-devel@alsa-project.org>; Wed, 17 May 2017 14:09:58 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id i63so1614272pgd.2
 for <alsa-devel@alsa-project.org>; Wed, 17 May 2017 05:09:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_kcontrol_new structures as const as they are only passed an
argument to the function snd_ctl_new1. This argument is of type const,
so snd_kcontrol_new structures having this property can be made const.
Done using Coccinelle:

@r disable optional_qualifier@
identifier x;
position p;
@@
static struct snd_kcontrol_new x@p={...};

@ok@
identifier r.x;
position p;
@@
snd_ctl_new1(&x@p,...)

@bad@
position p != {r.p,ok.p};
identifier r.x;
@@
x@p

@depends on !bad disable optional_qualifier@
identifier r.x;
@@
+const
struct snd_kcontrol_new x;

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/pci/cs46xx/cs46xx_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index e4cf318..00fa52e 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -2371,7 +2371,7 @@ static int snd_cs46xx_front_dup_put(struct snd_kcontrol *kcontrol,
 				    ucontrol->value.integer.value[0] ? 0 : 0x200);
 }
 
-static struct snd_kcontrol_new snd_cs46xx_front_dup_ctl = {
+static const struct snd_kcontrol_new snd_cs46xx_front_dup_ctl = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Duplicate Front",
 	.info = snd_mixer_boolean_info,
-- 
2.7.4
