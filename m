From: ext-eero.nurkkala@nokia.com
Subject: [PATCH 1/1] ASoC: Serialize access to
	dapm_power_widgets()
Date: Mon, 12 Oct 2009 08:41:59 +0300
Message-ID: <1255326119-12281-2-git-send-email-ext-eero.nurkkala@nokia.com>
References: <1255326119-12281-1-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DB6D103804
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Oct 2009 07:43:21 +0200 (CEST)
In-Reply-To: <1255326119-12281-1-git-send-email-ext-eero.nurkkala@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, Eero Nurkkala <ext-eero.nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

Access to damp_power_widgets() is assumed to be single-threaded.
Concurrent accesses to dapm_power_widgets() may result in 
unpredictable behavior.

Calls from:
close_delayed_work()
soc_codec_close()
soc_pcm_prepare()
soc_suspend()
soc_resume_deferred()
to snd_soc_dapm_stream_event() do not have the codec->mutex
taken to cover the call to dapm_power_widgets(). Thus, take
the mutex in these paths also to assure single-threaded use
of dapm_power_widgets().

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 sound/soc/soc-dapm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f79711b..e2344f9 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2071,9 +2071,9 @@ int snd_soc_dapm_stream_event(struct snd_soc_codec *codec,
 			}
 		}
 	}
-	mutex_unlock(&codec->mutex);
 
 	dapm_power_widgets(codec, event);
+	mutex_unlock(&codec->mutex);
 	dump_dapm(codec, __func__);
 	return 0;
 }
-- 
1.6.0.4
