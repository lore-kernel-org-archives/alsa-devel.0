From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/2] alsa-lib: pcm.c: fix indentation
Date: Thu, 28 Mar 2013 00:32:23 +0100
Message-ID: <1364427144-30036-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id D842F26531B
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2013 00:32:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: jussi@sonarnerd.net, tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 src/pcm/pcm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 05737d9..2963711 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -1634,11 +1634,11 @@ static const char *const snd_pcm_type_names[] = {
 	PCMTYPE(LADSPA), 
 	PCMTYPE(DMIX), 
 	PCMTYPE(JACK),
-        PCMTYPE(DSNOOP),
-        PCMTYPE(IEC958),
+	PCMTYPE(DSNOOP),
+	PCMTYPE(IEC958),
 	PCMTYPE(SOFTVOL),
-        PCMTYPE(IOPLUG),
-        PCMTYPE(EXTPLUG),
+	PCMTYPE(IOPLUG),
+	PCMTYPE(EXTPLUG),
 	PCMTYPE(MMAP_EMUL),
 };
 
-- 
1.8.1.4
