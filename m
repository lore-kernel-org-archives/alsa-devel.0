From: sutar.mounesh@gmail.com
Subject: [PATCH] alsa-lib: Add htimestamp operation in plugin
	file
Date: Fri, 25 Nov 2016 17:06:37 +0530
Message-ID: <1480073797-17667-1-git-send-email-sutar.mounesh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: alsa-devel@alsa-project.org, Joshua Frkuska <joshua_frkuska@mentor.com>, Andreas Pape <apape@de.adit-jv.com>, mounesh_sutar@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Andreas Pape <apape@de.adit-jv.com>

PCM operation htimestamp is not implemented in plugin file.
Calling snd_pcm_htimestamp() on a plugin file crashes. This scenario
is considered now.

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
Signed-off-by: Joshua Frkuska <joshua_frkuska@mentor.com>
---

--- a/src/pcm/pcm_file.c	2013-07-08 14:31:36.000000000 +0200
+++ b/src/pcm/pcm_file.c	2015-05-04 16:26:10.413615403 +0200
@@ -698,6 +698,7 @@
 	.readi = snd_pcm_file_readi,
 	.readn = snd_pcm_file_readn,
 	.avail_update = snd_pcm_generic_avail_update,
+	.htimestamp = snd_pcm_generic_htimestamp,
 	.mmap_commit = snd_pcm_file_mmap_commit,
 	.poll_descriptors_count = snd_pcm_generic_poll_descriptors_count,
 	.poll_descriptors = snd_pcm_generic_poll_descriptors,
