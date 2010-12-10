From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC 2.6.38] ASoC: Fix bias power down of non-DAPM
	codec
Date: Fri, 10 Dec 2010 18:23:41 +0200
Message-ID: <1291998221-9642-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B3A524554
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 17:22:42 +0100 (CET)
Received: by eyg24 with SMTP id 24so2414560eyg.24
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 08:22:38 -0800 (PST)
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
RFC since does this look a valid fix and how to deal with 2.6.37? I think
patching the .37 first will result in bisect build errors in mainline when
later merging upcoming .38 changes. Would it be better to patch .37 after
it's released?
---
 sound/soc/soc-dapm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9af2d8a..b521a13 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -981,6 +981,9 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 		case SND_SOC_DAPM_STREAM_RESUME:
 			sys_power = 1;
 			break;
+		case SND_SOC_DAPM_STREAM_STOP:
+			sys_power = !!dapm->codec->active;
+			break;
 		case SND_SOC_DAPM_STREAM_SUSPEND:
 			sys_power = 0;
 			break;
-- 
1.7.2.3
