From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 0/7] Arizona FLL Bug Fixes
Date: Wed,  9 Jul 2014 17:41:42 +0100
Message-ID: <1404924109-1750-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 292EB265099
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 18:53:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

This patch series contains several small bug fixes and
improves the handling of the situation in which an already
running FLL is reconfigured. In the case of a running FLL
only some tranisitions are supported whereas previously all
transitions were allowed.

Thanks,
Charles

Charles Keepax (7):
  ASoC: arizona: Do not test ratio zero as it is not a valid setting
  ASoC: arizona: Correct checking of FLL ratio limitations
  ASoC: arizona: Correct relationship between VCO corner and Fref
  ASoC: arizona: Coding standards, remove unneeded brackets
  ASoC: arizona: Correct return value of arizona_is_enabled_fll
  ASoC: arizona: FLL freerun only required whilst disabling
  ASoC: arizona: Update handling for input change on an active FLL

 sound/soc/codecs/arizona.c |   63 ++++++++++++++++++++++++++++++--------------
 1 files changed, 43 insertions(+), 20 deletions(-)

-- 
1.7.2.5
