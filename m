From: ext-eero.nurkkala@nokia.com
Subject: [RFC 1/2] ASoC: remove io_mutex
Date: Fri, 30 Oct 2009 13:34:02 +0200
Message-ID: <1256902443-15492-2-git-send-email-ext-eero.nurkkala@nokia.com>
References: <1256902443-15492-1-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CA6A103889
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 12:35:45 +0100 (CET)
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id
	n9UBZdFh020414
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 13:35:44 +0200
In-Reply-To: <1256902443-15492-1-git-send-email-ext-eero.nurkkala@nokia.com>
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
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

Remove the io_mutex. It has a drawback of serializing
all accesses to snd_soc_update_bits() even when multiple
codecs are in use. In addition, it fails to actually do
its task - during snd_soc_update_bits(), dapm_update_bits()
may also be accessing the same register which may result in
an outdated register value.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 sound/soc/soc-core.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7ff04ad..1f42d46 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -37,7 +37,6 @@
 #include <sound/initval.h>
 
 static DEFINE_MUTEX(pcm_mutex);
-static DEFINE_MUTEX(io_mutex);
 static DECLARE_WAIT_QUEUE_HEAD(soc_pm_waitq);
 
 #ifdef CONFIG_DEBUG_FS
@@ -1361,14 +1360,12 @@ int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned short reg,
 	int change;
 	unsigned int old, new;
 
-	mutex_lock(&io_mutex);
 	old = snd_soc_read(codec, reg);
 	new = (old & ~mask) | value;
 	change = old != new;
 	if (change)
 		snd_soc_write(codec, reg, new);
 
-	mutex_unlock(&io_mutex);
 	return change;
 }
 EXPORT_SYMBOL_GPL(snd_soc_update_bits);
@@ -1391,11 +1388,9 @@ int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned short reg,
 	int change;
 	unsigned int old, new;
 
-	mutex_lock(&io_mutex);
 	old = snd_soc_read(codec, reg);
 	new = (old & ~mask) | value;
 	change = old != new;
-	mutex_unlock(&io_mutex);
 
 	return change;
 }
-- 
1.6.0.4
