From: Kevin Ross <kevin@familyross.net>
Subject: [PATCH] Fix Jack plugin
Date: Wed, 03 Aug 2011 22:35:48 -0700
Message-ID: <4E3A2FB4.5000502@familyross.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.familyross.net (mail.familyross.net [50.16.244.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 517661037EE
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 07:35:52 +0200 (CEST)
Received: from [192.168.1.5] (50-46-133-129.evrt.wa.frontiernet.net
	[50.46.133.129]) (Authenticated sender: kevin)
	by mail.familyross.net (Postfix) with ESMTPSA id A5C1D14C32
	for <alsa-devel@alsa-project.org>; Wed,  3 Aug 2011 22:26:27 -0700 (PDT)
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

I've uploaded a patch to ticket 2727, at 
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2727

My background:  I'm a software developer, but I know nothing about ALSA 
development.  But I use Jack, and needed to get the Jack plugin 
working.  Since no one has touched the plugin in years, I figured I'd 
take a stab at fixing it myself.

The symptom:  Using the Jack plugin causes whatever program is 
outputting audio to hang after about 10-20 seconds.

The cause: The plugin creates a pipe, so that the fd's could be polled 
to indicate completion of a transfer.  However, the call to write() 
blocks when playing audio, as nothing actually reads from the pipe, and 
it fills up until it blocks.

The solution:  This is where my inexperience with ALSA shows up.  I 
don't know the best way to fix it.  Making the socket non-blocking fixes 
the problem, and testing with playback and capture both work properly 
for me now.  However, comparing the code with that of pcm-pulse.c (for 
piping ALSA output to PulseAudio), it's obvious that the Jack plugin was 
a hack.  It could use more work.  However, my fix at least gets me running.

The patch:

--- alsa-plugins-1.0.23/jack/pcm_jack.c 2010-04-16 04:11:10.000000000 -0700
+++ alsa-plugins-1.0.23.new/jack/pcm_jack.c     2011-08-03 
21:54:51.795378947 -0700
@@ -307,6 +308,18 @@
         return 0;
  }

+static int make_nonblock(int fd) {
+       int fl;
+
+       if ((fl = fcntl(fd, F_GETFL)) < 0)
+               return fl;
+
+       if (fl & O_NONBLOCK)
+               return 0;
+
+       return fcntl(fd, F_SETFL, fl | O_NONBLOCK);
+}
+
  static int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
                              snd_config_t *playback_conf,
                              snd_config_t *capture_conf,
@@ -363,6 +376,9 @@

         socketpair(AF_LOCAL, SOCK_STREAM, 0, fd);

+       make_nonblock(fd[0]);
+       make_nonblock(fd[1]);
+
         jack->fd = fd[0];

         jack->io.version = SND_PCM_IOPLUG_VERSION;
