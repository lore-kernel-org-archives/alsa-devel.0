From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH v4 0/1] Fix driver reload issues
Date: Fri, 26 Jul 2019 11:09:28 +0200
Message-ID: <20190726090929.27946-1-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is last patch left from series fixing driver reload problems.

Rebased onto latest for-next in Marks tree.

Amadeusz Sławiński (1):
  ASoC: Intel: Skylake: Remove static table index when parsing topology

 sound/soc/intel/skylake/skl-topology.c | 34 +++++++++-----------------
 1 file changed, 12 insertions(+), 22 deletions(-)

-- 
2.17.1
