From: Mikael Magnusson <mikma264@gmail.com>
Subject: [patch] jack plugin closes stdin if jack is unavailable
Date: Wed, 12 Apr 2006 00:07:08 +0200
Message-ID: <20060411220708.GA7959@skinner.hem.za.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

the jack plugin closes stdin if the pcm interfaces is opened but jack
isn't running. Initializing the file descriptors to -1 fixes the problem.

/Mikael

diff -u -u -r1.2 pcm_jack.c
--- pcm_jack.c  21 Mar 2006 11:51:23 -0000      1.2
+++ pcm_jack.c  11 Apr 2006 22:02:15 -0000
@@ -61,8 +61,10 @@
                                free(jack->port_names[i]);
                        free(jack->port_names);
                }
-               close(jack->fd);
-               close(jack->io.poll_fd);
+               if (jack->fd >= 0)
+                   close(jack->fd);
+               if (jack->io.poll_fd >= 0)
+                   close(jack->io.poll_fd);
                free(jack->areas);
                free(jack);
        }
@@ -321,6 +323,9 @@
        if (!jack)
                return -ENOMEM;

+       jack->fd = -1;
+       jack->io.poll_fd = -1;
+
        err = parse_ports(jack, stream == SND_PCM_STREAM_PLAYBACK ?
                          playback_conf : capture_conf);
        if (err) {



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
