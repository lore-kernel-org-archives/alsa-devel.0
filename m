From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH - alsa-lib 0/3] Fixes for
	snd_tlv_convert_from_dB
Date: Mon, 19 Jul 2010 10:14:03 +0300
Message-ID: <1279523646-4987-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id A6D8710382B
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 09:14:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello,

One cosmetic fix, and two real fixes for alsa-lib's tlv handling.

There were two separate issue with the snd_tlv_convert_from_dB function:
1. When user asked for out of range dB value, and the control had
   SND_CTL_TLVT_DB_RANGE, the control's full range was not checked against the
   requested value, which resulted failure.
2. When there are 'holes' in the SND_CTL_TLVT_DB_RANGE array,
   snd_tlv_convert_from_dB will fail to find the apropriate raw value.

For issue #2, I have sent patches for the drivers I maintain, but Mark Brown
suggested to fix the issue in alsa-lib instead of converting the driver's
non-overlapping to overlapping mapping:
http://mailman.alsa-project.org/pipermail/alsa-devel/2010-July/029483.html

So the following series for alsa-lib, will fix the SND_CTL_TLVT_DB_RANGE
handling.

---
Peter Ujfalusi (3):
  tlv: Check out of range dB with SND_CTL_TLVT_DB_RANGE
  tlv: Handle 'holes' in SND_CTL_TLVT_DB_RANGE array
  tlv: Remove tailing tab after snd_ctl_get_dB_range function

 src/control/tlv.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)
