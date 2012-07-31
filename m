From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/5] ASoC: dapm: If one widget fails,
	do not force all subsequent widgets to fail too
Date: Tue, 31 Jul 2012 15:45:40 +0100
Message-ID: <1343745944-18418-2-git-send-email-lee.jones@linaro.org>
References: <1343745944-18418-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id C64F9265B44
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 16:45:59 +0200 (CEST)
Received: by mail-we0-f179.google.com with SMTP id x10so3971679wey.38
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 07:46:02 -0700 (PDT)
In-Reply-To: <1343745944-18418-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

If a list of widgets is provided and one of them fails to be added as
a control, the present semantics fail all subsequent widgets. A better
solution would be to only fail that widget, but pursue in attempting
to add the rest of the list.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/soc-dapm.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index eded657..7d9c154 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3095,8 +3095,6 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 			dev_err(dapm->dev,
 				"ASoC: Failed to create DAPM control %s\n",
 				widget->name);
-			ret = -ENOMEM;
-			break;
 		}
 		widget++;
 	}
-- 
1.7.9.5
