From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] aconnect: remove group option
Date: Wed, 17 Jul 2002 11:16:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3535F8.26AC4853@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


- removed last remains of --group option
- made error handling consistent


Clemens
-- 

diff -udPr alsa-utils.org/seq/aconnect/aconnect.1 alsa-utils/seq/aconnect/aconnect.1
--- alsa-utils.org/seq/aconnect/aconnect.1	Fri Jul 12 22:16:22 2002
+++ alsa-utils/seq/aconnect/aconnect.1	Fri Jul 12 22:29:03 2002
@@ -55,15 +55,15 @@
 .IP "" 4
 % aconnect -i
 .br
-client 0: 'System' [group=system] [type=kernel]
+client 0: 'System' [type=kernel]
 .in +4
-0 'Timer           ' [group=system]
+0 'Timer           '
 .br
-1 'Announce        ' [group=system]
+1 'Announce        '
 .in -4
-client 64: 'External MIDI-0' [group=] [type=kernel]
+client 64: 'External MIDI-0' [type=kernel]
 .in +4
-0 'MIDI 0-0        ' [group=device]
+0 'MIDI 0-0        '
 .in -4
 .PP
 Similary, to see the output ports, use
@@ -100,16 +100,6 @@
 time-stamps are converted to the current value of the given
 .I tick
 queue.
-.TP
-.B \-g, --group name
-Specify the group name that
-.B aconnect
-uses.
-Some ports may have special permissions, so that only the same group
-may subscribe to them.  In such a case,
-.B aconnect
-can fake the group name
-with this option.
 
 .SS LIST PORTS
 .TP
diff -udPr alsa-utils.org/seq/aconnect/aconnect.c alsa-utils/seq/aconnect/aconnect.c
--- alsa-utils.org/seq/aconnect/aconnect.c	Fri Jul 12 22:16:22 2002
+++ alsa-utils/seq/aconnect/aconnect.c	Fri Jul 12 22:31:38 2002
@@ -255,7 +255,6 @@
 	{"disconnect", 0, NULL, 'd'},
 	{"input", 0, NULL, 'i'},
 	{"output", 0, NULL, 'o'},
-	{"group", 1, NULL, 'g'},
 	{"real", 1, NULL, 'r'},
 	{"tick", 1, NULL, 't'},
 	{"exclusive", 0, NULL, 'e'},
@@ -276,7 +275,7 @@
 	snd_seq_port_subscribe_t *subs;
 	snd_seq_addr_t sender, dest;
 
-	while ((c = getopt_long(argc, argv, "diog:r:t:elx", long_option, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "dior:t:elx", long_option, NULL)) != -1) {
 		switch (c) {
 		case 'd':
 			command = UNSUBSCRIBE;
@@ -351,15 +350,17 @@
 	if (snd_seq_set_client_name(seq, "ALSA Connector") < 0) {
 		snd_seq_close(seq);
 		fprintf(stderr, "can't set client info\n");
-		return 0;
+		return 1;
 	}
 
 	/* set subscription */
 	if (snd_seq_parse_address(seq, &sender, argv[optind]) < 0) {
+		snd_seq_close(seq);
 		fprintf(stderr, "invalid sender address %s\n", argv[optind]);
 		return 1;
 	}
 	if (snd_seq_parse_address(seq, &dest, argv[optind + 1]) < 0) {
+		snd_seq_close(seq);
 		fprintf(stderr, "invalid destination address %s\n", argv[optind + 1]);
 		return 1;
 	}


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
