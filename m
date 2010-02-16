From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2] ASoC: tlv320dac33: small fixes
Date: Tue, 16 Feb 2010 13:23:14 +0200
Message-ID: <1266319396-25066-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AA6B243F8
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 12:23:27 +0100 (CET)
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

Two small fixes for the tlv320dac33 codec driver:
Clearing the FIFFLUSH flag before playback start
 The register cache has the bit set after the playback is stopped, so clear it
 before the playback.
OSCSET calculation in case of 44.1KHz sampling rate was off by 1 (0x1588
 instead of 0x1589, which is the value should be used according to TI).

---
Peter Ujfalusi (2):
  ASoC: tlv320dac33: Clearing FIFOFLUSH flag before playback
  ASoC: tlv320dac33: Correct the OSCSET calculation

 sound/soc/codecs/tlv320dac33.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)
