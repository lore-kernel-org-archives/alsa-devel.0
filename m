From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2] ASoC: twl4030/tlv320dac33: convert to use
	usleep_range
Date: Fri, 22 Oct 2010 15:11:19 +0300
Message-ID: <1287749481-12203-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 90E382442F
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 14:11:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello,

remove the long busy loop delays from the drivers, and replace it with
more civilized usleep_range or in case of twl4030 msleep (when the
needed delay is really long)

---
Peter Ujfalusi (2):
  ASoC: tlv320dac33: Use usleep_range for delays
  ASoC: TWL4030: Use usleep_range when appropriate

 sound/soc/codecs/tlv320dac33.c |   10 ++++++----
 sound/soc/codecs/twl4030.c     |   33 ++++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 11 deletions(-)

-- 
1.7.3.1
