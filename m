From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2 0/3] Calculate BCLK using TDM slots and
	remove channels rule
Date: Thu, 23 Apr 2015 16:16:03 +0300
Message-ID: <cover.1429794271.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id E993D261A84
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 15:16:19 +0200 (CEST)
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
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

The first and the last patch are excatly the same as in the first
series, but in the middle thee is a new patch to constraint out
unsupported channel counts in multiple serializers case.

- The first patch is a bug fix and also fixes Dan Carpenter's concern
  about stack usage in davinci_mcasp_hw_rule_channels()

- The second is also a bug fix, even thou the bug has existed in the
  dirver for a very long time. It is just that nobody has used
  multiple serializers before.

- The last patch is a simple optimization

All the patches have been tested are internally reviewed.

Jyri Sarha (3):
  ASoC: davinci-mcasp: Calculate BCLK using TDM slots and remove
    channels rule
  ASoC: davinci-mcasp: Channel count constraints for multi-serializer
    case
  ASoC: davinci-macsp: Optimize implicit BLCK sample-rate rule

 sound/soc/davinci/davinci-mcasp.c | 167 ++++++++++++++++++++------------------
 1 file changed, 90 insertions(+), 77 deletions(-)

-- 
1.9.1
