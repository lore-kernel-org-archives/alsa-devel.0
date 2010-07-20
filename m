From: John Lindgren <john.lindgren@tds.net>
Subject: [PATCH] Memory leak in namehint.c
Date: Tue, 20 Jul 2010 15:26:32 -0400
Message-ID: <4C45F868.7060807@tds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C64C71037F8
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 21:26:36 +0200 (CEST)
Received: by vws9 with SMTP id 9so6389655vws.38
	for <alsa-devel@alsa-project.org>; Tue, 20 Jul 2010 12:26:35 -0700 (PDT)
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

get_card_name() can be called more than once on the same list, so it
must free the previous list->cardname before replacing it.

Signed-off-by: John Lindgren <john.lindgren@tds.net>
---

 src/control/namehint.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/control/namehint.c b/src/control/namehint.c
index 78572d8..fc1cb27 100644
--- a/src/control/namehint.c
+++ b/src/control/namehint.c
@@ -471,6 +471,8 @@ static int get_card_name(struct hint_list *list, int card)
        char scard[16], *s;
        int err;
 
+       if (list->cardname)
+               free(list->cardname);
        err = snd_card_get_name(card, &list->cardname);
        if (err <= 0)
                return 0;
