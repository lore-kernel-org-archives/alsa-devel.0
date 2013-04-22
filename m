From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH,
	for-next 2/2] ALSA: asihpi: add format support check in
	snd_card_asihpi_capture_formats
Date: Tue, 23 Apr 2013 01:00:42 +0200
Message-ID: <1366671642-30423-2-git-send-email-eldad@fogrefinery.com>
References: <s5hk3nu4wfa.wl%tiwai@suse.de>
 <1366671642-30423-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f43.google.com (mail-bk0-f43.google.com
 [209.85.214.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A4549261721
 for <alsa-devel@alsa-project.org>; Tue, 23 Apr 2013 01:01:02 +0200 (CEST)
Received: by mail-bk0-f43.google.com with SMTP id jm19so736bkc.30
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2013 16:01:02 -0700 (PDT)
In-Reply-To: <1366671642-30423-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Eldad Zack <eldad@fogrefinery.com>, Daniel Mack <zonque@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Some Asihpi formats are not supported or invalid, and their mapping to
ALSA format is set to -1.
Before performing the format conversion into ALSA bitwise formats,
add a consistency check for the requested format, as done in
snd_card_asihpi_playback_formats().

Compile tested only.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/pci/asihpi/asihpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 160cf83..fbc1720 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -1141,7 +1141,7 @@ static u64 snd_card_asihpi_capture_formats(struct snd_card_asihpi *asihpi,
 					format, sample_rate, 128000, 0);
 		if (!err)
 			err = hpi_instream_query_format(h_stream, &hpi_format);
-		if (!err)
+		if (!err && (hpi_to_alsa_formats[format] != -1))
 			formats |= pcm_format_to_bits(hpi_to_alsa_formats[format]);
 	}
 	return formats;
-- 
1.8.1.5
