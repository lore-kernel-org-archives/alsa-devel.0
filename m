From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 0/3] ASoC: Relocate the OMAP HDMI codec to sound
Date: Sat, 11 Feb 2012 18:23:14 -0600
Message-ID: <1329006197-28332-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id AA7C0103A60
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2012 01:23:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: x0055901@ti.com, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, s-guiriec@ti.com
List-Id: alsa-devel@alsa-project.org

Hello,

Currently, the ASoC HDMI codec is embedded in the DSS HDMI driver. In order
to give the OMAP HDMI code a more logical arrangement, the audio
part is moved to /sound. Deep color support has been removed until it
is supported by DSS so that no ugly register readings are done. The rest of
the functionality is still supported.

The relocation of the code is split into two parts: Part 1 is for DSS. It
removes the HDMI codec from DSS and exposes DSS functionality to ASoC. Part 2
is the actual relocation of the codec under /sound. The purpose of
this is split is to ease the integration of these patches first to DSS
and then to ASoC. The DSS part has been submitted and can be consulted here:

http://www.spinics.net/lists/linux-omap/msg64477.html

Please note that these patches will not apply without the aforementioned
DSS part. This work is also based on the patches previously sent for HDMI
audio MCLK support:

http://www.spinics.net/lists/linux-omap/msg64302.html

and was implemented on top of:

git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git v3.3-rc3

Thanks,

Ricardo

Axel Castaneda Gonzalez (1):
  OMAPDSS/ASoC: Relocate ASoC HDMI codec. Part 2

Ricardo Neri (2):
  ASoC: OMAP: HDMI: Update codec name
  ASoC: OMAP: Update Kconfig and Makefile files for HDMI audio codec

 sound/soc/codecs/Kconfig         |    4 +
 sound/soc/codecs/Makefile        |    5 +
 sound/soc/codecs/omap-hdmi.c     |  422 ++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/Kconfig           |    1 +
 sound/soc/omap/omap4-hdmi-card.c |    2 +-
 5 files changed, 433 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/codecs/omap-hdmi.c
