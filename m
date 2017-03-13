From: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
Subject: [PATCH] ASoC: core: remove redundunt address operation
	for array type variable
Date: Mon, 13 Mar 2017 12:07:43 +0900
Message-ID: <20170313030743.25019-1-takashi.sakamoto@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f178.google.com (mail-pf0-f178.google.com
 [209.85.192.178])
 by alsa0.perex.cz (Postfix) with ESMTP id D544F2666E1
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 04:07:51 +0100 (CET)
Received: by mail-pf0-f178.google.com with SMTP id v190so63854598pfb.1
 for <alsa-devel@alsa-project.org>; Sun, 12 Mar 2017 20:07:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: ichiro.suzuki@miraclelinux.com, alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, yukie.kato@miraclelinux.com
List-Id: alsa-devel@alsa-project.org

The type of 'struct snd_ctl_elem_value.value.bytes.data' is 'unsigned
char[512]'. In C language specification, address operation (&) for this
type is just ignored, therefore:

struct snd_ctl_elem_value elem_value;
printf("%p\n", elem_value.value.bytes.data);
printf("%p\n", &elem_value.value.bytes.data);

These two evaluation have the same value, a pointer to the first element
of the array.

This kind of address operation is not good for readers, because it easily
brings confusions as an address operations to pointers. For example,

struct snd_kcontrol_new template;
printf("%p\n", template.name);
printf("%p\n", &template.name);

These two evaluation have the different value. The former is
'unsigned char *', while the latter is 'unsigned char **'.

This commit removes redundant address operation for array type variable
to avoid misreading in reader side.

Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Fixes: f831b055ecec ("ASoC: core: Add support for masking out parts of coefficient blocks")
Signed-off-by: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
---
 sound/soc/soc-ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 500f98c..76b199b 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -658,11 +658,11 @@ int snd_soc_bytes_get(struct snd_kcontrol *kcontrol,
 			ucontrol->value.bytes.data[0] &= ~params->mask;
 			break;
 		case 2:
-			((u16 *)(&ucontrol->value.bytes.data))[0]
+			((u16 *)ucontrol->value.bytes.data)[0]
 				&= cpu_to_be16(~params->mask);
 			break;
 		case 4:
-			((u32 *)(&ucontrol->value.bytes.data))[0]
+			((u32 *)ucontrol->value.bytes.data)[0]
 				&= cpu_to_be32(~params->mask);
 			break;
 		default:
-- 
2.9.3
