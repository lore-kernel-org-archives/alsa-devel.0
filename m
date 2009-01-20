From: Risto Suominen <Risto.Suominen@gmail.com>
Subject: [PATCH - snd-powermac 1/1] Allow input from mic in
	iBook G3 Dual-USB (older kernels)
Date: Tue, 20 Jan 2009 22:02:56 +0200
Message-ID: <1232481776-11609-1-git-send-email-Risto.Suominen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw03.mail.saunalahti.fi (gw03.mail.saunalahti.fi
	[195.197.172.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 84C2C1037E3
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 21:03:03 +0100 (CET)
In-Reply-To: <>
References: <>
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

Allow input from microphone on iBook G3 Dual-USB (Tumbler) on older kernels.

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>

diff --git a/ppc/pmac_old.c b/ppc/pmac_old.c
index 1bb65fe..c6ebc11 100644
--- a/ppc/pmac_old.c
+++ b/ppc/pmac_old.c
@@ -964,7 +964,8 @@ static int __init snd_pmac_detect(struct snd_pmac *chip)
 	}
 	if (device_is_compatible(sound, "tumbler")) {
 		chip->model = PMAC_TUMBLER;
-		chip->can_capture = machine_is_compatible("PowerMac4,2");
+		chip->can_capture = machine_is_compatible("PowerMac4,2")
+				|| machine_is_compatible("PowerBook4,1");
 		chip->can_duplex = 0;
 		// chip->can_byte_swap = 0; /* FIXME: check this */
 		chip->num_freqs = ARRAY_SIZE(tumbler_freqs);
-- 
1.5.4.3
