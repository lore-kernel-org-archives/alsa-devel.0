From: Pierre-Louis Bossart <bossart.nospam@gmail.com>
Subject: [PATCH 1/2] pcm: pass hw_params flags to slave
Date: Mon,  1 Nov 2010 17:13:33 -0500
Message-ID: <1288649614-31581-1-git-send-email-pierre-louis.bossart@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D72A4103845
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 23:13:43 +0100 (CET)
Received: by gxk28 with SMTP id 28so2755934gxk.38
	for <alsa-devel@alsa-project.org>; Mon, 01 Nov 2010 15:13:43 -0700 (PDT)
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

fix required before interrupt disabling routines patch can be applied.
Without this fix, the interrupts are only disabled when accessing
directly hw devices.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
---
 src/pcm/pcm_params.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/pcm/pcm_params.c b/src/pcm/pcm_params.c
index 3a90bcd..416b081 100644
--- a/src/pcm/pcm_params.c
+++ b/src/pcm/pcm_params.c
@@ -2126,6 +2126,7 @@ int _snd_pcm_hw_params_refine(snd_pcm_hw_params_t *params,
 			err = changed;
 	}
 	params->info &= src->info;
+        params->flags = src->flags; /* propagate flags to slave */
 	return err;
 }
 
-- 
1.7.2.3
