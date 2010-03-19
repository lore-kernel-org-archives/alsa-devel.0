From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2] ASoC: tlv320dac33: DSP mode and clocking
	updates
Date: Fri, 19 Mar 2010 11:10:18 +0200
Message-ID: <1268989820-18262-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id C80501037EE
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 10:10:32 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hello,

tlv320dac33 can not support DSP_B mode since the data delay can not be set to be
actually 0. Only DSP_A mode can be supported, so fix the DSP_A mode, and remove
the DSP_B.

The original internal clock distribution config has been found to be not
optimal, so fix that as well.

Peter

---
Peter Ujfalusi (2):
  ASoC: tlv320dac33: Fix DSP modes
  ASoC: tlv320dac33: Internal clocking changes

 sound/soc/codecs/tlv320dac33.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)
