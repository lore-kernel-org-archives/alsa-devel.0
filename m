From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH 1/4] Fix several typos in manpage and help
	strings.
Date: Wed, 15 May 2013 19:12:54 +0200
Message-ID: <1368637977-29096-2-git-send-email-jordi@debian.org>
References: <1368637977-29096-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 5417E265372
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:13:11 +0200 (CEST)
In-Reply-To: <1368637977-29096-1-git-send-email-jordi@debian.org>
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
List-Id: alsa-devel@alsa-project.org

From: Elimar Riesebieter <riesebie@lxtec.de>

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 aplay/aplay.c               |    2 +-
 iecset/iecbits.c            |    2 +-
 seq/aseqnet/aseqnet.c       |    2 +-
 speaker-test/speaker-test.1 |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 000d25b..89c6b06 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -248,7 +248,7 @@ _("Usage: %s [OPTION]... [FILE]...\n"
 			printf(" %s", s);
 	}
 	printf(_("\nSome of these may not be available on selected hardware\n"));
-	printf(_("The availabled format shortcuts are:\n"));
+	printf(_("The available format shortcuts are:\n"));
 	printf(_("-f cd (16 bit little endian, 44100, stereo)\n"));
 	printf(_("-f cdr (16 bit big endian, 44100, stereo)\n"));
 	printf(_("-f dat (16 bit little endian, 48000, stereo)\n"));
diff --git a/iecset/iecbits.c b/iecset/iecbits.c
index edea932..13e8947 100644
--- a/iecset/iecbits.c
+++ b/iecset/iecbits.c
@@ -218,7 +218,7 @@ void dump_iec958(snd_aes_iec958_t *iec)
 			printf("user-defined\n");
 			break;
 		default:
-			printf("unkown\n");
+			printf("unknown\n");
 			break;
 		}
 		printf("Sample Bits: ");
diff --git a/seq/aseqnet/aseqnet.c b/seq/aseqnet/aseqnet.c
index e071ad9..70a1cfd 100644
--- a/seq/aseqnet/aseqnet.c
+++ b/seq/aseqnet/aseqnet.c
@@ -167,7 +167,7 @@ static void usage(void)
 	printf(_("  server mode: aseqnet [-options]\n"));
 	printf(_("  client mode: aseqnet [-options] server_host\n"));
 	printf(_("options:\n"));
-	printf(_("  -p,--port # : sepcify TCP port (digit or service name)\n"));
+	printf(_("  -p,--port # : specify TCP port (digit or service name)\n"));
 	printf(_("  -s,--source addr : read from given addr (client:port)\n"));
 	printf(_("  -d,--dest addr : write to given addr (client:port)\n"));
 	printf(_("  -v, --verbose : print verbose messages\n"));
diff --git a/speaker-test/speaker-test.1 b/speaker-test/speaker-test.1
index cad88b5..a1c90bb 100644
--- a/speaker-test/speaker-test.1
+++ b/speaker-test/speaker-test.1
@@ -86,7 +86,7 @@ When 0 is given, the periods given by \fB\-P\fP option is used.
 The default value is 0.
 
 .TP
-\fB\-P\fP | \fB\-\-nperiods\fP \fPERIODS\fP
+\fB\-P\fP | \fB\-\-nperiods\fP \fPPERIODS\fP
 Use number of periods.  The default value is 4.
 
 .TP
-- 
1.7.10.4
