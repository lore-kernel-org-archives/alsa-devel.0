From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 0/4] Intel HDMI audio fixes
Date: Wed, 11 Feb 2009 15:22:27 +0800
Message-ID: <20090211072227.760779741@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 9096C103883
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 08:56:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Shane W <shane-alsa@csy.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Here are four assorted fixes for Intel HDMI audio.
They have been tested in G35 SDVO HDMI and G45 integrated HDMI systems,
and shall be OK for 2.6.29.

[PATCH 1/4] hda - allow multi-channel HDMI audio playback when ELD is not present
[PATCH 2/4] hda - enable HDMI audio pin out at module loading time
[PATCH 3/4] hda - compute checksum in HDMI audio infoframe
[PATCH 4/4] hda - add id for Intel IbexPeak integrated HDMI codec

Shane: the first two patches should address the two bugs you reported, i.e.
- multi-channel HDMI audio playback problem
- first half-second audio samples missing
These two bugs was reproduced and fixed in the combination of
G35 SDVO HDMI + Yamaha RX-V1800 AV receiver. The first problem cannot be
verified in G45 system because we still cannot make G45 work with
Yamaha. The second problem is interesting in that it can be fixed by the
second patch in G35, but still remains in G45.

Thanks,
Fengguang
--
