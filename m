From: "Arkadiusz (Arkq) Bokowy" <arkadiusz.bokowy@gmail.com>
Subject: [PATCH 1/3] rate: Check for slave avail update error
	code
Date: Sun, 7 Jan 2018 14:30:12 +0100
Message-ID: <20180107143012.78211148@sambook>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
 [209.85.215.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 76584267035
 for <alsa-devel@alsa-project.org>; Sun,  7 Jan 2018 14:33:15 +0100 (CET)
Received: by mail-lf0-f68.google.com with SMTP id c19so9525094lfg.3
 for <alsa-devel@alsa-project.org>; Sun, 07 Jan 2018 05:33:15 -0800 (PST)
Received: from sambook (89-73-142-93.dynamic.chello.pl. [89.73.142.93])
 by smtp.gmail.com with ESMTPSA id f73sm1764330lfg.93.2018.01.07.05.33.14
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 07 Jan 2018 05:33:14 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

rate: Check for slave avail update error code

Signed-off-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
---
 src/pcm/pcm_rate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 4e0c7ca7..e7d50593 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -970,9 +970,11 @@ static snd_pcm_sframes_t
snd_pcm_rate_avail_update(snd_pcm_t *pcm) {
 	snd_pcm_rate_t *rate = pcm->private_data;
 	snd_pcm_t *slave = rate->gen.slave;
-	snd_pcm_uframes_t slave_size;
+	snd_pcm_sframes_t slave_size;
 
 	slave_size = snd_pcm_avail_update(slave);
+	if (slave_size < 0)
+		return slave_size;
 	if (pcm->stream == SND_PCM_STREAM_CAPTURE)
 		goto _capture;
 	snd_pcm_rate_sync_hwptr(pcm);
-- 
2.13.6
