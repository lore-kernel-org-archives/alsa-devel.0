From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH] alsa-lib: Don't call the simple mixer
	interface "legacy"
Date: Sun, 31 Aug 2008 03:42:56 +0200
Message-ID: <20080831014256.GA21253@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B0111037FC
	for <alsa-devel@alsa-project.org>;
	Sun, 31 Aug 2008 03:42:57 +0200 (CEST)
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

The simpler mixer interface is not legacy, so the header file shouldn't claim
otherwise.

Fixes bug 3569

Lennart

---
 include/mixer.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/mixer.h b/include/mixer.h
index 59deb9f..df92164 100644
--- a/include/mixer.h
+++ b/include/mixer.h
@@ -88,7 +88,7 @@ typedef int (*snd_mixer_event_t)(snd_mixer_class_t *class_, unsigned int mask,
 
 /** Mixer element type */
 typedef enum _snd_mixer_elem_type {
-	/* Simple (legacy) mixer elements */
+	/* Simple mixer elements */
 	SND_MIXER_ELEM_SIMPLE,
 	SND_MIXER_ELEM_LAST = SND_MIXER_ELEM_SIMPLE
 } snd_mixer_elem_type_t;
@@ -166,7 +166,7 @@ int snd_mixer_class_set_compare(snd_mixer_class_t *class_, snd_mixer_compare_t c
  *  \{
  */
 
-/* Simple (legacy) mixer elements API */
+/* Simple mixer elements API */
 
 /** Mixer simple element channel identifier */
 typedef enum _snd_mixer_selem_channel_id {
-- 
1.6.0.1

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
