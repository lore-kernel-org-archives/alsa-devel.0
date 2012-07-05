From: Martin Sandsmark <martin.sandsmark@kde.org>
Subject: [PATCH] Removing an assert
Date: Thu, 05 Jul 2012 09:55:23 +0200
Message-ID: <1381041.X9jejKqOkf@malacandra>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart21993734.SHAHOXH9Wi"
Content-Transfer-Encoding: 7Bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassarossa.samfundet.no (cassarossa.samfundet.no
	[129.241.93.19]) by alsa0.perex.cz (Postfix) with ESMTP id 801A424340
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 09:58:27 +0200 (CEST)
Received: from wifi.itcollege.ee ([193.40.194.207] helo=malacandra.localnet)
	by cassarossa.samfundet.no with esmtpsa
	(TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.72)
	(envelope-from <martin.sandsmark@kde.org>) id 1SmgxG-0003VM-4d
	for alsa-devel@alsa-project.org; Thu, 05 Jul 2012 09:58:26 +0200
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
List-Id: alsa-devel@alsa-project.org


--nextPart21993734.SHAHOXH9Wi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi!

There is an assert in snd_hctl_handle_event in alsa-lib that gets triggered on 
every login for many KDE users. From what I can see it is superflous, and gets 
triggered because the device in an event has gone away. This case is handled 
just beneath the assert as well, and I therefore don't see the reason for this 
assert at all.

Entry in bug tracker:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5471


-- 
Martin Sandsmark

--nextPart21993734.SHAHOXH9Wi
Content-Disposition: attachment; filename="0001-Remove-a-useless-assert.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-Remove-a-useless-assert.patch"

>From dff3de9705eb617b619251c2aec30d5ca9c13046 Mon Sep 17 00:00:00 2001
From: Martin Sandsmark <martin.sandsmark@kde.org>
Date: Thu, 5 Jul 2012 09:40:07 +0200
Subject: [PATCH] Remove a useless assert.

The case where the element is unavailable (for example gone away since
the event was created) is handled beneath.

See also bug 5471.
---
 src/control/hcontrol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/control/hcontrol.c b/src/control/hcontrol.c
index 8ffc434..ee1d907 100644
--- a/src/control/hcontrol.c
+++ b/src/control/hcontrol.c
@@ -761,7 +761,6 @@ static int snd_hctl_handle_event(snd_hctl_t *hctl, snd_ctl_event_t *event)
 	if (event->data.elem.mask & (SNDRV_CTL_EVENT_MASK_VALUE |
 				     SNDRV_CTL_EVENT_MASK_INFO)) {
 		elem = snd_hctl_find_elem(hctl, &event->data.elem.id);
-		assert(elem);
 		if (!elem)
 			return -ENOENT;
 		res = snd_hctl_elem_throw_event(elem, event->data.elem.mask &
-- 
1.7.11.1


--nextPart21993734.SHAHOXH9Wi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--nextPart21993734.SHAHOXH9Wi--
