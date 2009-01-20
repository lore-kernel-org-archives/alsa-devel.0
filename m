From: Risto Suominen <Risto.Suominen@gmail.com>
Subject: [PATCH - snd-powermac 4/5] Allow input from mic in
	iBook G3 Dual-USB
Date: Tue, 20 Jan 2009 22:01:16 +0200
Message-ID: <1232481677-11579-4-git-send-email-Risto.Suominen@gmail.com>
References: <> <1232481677-11579-1-git-send-email-Risto.Suominen@gmail.com>
	<1232481677-11579-2-git-send-email-Risto.Suominen@gmail.com>
	<1232481677-11579-3-git-send-email-Risto.Suominen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw03.mail.saunalahti.fi (gw03.mail.saunalahti.fi
	[195.197.172.111])
	by alsa0.perex.cz (Postfix) with ESMTP id ABAE8103863
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 21:01:33 +0100 (CET)
In-Reply-To: <1232481677-11579-3-git-send-email-Risto.Suominen@gmail.com>
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

Allow input from microphone on iBook G3 Dual-USB (Tumbler).

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>

diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index af76ee8..bd8f92b 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -1033,7 +1033,8 @@ static int __init snd_pmac_detect(struct snd_pmac *chip)
 	}
 	if (of_device_is_compatible(sound, "tumbler")) {
 		chip->model = PMAC_TUMBLER;
-		chip->can_capture = machine_is_compatible("PowerMac4,2");
+		chip->can_capture = machine_is_compatible("PowerMac4,2")
+				|| machine_is_compatible("PowerBook4,1");
 		chip->can_duplex = 0;
 		// chip->can_byte_swap = 0; /* FIXME: check this */
 		chip->num_freqs = ARRAY_SIZE(tumbler_freqs);
-- 
1.5.4.3
