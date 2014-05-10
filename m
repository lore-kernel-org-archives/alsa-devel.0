From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: [REGRESSION] alsa PM regression in 3.15*, hda intel,
	realtek codec
Date: Sat, 10 May 2014 11:17:45 +0200
Message-ID: <536DEEB9.8000908@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout11.t-online.de (mailout11.t-online.de [194.25.134.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D525261ADB
 for <alsa-devel@alsa-project.org>; Sat, 10 May 2014 11:17:47 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

S3 suspend / resume cycle works on kernels up to 3.14.x as expected.
With kernels 3.15.0-rc2 it's necessary to reload the alsa modules as sound stays silent otherwise.

Hardware: AOpen i915GMm-hfs mobo, hda intel sound with realtek codec.

00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 04)
         Subsystem: AOPEN Inc. Device 0560
         Flags: bus master, fast devsel, latency 0, IRQ 46
         Memory at d5440000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [50] Power Management version 2
         Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
         Capabilities: [100] Virtual Channel
         Capabilities: [130] Root Complex Link
         Kernel driver in use: snd_hda_intel
         Kernel modules: snd_hda_intel

Is this regression known or should I bisect?

cu,
  Knut
