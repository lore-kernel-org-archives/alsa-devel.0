From: RongJun Ying <rjying@gmail.com>
Subject: [PATCH 0/2] ASoC: sirf: Add sirf audio hub driver and
	use it.
Date: Thu, 13 Mar 2014 18:38:29 +0800
Message-ID: <1394707111-9539-1-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A1D526516B
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 11:39:31 +0100 (CET)
Received: by mail-pd0-f172.google.com with SMTP id p10so902008pdj.17
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 03:39:30 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, rjying@gmail.com
Cc: Takashi Iwai <tiwai@suse.de>, Rongjun Ying <rongjun.ying@csr.com>, alsa-devel@alsa-project.org, workgroup.linux@csr.com
List-Id: alsa-devel@alsa-project.org

From: Rongjun Ying <rongjun.ying@csr.com>

This patchset adds including:
1. SiRF audio hub driver
2. The internal codec and port get regmap form audio hub driver
3. Add SiRF audio hub binding document

Rongjun Ying (2):
  ASoC: sirf: Add sirf audio hub driver for sharing same register
    address space
  Documentation: Describe the SiRF audio hub Device Tree bindings

 .../devicetree/bindings/sound/sirf-audio-hub.txt   |   52 +++++++++++++++
 sound/soc/codecs/sirf-audio-codec.c                |   32 ++--------
 sound/soc/sirf/Kconfig                             |    5 ++
 sound/soc/sirf/Makefile                            |    2 +
 sound/soc/sirf/sirf-audio-hub.c                    |   66 ++++++++++++++++++++
 sound/soc/sirf/sirf-audio-port.c                   |   26 +--------
 6 files changed, 131 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-audio-hub.txt
 create mode 100644 sound/soc/sirf/sirf-audio-hub.c

-- 
1.7.5.4
