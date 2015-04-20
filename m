From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 0/2] Calculate BCLK using TDM slots and remove
	channels rule
Date: Mon, 20 Apr 2015 16:58:17 +0300
Message-ID: <cover.1429537509.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id EE67E265867
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 15:58:31 +0200 (CEST)
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
Cc: peter.ujfalusi@ti.com, Jyri Sarha <jsarha@ti.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org, misael.lopez@ti.com, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

The first patch is a bugfix. I did not have the HW see the problem
myself, but reading from the code the problem is evident. This should
also fix Dan Carpenter's concern about stack usage in
davinci_mcasp_hw_rule_channels(), as the whole function is removed.

The second patch is just an optimization of the sample-rate rule. In
effect I put in use Takashi Iwai's suggestion for fixing the stack
usage issue in the channels rule.

Jyri Sarha (2):
  ASoC: davinci-mcasp: Calculate BCLK using TDM slots and remove
    channels rule
  ASoC: davinci-macsp: Optimize implicit BLCK sample-rate rule

 sound/soc/davinci/davinci-mcasp.c | 104 ++++++++++----------------------------
 1 file changed, 27 insertions(+), 77 deletions(-)

-- 
1.9.1
