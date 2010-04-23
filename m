From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCHv2 0/5] *** SUBJECT HERE ***ASoC: tlv320dac33:
	FIFO caused delay reporting and fixes
Date: Fri, 23 Apr 2010 10:09:56 +0300
Message-ID: <1272006601-24946-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id A20A024399
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Apr 2010 09:10:41 +0200 (CEST)
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

Changelog:
- Calculated delay instead of msleep(2) in patch 1
- ns changed to us in patch 5 (in the macro for calculation)

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

 sound/soc/codecs/tlv320dac33.c |  250 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 238 insertions(+), 12 deletions(-)
