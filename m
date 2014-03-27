From: RongJun Ying <rjying@gmail.com>
Subject: [PATCH v6 0/2] ASoC: Add SiRF I2S controller and hdmi
	card drivers
Date: Thu, 27 Mar 2014 13:27:03 +0800
Message-ID: <1395898025-5437-1-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 352502651CE
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 06:28:05 +0100 (CET)
Received: by mail-pd0-f175.google.com with SMTP id x10so2842662pdj.6
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 22:28:03 -0700 (PDT)
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

This patchset adds CSR SiRFSoC sound drivers including:
4. The SiRF I2S controller driver
5. The SiRF hdmi card driver

Rongjun Ying (2):
  ASoC: sirf: Add SiRF I2S driver
  ASoC: sirf: Add hdmi support

 .../devicetree/bindings/sound/sirf-i2s.txt         |   27 ++
 sound/soc/sirf/Kconfig                             |   11 +
 sound/soc/sirf/Makefile                            |    2 +
 sound/soc/sirf/sirf-i2s.c                          |  445 ++++++++++++++++++++
 sound/soc/sirf/sirf-i2s.h                          |   93 ++++
 5 files changed, 578 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-i2s.txt
 create mode 100644 sound/soc/sirf/sirf-i2s.c
 create mode 100644 sound/soc/sirf/sirf-i2s.h

-- 
1.7.5.4
