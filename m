From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH] alsa-lib: Make sure SND_PCM_NO_xxx flags don't
	get lost	when nonblocking mode is enabled
Date: Sun, 31 Aug 2008 03:41:48 +0200
Message-ID: <20080831014148.GA21199@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 998431037F9
	for <alsa-devel@alsa-project.org>;
	Sun, 31 Aug 2008 03:41:50 +0200 (CEST)
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
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The plug PCM copies the 'mode' field from the slave PCM. If blocking mode is
enabled for the plug PCM the mode is subsequently overwritten with the original
requested 'mode'. If non-blocking mode is requested this does not happen.

Because the hw PCM synthesizes the 'mode' from the actual file descriptor flags
no SND_PCM_NO_xxx will ever be set for it. This has the effect that the 'mode'
of the plug PCM will also not include those flags anymore -- unless they are
overwritten as mentioned above. This basically means SND_PCM_NO_xxx is ignored
for plug:hw:4711 style device strings opened in non-blocking mode.

You can easily test this with "aplay --channels 7 --disable-channels -f S16_LE
-r 44100 -D plug:hw:0" on a device that cannot do 7 channels. Normally this
call should fail, however if you add "-N" to the command line this call will
succeed.

This patch simply copies the SND_PCM_NO_xxx flags back into the 'mode' field in
case we don't overwrite it with the original anyway.

Probably closes bug 3571 for good.

Lennart
---
 src/pcm/pcm_hw.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 1e1889c..c8d9a62 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -1507,7 +1507,13 @@ int _snd_pcm_hw_open(snd_pcm_t **pcmp, const char *name,
 		/* revert to blocking mode for read/write access */
 		snd_pcm_hw_nonblock(*pcmp, 0);
 		(*pcmp)->mode = mode;
-	}
+	} else
+		/* make sure the SND_PCM_NO_xxx flags don't get lost on the
+		 * way */
+		(*pcmp)->mode |= mode & (SND_PCM_NO_AUTO_RESAMPLE|
+					 SND_PCM_NO_AUTO_CHANNELS|
+					 SND_PCM_NO_AUTO_FORMAT|
+					 SND_PCM_NO_SOFTVOL);
 
 	hw = (*pcmp)->private_data;
 	if (format != SND_PCM_FORMAT_UNKNOWN)
-- 
1.6.0.1

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
