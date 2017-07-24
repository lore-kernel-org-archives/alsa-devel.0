From: Kevin Cheng <kevin.cheng@intel.com>
Subject: [PATCH 0/2] ASoC: Intel: Add Kabylake machine driver
	for RT5663
Date: Mon, 24 Jul 2017 11:23:37 +0800
Message-ID: <20170724032339.4304-1-kevin.cheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 09C63266B7E
 for <alsa-devel@alsa-project.org>; Mon, 24 Jul 2017 05:22:59 +0200 (CEST)
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
Cc: kevin.cheng@intel.com
List-Id: alsa-devel@alsa-project.org

Add kabylake machine driver & corresponding driver entry in machine table for
rt5663 codec.

For this particular machine,
 the RT5663 is a headset codec connected on ssp1.
 there is no dmic and speaker connected.

Modify the machine driver to kbl_rt5663_max98927 to reuse the 
common codes.

Kevin Cheng (2):
  ASoC: Intel: Add Kabylake machine driver for RT5663
  ASoC: Intel: Add Kabylake RT5663 machine driver entry

 sound/soc/intel/boards/kbl_rt5663_max98927.c | 246 +++++++++++++++++++++++----
 sound/soc/intel/skylake/skl.c                |   5 +
 2 files changed, 214 insertions(+), 37 deletions(-)

-- 
1.9.1
