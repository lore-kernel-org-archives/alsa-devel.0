From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] ALSA: control: remove compilation warning on
	32-bit
Date: Fri,  4 Nov 2011 19:28:45 -0700
Message-ID: <1320460125-20881-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F1B824415
	for <alsa-devel@alsa-project.org>; Sat,  5 Nov 2011 03:29:15 +0100 (CET)
Received: by iafi7 with SMTP id i7so2936870iaf.38
	for <alsa-devel@alsa-project.org>; Fri, 04 Nov 2011 19:29:15 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Olof Johansson <olof@lixom.net>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

This was introduced by 'ALSA: control: add support for ENUMERATED user
space controls' which adds a u64 variable that gets cast to a pointer:

sound/core/control.c: In function 'snd_ctl_elem_init_enum_names':
sound/core/control.c:1089: warning: cast to pointer from integer of different size

Since we don't support 64-bit userspace on 32-bit kernel, it's safe to
cast to long before casting to pointer to avoid the warning.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 sound/core/control.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 978fe1a..d09c335 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1081,12 +1081,12 @@ static int snd_ctl_elem_init_enum_names(struct user_element *ue)
 	char *names, *p;
 	size_t buf_len, name_len;
 	unsigned int i;
+	const long user_ptrval = ue->info.value.enumerated.names_ptr;
 
 	if (ue->info.value.enumerated.names_length > 64 * 1024)
 		return -EINVAL;
 
-	names = memdup_user(
-		(const void __user *)ue->info.value.enumerated.names_ptr,
+	names = memdup_user((const void __user *)user_ptrval,
 		ue->info.value.enumerated.names_length);
 	if (IS_ERR(names))
 		return PTR_ERR(names);
-- 
1.7.4.1
