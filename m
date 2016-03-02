From: Martin Koegler <martin.koegler@chello.at>
Subject: [PATCH v2 3/3] Show sequencer sound card numer/PID via
	aconnect
Date: Wed,  2 Mar 2016 19:26:27 +0100
Message-ID: <1456943188-29600-2-git-send-email-martin@mail.zuhause>
References: <1456943188-29600-1-git-send-email-martin@mail.zuhause>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe04-3.mx.upcmail.net
 (vie01a-dmta-pe04-3.mx.upcmail.net [62.179.121.165])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BEA0265463
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 19:27:44 +0100 (CET)
Received: from [172.31.216.43] (helo=vie01a-pemc-psmtp-pe01)
 by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <martin.koegler@chello.at>) id 1abBUu-0005A2-7N
 for alsa-devel@alsa-project.org; Wed, 02 Mar 2016 19:27:44 +0100
In-Reply-To: <1456943188-29600-1-git-send-email-martin@mail.zuhause>
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
Cc: Martin Koegler <martin.koegler@chello.at>
List-Id: alsa-devel@alsa-project.org

From: Martin Koegler <martin.koegler@chello.at>

rawmidi devices expose the card number via IOCTLs, which allows to
find the corresponding device in sysfs.

The sequencer provides no identifing data. Chromium works around this
issue by scanning rawmidi as well as sequencer devices and matching
them by using assumtions, how the kernel register sequencer devices.

This patch adds support for displaying the sound card number/PID to
aconnect.

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 seq/aconnect/aconnect.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/seq/aconnect/aconnect.c b/seq/aconnect/aconnect.c
index 8d6cebb..d299f5c 100644
--- a/seq/aconnect/aconnect.c
+++ b/seq/aconnect/aconnect.c
@@ -166,11 +166,22 @@ static void print_port(snd_seq_t *seq, snd_seq_client_info_t *cinfo,
 		       snd_seq_port_info_t *pinfo, int count)
 {
 	if (! count) {
-		printf(_("client %d: '%s' [type=%s]\n"),
+		int card, pid;
+
+		printf(_("client %d: '%s' [type=%s"),
 		       snd_seq_client_info_get_client(cinfo),
 		       snd_seq_client_info_get_name(cinfo),
 		       (snd_seq_client_info_get_type(cinfo) == SND_SEQ_USER_CLIENT ?
 			_("user") : _("kernel")));
+
+		card = snd_seq_client_info_get_card(cinfo);
+		if (card != -1)
+			printf(",card=%d", card);
+
+		pid = snd_seq_client_info_get_pid(cinfo);
+		if (pid != -1)
+			printf(",pid=%d", pid);
+		printf("]\n");
 	}
 	printf("  %3d '%-16s'\n",
 	       snd_seq_port_info_get_port(pinfo),
-- 
2.1.4
