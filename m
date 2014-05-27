From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1] sound/aoa/codecs/onyx.c: use static const
	for texts
Date: Tue, 27 May 2014 09:12:18 +0200
Message-ID: <20140527091218.246af6a3346fa67930e41f18@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay010.isp.belgacom.be (mailrelay010.isp.belgacom.be
 [195.238.6.177])
 by alsa0.perex.cz (Postfix) with ESMTP id AF576265505
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 09:12:19 +0200 (CEST)
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
Cc: Takashi Iwai <tiway@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org

'texts' is only used as source in strcpy

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiway@suse.de>
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
This is untested.

 sound/aoa/codecs/onyx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index f01bffb..401107b 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -241,7 +241,7 @@ static struct snd_kcontrol_new inputgain_control = {
 static int onyx_snd_capture_source_info(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = { "Line-In", "Microphone" };
+	static const char * const texts[] = { "Line-In", "Microphone" };
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-- 
1.9.1
