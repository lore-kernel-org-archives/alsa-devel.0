From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/1] ASoC: fix the dapm_mux_update_power
	function for value_mux
Date: Thu, 15 Jan 2009 14:40:46 +0200
Message-ID: <1232023247-21480-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id D19CB103872
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 13:41:01 +0100 (CET)
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
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, broonie@sirena.org.uk, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hello,

To be honest I don't know how I have missed this from the previous series with
the cleanup for the value_mux type.

the dapm_mux_update_power function needs to check for both snd_soc_dapm_mux and
snd_soc_dapm_value_mux.

---
Peter Ujfalusi (1):
  ASoC: Fix the power update function for snd_soc_dapm_value_mux

 sound/soc/soc-dapm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)
