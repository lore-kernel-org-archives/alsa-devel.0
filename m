From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/1] jack: Fix hanging applications when using
	jack plugin
Date: Thu,  4 Aug 2011 16:19:56 +0200
Message-ID: <1312467596-3163-1-git-send-email-adi@drcomp.erfurt.thur.de>
References: <4E3A2FB4.5000502@familyross.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4E3A2FB4.5000502@familyross.net>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As described in issue #2727

   https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2727

applications hang after some seconds when using the jack plugin.

Kevin Ross <kevin@familyross.net> writes:

   The cause: The plugin creates a pipe, so that the fd's could be
   polled to indicate completion of a transfer.  However, the call to
   write() blocks when playing audio, as nothing actually reads from the
   pipe, and it fills up until it blocks.

   Making the socket non-blocking fixes the problem, and testing with
   playback and capture both work properly for me now.

I've also tested Kevin's patch and confirm it works.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 3370a26..a3833c5 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -307,6 +307,18 @@ static int parse_ports(snd_pcm_jack_t *jack, snd_config_t *conf)
 	return 0;
 }
 
+static int make_nonblock(int fd) {
+	int fl;
+
+	if ((fl = fcntl(fd, F_GETFL)) < 0)
+		return fl;
+
+	if (fl & O_NONBLOCK)
+		return 0;
+
+	return fcntl(fd, F_SETFL, fl | O_NONBLOCK);
+}
+
 static int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
 			     snd_config_t *playback_conf,
 			     snd_config_t *capture_conf,
@@ -363,6 +375,9 @@ static int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
 
 	socketpair(AF_LOCAL, SOCK_STREAM, 0, fd);
 	
+	make_nonblock(fd[0]);
+	make_nonblock(fd[1]);
+	
 	jack->fd = fd[0];
 
 	jack->io.version = SND_PCM_IOPLUG_VERSION;
-- 
1.7.5.4
