From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH v4 0/2] ASoc Remove deprecated create_singlethread_workqueue
Date: Sun, 4 Sep 2016 21:26:12 +0530
Message-ID: <cover.1473004491.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch set removes deprecated create_singlethread_workqueue
instances in sound/soc/.

Bhaktipriya Shridhar (2):
  ASoC: tlv320dac33: Remove deprecated create_singlethread_workqueue
  ASoC: Intel: Remove deprecated create_singlethread_workqueue

 sound/soc/codecs/tlv320dac33.c | 17 ++++-------------
 sound/soc/intel/atom/sst/sst.c | 15 +++++----------
 2 files changed, 9 insertions(+), 23 deletions(-)

--
2.1.4
