From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2.6.37] ASoC: Fix bias power down of non-DAPM
	codec
Date: Fri, 10 Dec 2010 20:53:55 +0200
Message-ID: <1292007235-22090-1-git-send-email-jhnikula@gmail.com>
References: <20101210174227.GH3200@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by alsa0.perex.cz (Postfix) with ESMTP id DFD31245D6
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 19:52:44 +0100 (CET)
Received: by ewy1 with SMTP id 1so2820391ewy.29
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 10:52:44 -0800 (PST)
In-Reply-To: <20101210174227.GH3200@rakim.wolfsonmicro.main>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Currently bias of non-DAPM codec will be powered down (standby/off) whenever
there is a stream stop. This is wrong in simultaneous playback/capture since
the bias is put down immediately after stopping the first stream.

Fix this by using the codec->active count when figuring out the needed bias
level after stream stop.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/soc-dapm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 75ed649..c721502 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -944,6 +944,9 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 		case SND_SOC_DAPM_STREAM_RESUME:
 			sys_power = 1;
 			break;
+		case SND_SOC_DAPM_STREAM_STOP:
+			sys_power = !!codec->active;
+			break;
 		case SND_SOC_DAPM_STREAM_SUSPEND:
 			sys_power = 0;
 			break;
-- 
1.7.2.3
