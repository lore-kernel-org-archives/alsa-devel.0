From: Martin Koegler <martin.koegler@chello.at>
Subject: [PATCH] Show sequencer sound card numer/PID via
	aconnect
Date: Sat, 13 Feb 2016 14:42:16 +0100
Message-ID: <1455370937-501-2-git-send-email-martin@mail.zuhause>
References: <1455370937-501-1-git-send-email-martin@mail.zuhause>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe04-3.mx.upcmail.net
 (vie01a-dmta-pe04-3.mx.upcmail.net [62.179.121.165])
 by alsa0.perex.cz (Postfix) with ESMTP id 365342605B7
 for <alsa-devel@alsa-project.org>; Sat, 13 Feb 2016 14:42:26 +0100 (CET)
Received: from [172.31.216.43] (helo=vie01a-pemc-psmtp-pe01)
 by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <martin.koegler@chello.at>) id 1aUaSv-0005Ln-NK
 for alsa-devel@alsa-project.org; Sat, 13 Feb 2016 14:42:25 +0100
In-Reply-To: <1455370937-501-1-git-send-email-martin@mail.zuhause>
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
 seq/aconnect/aconnect.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/seq/aconnect/aconnect.c b/seq/aconnect/aconnect.c
index 8d6cebb..3508e1b 100644
--- a/seq/aconnect/aconnect.c
+++ b/seq/aconnect/aconnect.c
@@ -166,11 +166,19 @@ static void print_port(snd_seq_t *seq, snd_seq_client_info_t *cinfo,
 		       snd_seq_port_info_t *pinfo, int count)
 {
 	if (! count) {
-		printf(_("client %d: '%s' [type=%s]\n"),
+		printf(_("client %d: '%s' [type=%s"),
 		       snd_seq_client_info_get_client(cinfo),
 		       snd_seq_client_info_get_name(cinfo),
 		       (snd_seq_client_info_get_type(cinfo) == SND_SEQ_USER_CLIENT ?
 			_("user") : _("kernel")));
+		int owner = snd_seq_client_info_get_owner(cinfo);
+		if (owner != -1) {
+			if (snd_seq_client_info_get_type(cinfo) == SND_SEQ_USER_CLIENT)
+				printf(",pid=%d", owner);
+			else
+				printf(",card=%d", owner);
+		}
+		printf("]\n");
 	}
 	printf("  %3d '%-16s'\n",
 	       snd_seq_port_info_get_port(pinfo),
-- 
2.6.2
