From: Qiao Zhou <zhouqiao@marvell.com>
Subject: [PATCH v2] ASoC: soc-pcm: fix dpcm_path_get error
	handling
Date: Wed, 10 Sep 2014 17:54:06 +0800
Message-ID: <1410342847-19295-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E6B226109E
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 11:54:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
Cc: Qiao Zhou <zhouqiao@marvell.com>
List-Id: alsa-devel@alsa-project.org

per Mark's suggestion, add braces to the else if branch

Qiao Zhou (1):
  ASoC: soc-pcm: fix dpcm_path_get error handling

 sound/soc/soc-compress.c |    6 +++++-
 sound/soc/soc-pcm.c      |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)
