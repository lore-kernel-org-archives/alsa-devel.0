From: Hui Peng <benquike@gmail.com>
Subject: [PATCH] Fix a stack buffer overflow bug
	check_input_term
Date: Thu, 15 Aug 2019 00:35:49 -0400
Message-ID: <20190815043554.16623-1-benquike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14127F801DF
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 06:36:13 +0200 (CEST)
Received: by mail-ot1-x344.google.com with SMTP id c34so3355668otb.7
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2019 21:36:13 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: security@kernel.org
Cc: Mathias Payer <mathias.payer@nebelwelt.net>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>, YueHaibing <yuehaibing@huawei.com>, Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Hui Peng <benquike@gmail.com>, Allison Randal <allison@lohutok.net>
List-Id: alsa-devel@alsa-project.org

`check_input_term` recursively calls itself with input
from device side (e.g., uac_input_terminal_descriptor.bCSourceID)
as argument (id). In `check_input_term`, if `check_input_term`
is called with the same `id` argument as the caller, it triggers
endless recursive call, resulting kernel space stack overflow.

This patch fixes the bug by adding a bitmap to `struct mixer_build`
to keep track of the checked ids by `check_input_term` and stop
the execution if some id has been checked (similar to how
parse_audio_unit handles unitid argument).

Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 sound/usb/mixer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index ea487378be17..1f6c8213df82 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -68,6 +68,7 @@ struct mixer_build {
 	unsigned char *buffer;
 	unsigned int buflen;
 	DECLARE_BITMAP(unitbitmap, MAX_ID_ELEMS);
+	DECLARE_BITMAP(termbitmap, MAX_ID_ELEMS);
 	struct usb_audio_term oterm;
 	const struct usbmix_name_map *map;
 	const struct usbmix_selector_map *selector_map;
@@ -782,6 +783,8 @@ static int check_input_term(struct mixer_build *state, int id,
 	int err;
 	void *p1;
 
+	if (test_and_set_bit(id, state->termbitmap))
+		return 0;
 	memset(term, 0, sizeof(*term));
 	while ((p1 = find_audio_control_unit(state, id)) != NULL) {
 		unsigned char *hdr = p1;
-- 
2.22.1
