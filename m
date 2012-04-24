From: John Spencer <maillist-alsa@barfooze.de>
Subject: [PATCH] fix bug 5579: invalid long long format
	specifier
Date: Tue, 24 Apr 2012 12:58:48 +0200
Message-ID: <4F968768.20102@barfooze.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040707000502000402000200"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from furnace.wzff.de (furnace.wzff.de [176.9.216.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 3909010416D
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2012 12:53:42 +0200 (CEST)
Received: from xdsl-188-155-204-150.adslplus.ch ([188.155.204.150]
	helo=[172.16.0.230])
	by furnace.wzff.de with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.77 (FreeBSD)) (envelope-from <maillist-alsa@barfooze.de>)
	id 1SMdNM-0009D9-Fb
	for alsa-devel@alsa-project.org; Tue, 24 Apr 2012 12:53:42 +0200
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

This is a multi-part message in MIME format.
--------------040707000502000402000200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

the attached patch fixes an invalid long long format specifier issue (%L 
was used by mistake, which is the long double specifier).
this lead to abort() on 64bit system, making some of the alsa-utils 
unusable.

--JS

--------------040707000502000402000200
Content-Type: text/x-patch;
 name="0001-fix-bug-5579-invalid-long-long-format-specifier.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-fix-bug-5579-invalid-long-long-format-specifier.patch"

>From 63fe3fa4765c423ef6904a4506e4ed74908ecfb6 Mon Sep 17 00:00:00 2001
From: John Spencer <maillist-alsa@barfooze.de>
Date: Tue, 24 Apr 2012 12:41:27 +0200
Subject: [PATCH] fix bug 5579: invalid long long format specifier

Per POSIX:

       L      Specifies that a following a, A, e, E, f, F, g, or G  conversion
              specifier applies to a long double argument.

L is only intended to be used with long doubles, not long long ints.

the proper way is to use "ll" instead.

Signed-off-by: John Spencer <maillist-alsa@barfooze.de>
---
 src/conf.c      |    6 +++---
 test/midiloop.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/conf.c b/src/conf.c
index 5b1b5a6..32446a2 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -496,7 +496,7 @@ static int safe_strtoll(const char *str, long long *val)
 	if (!*str)
 		return -EINVAL;
 	errno = 0;
-	if (sscanf(str, "%Li%n", &v, &endidx) < 1)
+	if (sscanf(str, "%lli%n", &v, &endidx) < 1)
 		return -EINVAL;
 	if (str[endidx])
 		return -EINVAL;
@@ -1378,7 +1378,7 @@ static int _snd_config_save_node_value(snd_config_t *n, snd_output_t *out,
 		snd_output_printf(out, "%ld", n->u.integer);
 		break;
 	case SND_CONFIG_TYPE_INTEGER64:
-		snd_output_printf(out, "%Ld", n->u.integer64);
+		snd_output_printf(out, "%lld", n->u.integer64);
 		break;
 	case SND_CONFIG_TYPE_REAL:
 		snd_output_printf(out, "%-16g", n->u.real);
@@ -2630,7 +2630,7 @@ int snd_config_get_ascii(const snd_config_t *config, char **ascii)
 		{
 			char res[32];
 			int err;
-			err = snprintf(res, sizeof(res), "%Li", config->u.integer64);
+			err = snprintf(res, sizeof(res), "%lli", config->u.integer64);
 			if (err < 0 || err == sizeof(res)) {
 				assert(0);
 				return -ENOMEM;
diff --git a/test/midiloop.c b/test/midiloop.c
index ee2e563..d6548b5 100644
--- a/test/midiloop.c
+++ b/test/midiloop.c
@@ -175,7 +175,7 @@ int main(int argc, char** argv)
 	printf("output.status.xruns = %zi\n", snd_rawmidi_status_get_xruns(ostat));
 
 	diff = timediff(end, start);
-	printf("Time diff: %Liusec (%Li bytes/sec)\n", diff, ((long long)opos * 1000000) / diff);
+	printf("Time diff: %lliusec (%lli bytes/sec)\n", diff, ((long long)opos * 1000000) / diff);
 
 	if (verbose) {
 		fprintf(stderr,"Closing\n");
-- 
1.7.3.4


--------------040707000502000402000200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040707000502000402000200--
