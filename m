From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/3] ASoC: twl4030/tpa6130a2: DB_RANGE mapping
	fixes
Date: Fri, 16 Jul 2010 13:17:08 +0300
Message-ID: <1279275431-26922-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id A78B02445D
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 12:17:26 +0200 (CEST)
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

There were 'holes' in the DB_RANGE and SCALE_ITEM mapping, which results
failure, when user space requests dB value in these holes, since alsa-lib
will fail to find a range, and can not round the requested dB to raw value.

Fixing the drivers I'm maintaining to correctly fill the tlv struct.

Peter

---
Peter Ujfalusi (3):
  ASoC: TWL4030: Fix DB_RANGE tlv mapping for digital loopback
  ASoC: tpa6130a2: Fix DB_RANGE mapping for tpa6130a2 chip
  ASoC: tpa6130a2: Fix DB_RANGE mapping for tpa6140a2 chip

 sound/soc/codecs/tpa6130a2.c |   22 ++++++++++++++--------
 sound/soc/codecs/twl4030.c   |    4 ++--
 2 files changed, 16 insertions(+), 10 deletions(-)
