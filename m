From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH v1 2/6] ASoC: sgtl5000: add ADC mute control
Date: Tue, 21 May 2019 13:36:15 +0300
Message-ID: <20190521103619.4707-3-oleksandr.suvorov@toradex.com>
References: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
List-Id: alsa-devel@alsa-project.org

This control mute/unmute the ADC input of SGTL5000
using its CHIP_ANA_CTRL register.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 sound/soc/codecs/sgtl5000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git sound/soc/codecs/sgtl5000.c sound/soc/codecs/sgtl5000.c
index 5e49523ee0b6..bb58c997c691 100644
--- sound/soc/codecs/sgtl5000.c
+++ sound/soc/codecs/sgtl5000.c
@@ -556,6 +556,7 @@ static const struct snd_kcontrol_new sgtl5000_snd_controls[] = {
 			SGTL5000_CHIP_ANA_ADC_CTRL,
 			8, 1, 0, capture_6db_attenuate),
 	SOC_SINGLE("Capture ZC Switch", SGTL5000_CHIP_ANA_CTRL, 1, 1, 0),
+	SOC_SINGLE("Capture Switch", SGTL5000_CHIP_ANA_CTRL, 0, 1, 1),
 
 	SOC_DOUBLE_TLV("Headphone Playback Volume",
 			SGTL5000_CHIP_ANA_HP_CTRL,
-- 
2.20.1


-- 

Ciklum refers to one or more of Ciklum Group Holdings LTD. and its 
subsidiaries and affiliates each of which is a legally separate entity. 
Ciklum LLC is a limited liability company registered in Ukraine under 
EDRPOU code 31902643, with its registered address at 12 Amosova St., 03680, 
Kyiv, Ukraine.



The contents of this e-mail (including any attachments) 
are confidential and may be legally privileged. If you are not the intended 
recipient of this e-mail, please notify the sender immediately and then 
delete it (including any attachments) from all your systems. Any 
unauthorised use, reproduction, distribution, disclosure and/or 
modification of this message and/or its contents are strictly prohibited. 
We cannot guarantee that this e-mail is secure or error-free. Ciklum cannot 
be held liable for any loss or damage caused by software viruses or 
resulting from any use of or reliance on this email by anyone, other than 
the intended addressee to the extent agreed in a contract for the matter to 
which this email relates (if any). Messages sent to and from Ciklum may be 
monitored; by replying to this e-mail you give your consent to such 
monitoring.  Notice: we do not accept service by e-mail of court 
proceedings, other processes or formal notices of any kind without specific 
prior written agreement. This email does not constitute a binding offer or 
acceptance for Ciklum unless so set forth in a separate document.
