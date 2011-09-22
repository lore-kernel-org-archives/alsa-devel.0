From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: [GIT PULL] OMAP McPDM updates for 3.2
Date: Thu, 22 Sep 2011 09:42:27 +0300
Message-ID: <1630065.ScFgvmAAyT@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D2C910381B
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 08:43:00 +0200 (CEST)
Received: by mail-bw0-f43.google.com with SMTP id s6so2972633bka.30
	for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2011 23:42:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Hello Mark,

as we discussed you can pull the OMAP McPDM updates.

As for reference:
ASoC: OMAP4: McPDM: Fix legacy support [4 patch]
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-August/042401.html

ASoC: omap-mcpdm: Replace legacy driver:
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-August/043317.html

All received acks

Regards,
P=E9ter

The following changes since commit 0722d055ac2236da4e319d22a99c9f7e82dbdd5d:

  ASoC: tpa6130a2: Remove model_id from platform data (2011-09-21 16:07:45 =
+0100)

are available in the git repository at:
  git://gitorious.org/omap-audio/linux-audio.git peter/topic/for-mark/mcpdm=
_for-3.2

Misael Lopez Cruz (1):
      ASoC: omap-mcpdm: Replace legacy driver

Peter Ujfalusi (4):
      OMAP: McPDM: Convert McPDM device to omap_device
      OMAP4: hwmod: enable mcpdm hwmod device.
      ASoC: omap-mcpdm: Fix threshold and dma configuration
      ASoC: OMAP4: McPDM: Convert to hwmod/omap_device

 arch/arm/mach-omap2/devices.c              |   33 ++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 arch/arm/plat-omap/devices.c               |   36 ---
 sound/soc/omap/Makefile                    |    2 +-
 sound/soc/omap/mcpdm.c                     |  470 ------------------------=
----
 sound/soc/omap/mcpdm.h                     |  153 ---------
 sound/soc/omap/omap-mcpdm.c                |  442 ++++++++++++++++++++----=
--
 sound/soc/omap/omap-mcpdm.h                |   95 ++++++
 sound/soc/omap/sdp4430.c                   |    4 +-
 9 files changed, 472 insertions(+), 765 deletions(-)
 delete mode 100644 sound/soc/omap/mcpdm.c
 delete mode 100644 sound/soc/omap/mcpdm.h
 create mode 100644 sound/soc/omap/omap-mcpdm.h
