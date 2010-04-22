From: pedro.lopez.cabanillas@gmail.com
Subject: [PATCH - alsa-lib 1/1] Fix for snd_seq_parse_address()
Date: Thu, 22 Apr 2010 15:42:20 +0200
Message-ID: <1271943740-26817-1-git-send-email-pedro.lopez.cabanillas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Pedro Lopez-Cabanillas <pedro.lopez.cabanillas@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Pedro Lopez-Cabanillas <pedro.lopez.cabanillas@gmail.com>

snd_seq_parse_address() uses strncmp() to compare the client name in the string argument with the existing clients, until it finds one name matching the same leading characters. This may produce wrong results when there are two sequencer clients with similar names.
For instance, the following procedure produces a wrong result:

1. start KMidimon (http://kmidimon.sf.net)
$ kmidimon &
-->results: Client 128 : "KMidimon" [User]

2. start KMid (http://kmid2.sf.net)
$ kmid &
-->results: Client 129 : "KMid" [User]

3. try to subscribe the output port of KMid to KMidimon
$ aconnect KMid:0 KMidimon:0
--> results:
Client 128 : "KMidimon" [User]
  Port   0 : "KMidimon" (RWe-)
    Connecting To: 20:0, 128:0
    Connected From: 0:1, 128:0
128:0 becomes subscribed to itself. It should be subscribed from 129:0 instead.

Signed-off-by: Pedro Lopez-Cabanillas <pedro.lopez.cabanillas@gmail.com>
---
 src/seq/seqmid.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/seq/seqmid.c b/src/seq/seqmid.c
index 86a4970..894c3a2 100644
--- a/src/seq/seqmid.c
+++ b/src/seq/seqmid.c
@@ -414,7 +414,8 @@ int snd_seq_parse_address(snd_seq_t *seq, snd_seq_addr_t *addr, const char *arg)
 			return -EINVAL;
 		cinfo.client = -1;
 		while (snd_seq_query_next_client(seq, &cinfo) >= 0) {
-			if (! strncmp(arg, cinfo.name, len)) {
+			if ((strlen(cinfo.name) == len) &&
+				! strncmp(arg, cinfo.name, len)) {
 				addr->client = cinfo.client;
 				return 0;
 			}
-- 
1.6.4.2
