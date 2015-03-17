From: Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 0/2] ASoC: Intel: fixup patches for Braswell
	machine driver
Date: Tue, 17 Mar 2015 10:23:29 +0800
Message-ID: <1426559011-8499-1-git-send-email-yao.jin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B5F27261A03
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 03:17:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, yao.jin@linux.intel.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

These are Braswell machine driver fixup patches.

Jin Yao (2):
  1) ASoC: Intel: Add suspend_pre and resume_post for Braswell snd_soc_card
  2) ASoC: Intel: move the jack creation to Braswell machine driver

For 1), it requires following dependency patches to build:
     ASoC: rt5670: Add IRQ function
     ASoC: rt5670: export jack suspend/resume APIs

For 2), it requires following dependency patch to build:
     ASoC: Allow to register jacks at the card level

These dependency patches have been integrated in for-next branch but not in
intel branch.

Thanks
Jin Yao

 sound/soc/intel/cht_bsw_rt5672.c | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

-- 
1.9.1
