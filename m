From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 1/4] ALSA: usb-audio: add check for faulty
	clock in parse_audio_format_rates_v2()
Date: Fri, 11 Jun 2010 15:33:08 +0200
Message-ID: <1276263191-8652-2-git-send-email-daniel@caiaq.de>
References: <1276263191-8652-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D76D1039BC
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jun 2010 15:33:42 +0200 (CEST)
In-Reply-To: <1276263191-8652-1-git-send-email-daniel@caiaq.de>
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
Cc: tiwai@suse.de, alexlee188@gmail.com, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/format.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 5367cd1..df5b29f 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -218,6 +218,12 @@ static int parse_audio_format_rates_v2(struct snd_usb_audio *chip,
 	int i, nr_rates, data_size, ret = 0;
 	int clock = snd_usb_clock_find_source(chip, chip->ctrl_intf, fp->clock);
 
+	if (clock < 0) {
+		snd_printk(KERN_ERR "%s(): unable to find clock source (clock %d)\n",
+				__func__, clock);
+		goto err;
+	}
+
 	/* get the number of sample rates first by only fetching 2 bytes */
 	ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_RANGE,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
-- 
1.7.1
