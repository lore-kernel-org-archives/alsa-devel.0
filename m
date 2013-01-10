From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ALSA: usb-audio: Make ebox44_table static
Date: Thu, 10 Jan 2013 11:19:14 +0530
Message-ID: <1357796954-9560-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f44.google.com (mail-pb0-f44.google.com
 [209.85.160.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 44BC5260799
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2013 06:57:32 +0100 (CET)
Received: by mail-pb0-f44.google.com with SMTP id uo1so107717pbc.31
 for <alsa-devel@alsa-project.org>; Wed, 09 Jan 2013 21:57:31 -0800 (PST)
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Fixes the following sparse warning:
sound/usb/mixer_quirks.c:1209:23: warning:
symbol 'ebox44_table' was not declared. Should it be static?

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/usb/mixer_quirks.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 0422b13..15520de 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1206,7 +1206,7 @@ static int snd_c400_create_mixer(struct usb_mixer_interface *mixer)
  * are valid they presents mono controls as L and R channels of
  * stereo. So we provide a good mixer here.
  */
-struct std_mono_table ebox44_table[] = {
+static struct std_mono_table ebox44_table[] = {
 	{
 		.unitid = 4,
 		.control = 1,
-- 
1.7.4.1
