From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] OMAP2+: DMA: fix src/dst position reporting
Date: Mon, 31 Oct 2011 16:20:15 +0200
Message-ID: <1320070817-9638-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

If the user asks for the sDMA current position before the first
data has been transmitted (before the first DMA request has been
generated), the reported position is not valid:
src position: CSAC is uninitialized
dst position: CDAC is 0

The return values in both case considered invalid.
This sitation can be identified by checking if the CDAC register
is 0 (it is initialized to 0 in omap_dam_start call).
In this case return the programmed source/destination address.

The affected omap_get_dma_src_pos/omap_get_dma_dst_pos functions
are used by the audio stack mainly for checking the current position
of the audio stream.

Regards,
Peter
---
Peter Ujfalusi (2):
  OMAP2+: DMA: Workaround for invalid source position
  OMAP2+: DMA: Workaround for invalid destination position

 arch/arm/plat-omap/dma.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

-- 
1.7.7.1

