From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv3 00/20] OMAP ASoC changes in DMA utilization
Date: Thu, 13 Aug 2009 17:35:13 +0300
Message-ID: <1250174133-451-1-git-send-email-eduardo.valentin__1899.68255949697$1250174993$gmane$org@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

Hello again guys,

Here is version 3 of these changes. I've changed just 2
things:
- all mcbsp instances are in element mode by default
- moved all mcbsp related code to omap-mcbsp.c
(although a single callback is still needed)

Jarkko, I think we can add your patch for reading strings
for dma op mode later on.

BR,

Eduardo Valentin (11):
  OMAP: McBSP: Add IRQEN, IRQSTATUS, THRESHOLD2 and THRESHOLD1
    registers.
  OMAP: McBSP: Use appropriate value for startup delay
  OMAP: McBSP: Add transmit/receive threshold handler
  OMAP: McBSP: Create and export max_(r|t)x_thres property
  OMAP: McBSP: Rename thres sysfs symbols
  OMAP: McBSP: Change wakeup signals
  OMAP: McBSP: Configure NO IDLE mode for DMA mode different of
    threshold
  ASoC: OMAP: Make DMA 64 aligned
  ASoC: OMAP: Enable DMA burst mode
  ASoC: OMAP: Use McBSP threshold to playback and capture
  ASoC: OMAP: Use DMA operating mode of McBSP

Eero Nurkkala (7):
  OMAP: McBSP: Provide functions for ASoC frame syncronization
  OMAP: McBSP: Wakeups utilized
  OMAP: McBSP: Retain McBSP FCLK clockactivity
  OMAP: McBSP: Do not enable wakeups for no-idle mode
  OMAP: McBSP: Let element DMA mode hit retention also
  ASoC: Add runtime check for RFIG and XFIG
  ASoC: Always syncronize audio transfers on frames

Peter Ujfalusi (2):
  OMAP3: McBSP: Lower the maximum buffersize for McBSP1,3,4,5
  OMAP: McBSP: Add link DMA mode selection

 arch/arm/mach-omap2/mcbsp.c             |    5 +
 arch/arm/plat-omap/include/mach/mcbsp.h |   49 ++++
 arch/arm/plat-omap/mcbsp.c              |  377 ++++++++++++++++++++++++++++++-
 sound/soc/omap/omap-mcbsp.c             |   77 ++++++-
 sound/soc/omap/omap-pcm.c               |   14 +-
 sound/soc/omap/omap-pcm.h               |    2 +
 6 files changed, 511 insertions(+), 13 deletions(-)

