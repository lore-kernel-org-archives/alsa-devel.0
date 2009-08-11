From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv2 00/20] OMAP ASoC changes in DMA utilization
Date: Tue, 11 Aug 2009 16:05:11 +0300
Message-ID: <1249995931-26015-1-git-send-email-eduardo.valentin__29992.5302308568$1249998003$gmane$org@nokia.com>
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

Hello guys,

Here is version 2 of this series. There were lots of little changes
and also one significant change.

Here is a changelog:
- I tried to avoid additional ifdefs in mcbsp code
- The WAKEUPEN_ALL macro was removed
- I added a REVISIT prefix for the additional delay on mcbsp start
- New added constants are now following mcbsp.h style
- While reading DMA operation mode of mcbsp, now it prints also some help
text to explain the meaning of each value (even though you still write numbers).

Besides, I re-wrote the code for ASoC part, now the threshold and dma
op mode usage are un-glued from mcbsp code. I tried to do not leave
omap-pcm.c dirty, but, there was still one needed callback for setting
the mcbsp threshold, as that needs to be done before DMA is started.

In this series I've left THRESHOLD mode as default for mcbsp 2 only.
But as I saw in previous comments, this is still an open issue :-)

Comments, as usual are welcome.

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
  ASoC: OMAP: Use McBSP threshold to playback and capture
  ASoC: OMAP: Use DMA operating mode of McBSP
  ASoC: OMAP: Make DMA 64 aligned
  ASoC: OMAP: Enable DMA burst mode

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
 arch/arm/plat-omap/mcbsp.c              |  375 ++++++++++++++++++++++++++++++-
 sound/soc/omap/omap-mcbsp.c             |   67 +++++-
 sound/soc/omap/omap-pcm.c               |   33 +++-
 sound/soc/omap/omap-pcm.h               |    2 +
 6 files changed, 517 insertions(+), 14 deletions(-)

