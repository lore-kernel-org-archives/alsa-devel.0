From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 0/2] ASoC: fsl_asrc: Fix two dereferenced variable before check
Date: Mon, 4 Aug 2014 12:19:47 +0800
Message-ID: <cover.1407125653.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

These two patches fixes two warning of dereferenced variable reported by
Dan Carpenter <dan.carpenter@oracle.com>

Nicolin Chen (2):
  ASoC: fsl_sarc_dma: Check pair before using it
  ASoC: fsl_asrc: Don't access members of config before checking it

 sound/soc/fsl/fsl_asrc.c     | 9 ++++++---
 sound/soc/fsl/fsl_asrc_dma.c | 9 +++++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
1.8.4
