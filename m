From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 4/5] ALSA: echoaudio: Remove unused variable
Date: Tue,  1 Jul 2014 17:02:57 +0530
Message-ID: <1404214378-24669-4-git-send-email-sachin.kamat@samsung.com>
References: <1404214378-24669-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 188FD261B0A
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 13:36:39 +0200 (CEST)
Received: by mail-pd0-f175.google.com with SMTP id v10so9936458pde.6
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 04:36:39 -0700 (PDT)
In-Reply-To: <1404214378-24669-1-git-send-email-sachin.kamat@samsung.com>
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
Cc: tiwai@suse.de, spk.linux@gmail.com
List-Id: alsa-devel@alsa-project.org

'chip' is not used in the function. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 sound/pci/echoaudio/echoaudio.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 9f10c9e0df5e..631aaa4046ad 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -1754,9 +1754,6 @@ static struct snd_kcontrol_new snd_echo_vumeters_switch = {
 static int snd_echo_vumeters_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
 {
-	struct echoaudio *chip;
-
-	chip = snd_kcontrol_chip(kcontrol);
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 96;
 	uinfo->value.integer.min = ECHOGAIN_MINOUT;
@@ -1798,9 +1795,6 @@ static struct snd_kcontrol_new snd_echo_vumeters = {
 static int snd_echo_channels_info_info(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_info *uinfo)
 {
-	struct echoaudio *chip;
-
-	chip = snd_kcontrol_chip(kcontrol);
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 6;
 	uinfo->value.integer.min = 0;
-- 
1.7.9.5
