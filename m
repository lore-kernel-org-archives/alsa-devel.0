From: Martin Koegler <martin.koegler@chello.at>
Subject: [PATCH] Show sequencer sound card numer/PID via
	aconnect
Date: Tue,  8 Mar 2016 23:06:47 +0100
Message-ID: <1457474807-10240-1-git-send-email-martin@mail.zuhause>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe04-1.mx.upcmail.net
 (vie01a-dmta-pe04-1.mx.upcmail.net [62.179.121.163])
 by alsa0.perex.cz (Postfix) with ESMTP id DF5EC260515
 for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2016 08:57:51 +0100 (CET)
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
 by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <martin.koegler@chello.at>) id 1adZ0B-0003Qa-GN
 for alsa-devel@alsa-project.org; Wed, 09 Mar 2016 08:57:51 +0100
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
 configure.ac            |  9 +++++++++
 seq/aconnect/aconnect.c | 17 ++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index bdb133c..9e48190 100644
--- a/configure.ac
+++ b/configure.ac
@@ -41,6 +41,15 @@ AC_CHECK_HEADERS([alsa/topology.h], [have_topology="yes"], [have_topology="no"],
 AC_CHECK_HEADERS([samplerate.h], [have_samplerate="yes"], [have_samplerate="no"],
   [#include <samplerate.h>])
 
+AC_CHECK_LIB([asound], [snd_seq_client_info_get_card], [HAVE_SEQ_CLIENT_INFO_GET_CARD="yes"])
+if test "$HAVE_SEQ_CLIENT_INFO_GET_CARD" = "yes" ; then
+    AC_DEFINE([HAVE_SEQ_CLIENT_INFO_GET_CARD], 1, [alsa-lib supports snd_seq_client_info_get_card])
+fi
+AC_CHECK_LIB([asound], [snd_seq_client_info_get_pid], [HAVE_SEQ_CLIENT_INFO_GET_PID="yes"])
+if test "$HAVE_SEQ_CLIENT_INFO_GET_PID" = "yes" ; then
+    AC_DEFINE([HAVE_SEQ_CLIENT_INFO_GET_PID], 1, [alsa-lib supports snd_seq_client_info_get_pid])
+fi
+
 AM_CONDITIONAL(HAVE_PCM, test "$have_pcm" = "yes")
 AM_CONDITIONAL(HAVE_MIXER, test "$have_mixer" = "yes")
 AM_CONDITIONAL(HAVE_RAWMIDI, test "$have_rawmidi" = "yes")
diff --git a/seq/aconnect/aconnect.c b/seq/aconnect/aconnect.c
index 8d6cebb..85a7770 100644
--- a/seq/aconnect/aconnect.c
+++ b/seq/aconnect/aconnect.c
@@ -166,11 +166,26 @@ static void print_port(snd_seq_t *seq, snd_seq_client_info_t *cinfo,
 		       snd_seq_port_info_t *pinfo, int count)
 {
 	if (! count) {
-		printf(_("client %d: '%s' [type=%s]\n"),
+		int card = -1, pid = -1;
+
+		printf(_("client %d: '%s' [type=%s"),
 		       snd_seq_client_info_get_client(cinfo),
 		       snd_seq_client_info_get_name(cinfo),
 		       (snd_seq_client_info_get_type(cinfo) == SND_SEQ_USER_CLIENT ?
 			_("user") : _("kernel")));
+
+#ifdef HAVE_SEQ_CLIENT_INFO_GET_CARD
+		card = snd_seq_client_info_get_card(cinfo);
+#endif
+		if (card != -1)
+			printf(",card=%d", card);
+
+#ifdef HAVE_SEQ_CLIENT_INFO_GET_PID
+		pid = snd_seq_client_info_get_pid(cinfo);
+#endif
+		if (pid != -1)
+			printf(",pid=%d", pid);
+		printf("]\n");
 	}
 	printf("  %3d '%-16s'\n",
 	       snd_seq_port_info_get_port(pinfo),
-- 
2.1.4
