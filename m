From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/1] ASoC: DAPM: Fix for line widget handling
Date: Wed, 30 Sep 2009 09:27:23 +0300
Message-ID: <1254292044-26634-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A4D010380F
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 08:28:46 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello,

The following patch fixes the handling of the line widget, which can be input or
output.

Additional check is added to is_connected_output_ep and is_connected_input_ep
functions when the line widget is checked to handle only the appropriate
line widget.

Without the patch these two functions would pick up either line widgets, which
confused DAPM.

Note: checkpach complains for the long lines, but I feel that it is appropriate
here to use the long lines.

---
Peter Ujfalusi (1):
  ASoC: Fix SND_SOC_DAPM_LINE handling

 sound/soc/soc-dapm.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)
