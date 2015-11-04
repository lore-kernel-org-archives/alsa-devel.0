From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH V3 09/11] ASoC: img: Add documentation for
	SPDIF in controls
Date: Wed, 4 Nov 2015 14:40:55 +0000
Message-ID: <1446648057-373-10-git-send-email-Damien.Horsley@imgtec.com>
References: <1446648057-373-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 86D6E265745
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:41:58 +0100 (CET)
In-Reply-To: <1446648057-373-1-git-send-email-Damien.Horsley@imgtec.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, "Damien.Horsley" <Damien.Horsley@imgtec.com>, James Hartley <James.Hartley@imgtec.com>
List-Id: alsa-devel@alsa-project.org

From: "Damien.Horsley" <Damien.Horsley@imgtec.com>

Add documentation for the controls present in the SPDIF input
controller driver

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
---
 Documentation/sound/alsa/img,spdif-in.txt | 49 +++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/sound/alsa/img,spdif-in.txt

diff --git a/Documentation/sound/alsa/img,spdif-in.txt b/Documentation/sound/alsa/img,spdif-in.txt
new file mode 100644
index 0000000..8b75057
--- /dev/null
+++ b/Documentation/sound/alsa/img,spdif-in.txt
@@ -0,0 +1,49 @@
+The Imagination Technologies SPDIF Input controller contains the following
+controls:
+
+name='IEC958 Capture Mask',index=0
+
+This control returns a mask that shows which of the IEC958 status bits
+can be read using the 'IEC958 Capture Default' control.
+
+name='IEC958 Capture Default',index=0
+
+This control returns the status bits contained within the SPDIF stream that
+is being received. The 'IEC958 Capture Mask' shows which bits can be read
+from this control.
+
+name='SPDIF In Multi Frequency Acquire',index=0
+name='SPDIF In Multi Frequency Acquire',index=1
+name='SPDIF In Multi Frequency Acquire',index=2
+name='SPDIF In Multi Frequency Acquire',index=3
+
+This control is used to attempt acquisition of up to four different sample
+rates. The active rate can be obtained by reading the 'SPDIF In Lock Frequency'
+control.
+
+When the value of this control is set to {0,0,0,0}, the rate given to hw_params
+will determine the single rate the block will capture. Else, the rate given to
+hw_params will be ignored, and the block will attempt capture for each of the
+four sample rates set here.
+
+If less than four rates are required, the same rate can be specified more than
+once
+
+name='SPDIF In Lock Frequency',index=0
+
+This control returns the active capture rate, or 0 if a lock has not been
+acquired
+
+name='SPDIF In Lock TRK',index=0
+
+This control is used to modify the locking/jitter rejection characteristics
+of the block. Larger values increase the locking range, but reduce jitter
+rejection.
+
+name='SPDIF In Lock Acquire Threshold',index=0
+
+This control is used to change the threshold at which a lock is acquired.
+
+name='SPDIF In Lock Release Threshold',index=0
+
+This control is used to change the threshold at which a lock is released.
-- 
2.1.4
