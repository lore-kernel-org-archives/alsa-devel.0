From: Fons Adriaensen <fons@linuxaudio.org>
Subject: patch for jack plugin
Date: Thu, 29 Dec 2011 16:12:04 +0000
Message-ID: <20111229161204.GB22822@linuxaudio.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lists.linuxaudio.org (bukvic.music.vt.edu [198.82.152.114])
	by alsa0.perex.cz (Postfix) with ESMTP id EE434103A1E
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 17:12:06 +0100 (CET)
Content-Disposition: inline
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

The following patch will make snd_pcm_poll_descriptors_revents()
return the correct value when used on a jack plugin device.
The current version returns POLLIN regardless of capture or
playback.


--- pcm_jack_orig.c     2011-12-29 16:42:07.000000000 +0100
+++ pcm_jack.c  2011-12-29 16:51:18.000000000 +0100
@@ -77,17 +77,18 @@
        return 0;
 }
 
-static int snd_pcm_jack_poll_revents(snd_pcm_ioplug_t *io ATTRIBUTE_UNUSED,
+static int snd_pcm_jack_poll_revents(snd_pcm_ioplug_t *io,
                                     struct pollfd *pfds, unsigned int nfds,
                                     unsigned short *revents)
 {
        static char buf[1];
 
        assert(pfds && nfds == 1 && revents);
-
        read(pfds[0].fd, buf, 1);
-
-       *revents = pfds[0].revents;
+       *revents = pfds[0].revents & ~(POLLIN | POLLOUT);
+        if (pfds[0].revents & POLLIN) {
+           *revents |= (io->stream == SND_PCM_STREAM_PLAYBACK) ? POLLOUT : POLLIN;
+       }
        return 0;
 }
 


Ciao,


-- 
FA

Vor uns liegt ein weites Tal, die Sonne scheint - ein Glitzerstrahl.
