From: jinyoungp@nvidia.com
Subject: [PATCH 0/3] ASoC: codecs: max98088: bug fixes and
	changes
Date: Thu, 12 May 2011 14:55:08 +0900
Message-ID: <1305179711-18022-1-git-send-email-jinyoungp@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id CB1292446E
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 07:55:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Peter.Hsiang@maxim-ic.com, alsa-devel@alsa-project.org, lrg@slimloigic.co.uk, Jin Park <jinyoungp@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Jin Park <jinyoungp@nvidia.com>

Recently, I working on max98088 and changed something in max98088 asoc driver.
The MAX98088 driver had some bug and needed modifies.
The changes was confirmed by Peter Hsiang who author of max98088 driver and
maxim engineer.
Please review my changes.

Thanks,
Jin Park.

Jin Park (3):
  ASoC: codecs: max98088: Fixed invalid register definitions in mixer
    controls
  ASoC: codecs: max98088: Moved the EX Limiter Mode from dapm widget to
    control
  ASoC: codecs: max98088: Added digital mute function in DAI1 and DAI2

 sound/soc/codecs/max98088.c |   62 +++++++++++++++++++++++++++++++------------
 sound/soc/codecs/max98088.h |   13 +++++++++
 2 files changed, 58 insertions(+), 17 deletions(-)


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
