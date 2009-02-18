From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/1] ASoC: TWL4030: Digital loopback support
Date: Wed, 18 Feb 2009 14:39:04 +0200
Message-ID: <1234960745-18604-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id EC43B10389C
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:39:30 +0100 (CET)
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Hello,

The following patch adds the digital loopback support for TWL4030 codec driver.

Effectively the digital loopback is routing the audio from the TX1 capture path
to the RX2 playback path.

With the patch applied, the audio coming from digimic0 can be routed back to the
playback path without any CPU interaction.
Also one can use this loopback instead of the analog bypass for the analog
inputs as well, given that the TX1 capture path is configured in such a way.

---
Peter Ujfalusi (1):
  ASoC: TWL4030: Add digital loopback support

 sound/soc/codecs/twl4030.c |   57 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 51 insertions(+), 6 deletions(-)
