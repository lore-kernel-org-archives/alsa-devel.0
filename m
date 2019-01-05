From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] axfer: add an explanation about
	advantages/issues of Timer-based scheduling model
Date: Sat,  5 Jan 2019 17:42:10 +0900
Message-ID: <20190105084210.29616-4-o-takashi@sakamocchi.jp>
References: <20190105084210.29616-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by alsa0.perex.cz (Postfix) with ESMTP id E767B2678D4
 for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2019 09:42:24 +0100 (CET)
Received: by mail-pf1-f196.google.com with SMTP id w73so19390321pfk.10
 for <alsa-devel@alsa-project.org>; Sat, 05 Jan 2019 00:42:24 -0800 (PST)
In-Reply-To: <20190105084210.29616-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timer-based scheduling model has some merits against IRQ-based
scheduling model. However, as of Linux kernel v4.21, ALSA PCM interface
between kernel/userspace has a lack of some features.

This commit adds a subsection to describe it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/axfer-transfer.1 | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/axfer/axfer-transfer.1 b/axfer/axfer-transfer.1
index fbe0747..4ff6082 100644
--- a/axfer/axfer-transfer.1
+++ b/axfer/axfer-transfer.1
@@ -755,6 +755,28 @@ usage of rewinding/forwarding, applications can achieve low latency between
 transmission position and handling position even if they uses large size of
 PCM buffers.
 
+.SS Advantages and issues
+
+Ideally, timer\-based scheduling model has some advantages than IRQ\-based
+scheduling model. At first, no interrupt context runs for PCM substream. The
+PCM substream is handled in any process context only. No need to care of race
+conditions between IRQ and process contexts. This reduces some concerns for
+some developers of drivers and applications. Secondary, CPU time is not used
+for handlers on the interrupt context. The CPU time can be dedicated for the
+other tasks. This is good in a point of Time Sharing System. Thirdly, hardware
+is not configured to generate interrupts. This is good in a point of reduction
+of overall power consumption possibly.
+
+In either scheduling model, the hardware should allow drivers to read the
+number of audio data frame transferred between the dedicated memory and the
+device memory for audio serial bus. However, in timer\-based scheduling model,
+fine granularity and accuracy of the value is important. Actually hardware
+performs transmission between dedicated memory and device memory for a small
+batch of audio data frames or bytes. In a view of PCM applications, the
+granularity in current transmission is required to decide correct timeout for
+each I/O operation. As of Linux kernel v4.21, ALSA PCM interface between
+kernel/userspace has no feature to report it.
+
 .SH COMPATIBILITY TO APLAY
 
 The
-- 
2.19.1
