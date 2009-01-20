From: Risto Suominen <Risto.Suominen@gmail.com>
Subject: [PATCH - snd-powermac 3/5] Correct volume controls and
	HP detection for PMac 8500/9500
Date: Tue, 20 Jan 2009 22:01:15 +0200
Message-ID: <1232481677-11579-3-git-send-email-Risto.Suominen@gmail.com>
References: <> <1232481677-11579-1-git-send-email-Risto.Suominen@gmail.com>
	<1232481677-11579-2-git-send-email-Risto.Suominen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw03.mail.saunalahti.fi (gw03.mail.saunalahti.fi
	[195.197.172.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B4FF103851
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 21:01:30 +0100 (CET)
In-Reply-To: <1232481677-11579-2-git-send-email-Risto.Suominen@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Risto Suominen <Risto.Suominen@gmail.com>
List-Id: alsa-devel@alsa-project.org

Correct volume controls and headphone detection for PowerMac 8500/9500 (AWACS).

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>

diff --git a/sound/ppc/awacs.c b/sound/ppc/awacs.c
index d89c23e..9abbf64 100644
--- a/sound/ppc/awacs.c
+++ b/sound/ppc/awacs.c
@@ -766,7 +766,9 @@ static void snd_pmac_awacs_resume(struct snd_pmac *chip)
 }
 #endif /* CONFIG_PM */
 
-#define IS_PM7500 (machine_is_compatible("AAPL,7500"))
+#define IS_PM7500 (machine_is_compatible("AAPL,7500") \
+		|| machine_is_compatible("AAPL,8500") \
+		|| machine_is_compatible("AAPL,9500"))
 #define IS_PM5500 (machine_is_compatible("AAPL,e411"))
 #define IS_BEIGE (machine_is_compatible("AAPL,Gossamer"))
 #define IS_IMAC1 (machine_is_compatible("PowerMac2,1"))
-- 
1.5.4.3
