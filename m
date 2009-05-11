From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/1] ASoC: TWL4030: Headset ramp down fix
Date: Mon, 11 May 2009 14:14:24 +0300
Message-ID: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id E811D2479B
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 13:14:32 +0200 (CEST)
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
Cc: sakoman@gmail.com, anuj.aggarwal@ti.com, getarunks@gmail.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello,

The following patch should fix (or at least makes it less intrusive) the 'tuck'
phenomena on observed on the twl4030 Headset outputs when the codec is going
to standby mode.

I have debugged this with the scope and if we are not waiting RAMP_DELAY time,
the VMID is cut before it reaching 0, which generates the 'tuck'.

Note that I have not removed the control for the RAMP_DELAY configuration, the
code will use that to calculate the needed delay (also the sysfreq is needed,
which also stored).
However I do think that one should not touch the RAMP_DELAY...

It would be nice to hear from you guys, if it solves/softens the 'tuck'.

---
Peter Ujfalusi (1):
  ASoC: TWL4030: Wait RAMP_DELAY on headsetl_event: POST_PMD

 sound/soc/codecs/twl4030.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)
