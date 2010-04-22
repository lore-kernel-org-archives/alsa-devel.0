From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/5] ASoC: tlv320dac33: FIFO caused delay
	reporting and fixes
Date: Thu, 22 Apr 2010 16:57:45 +0300
Message-ID: <1271944670-14588-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id AEEF21038C8
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 15:58:07 +0200 (CEST)
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

The main feature of this series is the FIFO caused delay reporting on the DAC33
codec.
The main patch is quite big, but I don't think it can be divided further.

Short details of the actual implementation is in the commit message(s), and
I will not copy it here.

The values reported by the delay call has been verified by using one GPIO as a
signal, and printout from the kernel at the same time with the delay, than
based on the time scale on the scope several (>100) cases has been hand
calculated and the results were compared to the kernel reported values.
The difference were around (or less) the 10 samples, but during the bursts it
is much harder to count, but the reported value was reasonable accurate there
as well.

---
Peter Ujfalusi (5):
  ASoC: tlv320dac33: Fix for early interrupt in FIFO Mode1
  ASoC: tlv320dac33: Skip calculations in FIFO Bypass mode
  ASoC: tlv320dac33: Change magic numbers used in Mode7
  ASoC: tlv320dac33: Calculate the interface speed during bursts
  ASoC: tlv320dac33: FIFO caused delay reporting

 sound/soc/codecs/tlv320dac33.c |  249 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 237 insertions(+), 12 deletions(-)
