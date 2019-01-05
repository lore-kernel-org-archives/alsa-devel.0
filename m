From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/3] axfer: add an explanation about
	Timer-based scheduling model
Date: Sat,  5 Jan 2019 17:42:09 +0900
Message-ID: <20190105084210.29616-3-o-takashi@sakamocchi.jp>
References: <20190105084210.29616-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id D20CF267C62
 for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2019 09:42:22 +0100 (CET)
Received: by mail-pl1-f194.google.com with SMTP id e11so18492317plt.11
 for <alsa-devel@alsa-project.org>; Sat, 05 Jan 2019 00:42:22 -0800 (PST)
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

This commit fulfills a subsection titled as 'Timer-based scheduling model'.

This scheduling model is introduced in a recent decade. In this model,
applications should take care of its timing to operate sampled data
according to any timer. This is an optional behaviour of runtime of
PCM substream.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/axfer-transfer.1 | 45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/axfer/axfer-transfer.1 b/axfer/axfer-transfer.1
index a84ab3a..fbe0747 100644
--- a/axfer/axfer-transfer.1
+++ b/axfer/axfer-transfer.1
@@ -710,6 +710,51 @@ option with
 .I irq
 value.
 
+.SS Timer\-based scheduling model
+
+The
+.I no\-period\-wakeup
+mode is an optional mode of runtime of PCM substream. The mode assumes a
+specific feature of hardware and assist of in\-kernel driver and PCM
+applications. In this mode, in\-kernel drivers don't operate hardware to
+generate periodical notification for transmission of audio data frame.
+The hardware should automatically continue transmission of audio data frame
+without periodical operation of the drivers; e.g. according to auto\-triggered
+DMA transmission, a chain of registered descriptors.
+
+In this mode, nothing wakes up blocked processes, therefore PCM applications
+should be programmed without any blocking operation. For this reason, this mode
+is enabled when the PCM applications explicitly configure hardware parameter to
+runtime of PCM substream, to prevent disorder of existing applications.
+Additionally, nothing maintains timing for transmission of audio data frame,
+therefore the PCM applications should voluntarily handle any timer to queue
+audio data frame in buffer of the PCM substream for lapse of time. Furthermore,
+instead of driver, the PCM application should call a helper function of ALSA
+PCM core to update a position to head of hardware transmission and to check
+XRUN.
+
+In
+.I axfer
+, this is called
+.I timer\-based
+scheduling model and available as long as hardware/driver assists
+.I no\-period\-wakeup
+runtime. Users should explicitly set this mode by usage of
+.I \-\-sched\-model
+option with
+.I timer
+value.
+
+In the scheduling model, PCM applications need to care of available space on
+PCM buffer by lapse of time, typically by yielding CPU and wait for
+rescheduling. For the yielding, timeout is calculated for preferable amount of
+PCM frames to process. This is convenient to a kind of applications, like sound
+servers. when an I/O thread of the server wait for the timeout, the other
+threads can process audio data frames for server clients. Furthermore, with
+usage of rewinding/forwarding, applications can achieve low latency between
+transmission position and handling position even if they uses large size of
+PCM buffers.
+
 .SH COMPATIBILITY TO APLAY
 
 The
-- 
2.19.1
