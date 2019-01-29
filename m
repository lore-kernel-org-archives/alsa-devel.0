From: pmalani@chromium.org
Subject: [PATCH 1/1] seq: arecordmidi: Add num-events option
Date: Mon, 28 Jan 2019 17:44:45 -0800
Message-ID: <5c4fb010.1c69fb81.94ca0.01ae@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by alsa0.perex.cz (Postfix) with ESMTP id C701F267467
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 02:44:50 +0100 (CET)
Received: by mail-pg1-f195.google.com with SMTP id s198so8044307pgs.2
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 17:44:50 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Prashant Malani <pmalani@chromium.org>, alsa-devel@alsa-project.org, derat@chromium.org
List-Id: alsa-devel@alsa-project.org

From: Prashant Malani <pmalani@chromium.org>

Add a command line option to automatically exit after recording a fixed
number of MIDI events. This allows a program using arecordmidi to expect
a MIDI file to be written automatically when the specified number of
events have been received, instead of having to send a SIGINT or SIGTERM
programmatically.

It also avoids the need to have the arecordmidi process running in the
background, and then constantly stat the output file to check if any
bytes have been written to it (this makes for less predictable and
longer-running tests).

This functionality finds use in Chrome OS functional testing, since
having to send SIGTERM/SIGINT programmatically and then wait for the
output file adds unpredictability and delay to the tests.

The addition of this command-line option should (hopefully) not break
any existing usage.

Signed-off-by: Prashant Malani <pmalani@chromium.org>

diff --git a/seq/aplaymidi/arecordmidi.c b/seq/aplaymidi/arecordmidi.c
index 19dbb7d..ca25bfa 100644
--- a/seq/aplaymidi/arecordmidi.c
+++ b/seq/aplaymidi/arecordmidi.c
@@ -690,7 +690,8 @@ static void help(const char *argv0)
 		"  -t,--ticks=ticks           resolution in ticks per beat or frame\n"
 		"  -s,--split-channels        create a track for each channel\n"
 		"  -m,--metronome=client:port play a metronome signal\n"
-		"  -i,--timesig=nn:dd         time signature\n",
+		"  -i,--timesig=nn:dd         time signature\n"
+		"  -n,--num-events=events     fixed number of events to record, then exit\n",
 		argv0);
 }
 
@@ -706,7 +707,7 @@ static void sighandler(int sig)
 
 int main(int argc, char *argv[])
 {
-	static const char short_options[] = "hVlp:b:f:t:sdm:i:";
+	static const char short_options[] = "hVlp:b:f:t:sdm:i:n:";
 	static const struct option long_options[] = {
 		{"help", 0, NULL, 'h'},
 		{"version", 0, NULL, 'V'},
@@ -719,6 +720,7 @@ int main(int argc, char *argv[])
 		{"dump", 0, NULL, 'd'},
 		{"metronome", 1, NULL, 'm'},
 		{"timesig", 1, NULL, 'i'},
+		{"num-events", 1, NULL, 'n'},
 		{ }
 	};
 
@@ -727,6 +729,9 @@ int main(int argc, char *argv[])
 	struct pollfd *pfds;
 	int npfds;
 	int c, err;
+	/* If |num_events| isn't specified, leave it at 0. */
+	int num_events = 0;
+	int events_received = 0;
 
 	init_seq();
 
@@ -775,6 +780,11 @@ int main(int argc, char *argv[])
 		case 'i':
 			time_signature(optarg);
 			break;
+		case 'n':
+			num_events = atoi(optarg);
+			if (num_events <= 0)
+				fatal("num_events must be greater than 0");
+			break;
 		default:
 			help(argv[0]);
 			return 1;
@@ -864,13 +874,20 @@ int main(int argc, char *argv[])
 			err = snd_seq_event_input(seq, &event);
 			if (err < 0)
 				break;
-			if (event)
+			if (event) {
 				record_event(event);
+				events_received++;
+			}
 		} while (err > 0);
 		if (stop)
 			break;
+		if (num_events && (events_received == num_events))
+			break;
 	}
 
+	if (num_events && events_received < num_events)
+		fputs("Warning: Received signal before num_events\n", stdout);
+
 	finish_tracks();
 	write_file();
 
-- 
2.20.1.495.gaa96b0ce6b-goog
