From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH V2 1/3] ASoC: Add SOC_DOUBLE_STS macro
Date: Tue, 8 Dec 2015 15:58:58 +0000
Message-ID: <1449590340-14682-2-git-send-email-Damien.Horsley@imgtec.com>
References: <1449590340-14682-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id D4DA9260435
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 17:00:12 +0100 (CET)
In-Reply-To: <1449590340-14682-1-git-send-email-Damien.Horsley@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, "Damien.Horsley" <Damien.Horsley@imgtec.com>, James Hartley <james.hartley@imgtec.com>
List-Id: alsa-devel@alsa-project.org

From: "Damien.Horsley" <Damien.Horsley@imgtec.com>

Add SOC_DOUBLE_STS macro for read-only volatile status controls

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
---
 include/sound/soc.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 03431e7..e8d834f 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -110,6 +110,14 @@
 	.put = snd_soc_put_volsw, \
 	.private_value = SOC_DOUBLE_VALUE(reg, shift_left, shift_right, \
 					  max, invert, 0) }
+#define SOC_DOUBLE_STS(xname, reg, shift_left, shift_right, max, invert) \
+{									\
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),		\
+	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,		\
+	.access = SNDRV_CTL_ELEM_ACCESS_READ |				\
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE,				\
+	.private_value = SOC_DOUBLE_VALUE(reg, shift_left, shift_right,	\
+					  max, invert, 0) }
 #define SOC_DOUBLE_R(xname, reg_left, reg_right, xshift, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.info = snd_soc_info_volsw, \
-- 
2.1.4
