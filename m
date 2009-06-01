From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/1] ASoC: TWL4030: Additional check for 4
	channel mode
Date: Mon,  1 Jun 2009 14:06:39 +0300
Message-ID: <1243854400-20902-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 56F592443B
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Jun 2009 13:06:52 +0200 (CEST)
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
Cc: sakoman@gmail.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello,

the following patch adds additional check in case of four channel mode.
The codec has to be configured for TDM (DSP_A) mode when using 4 channel audio.
Without the patch boards which does not prepared for the four channel mode
could try to play four channel audio, but configure the interface to be in
I2S mode, which is not valid.

---
Peter Ujfalusi (1):
  ASoC: TWL4030: Check the interface format for 4 channel mode

 sound/soc/codecs/twl4030.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)
