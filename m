From: Cedric Roux <sed@free.fr>
Subject: [PATCH] Emit an error message when dlopen fails.
Date: Tue, 21 Nov 2017 23:12:58 +0100
Message-ID: <5471e331-1e5b-3bf6-6128-469e39d049cd@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 28ABB266F52
 for <alsa-devel@alsa-project.org>; Tue, 21 Nov 2017 23:10:09 +0100 (CET)
Received: from [IPv6:2a01:cb1d:1a3:2a00:dacb:8aff:fef1:ed46] (unknown
 [IPv6:2a01:cb1d:1a3:2a00:dacb:8aff:fef1:ed46])
 (Authenticated sender: sed)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 453402003BF
 for <alsa-devel@alsa-project.org>; Tue, 21 Nov 2017 23:10:08 +0100 (CET)
Content-Language: en-US
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
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Cedric Roux <sed@free.fr>
---
 src/dlmisc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git src/dlmisc.c src/dlmisc.c
index f154ebd0..9e8e401e 100644
--- src/dlmisc.c
+++ src/dlmisc.c
@@ -81,10 +81,14 @@ void *snd_dlopen(const char *name, int mode)
 		strcat(filename, "/");
 		strcat(filename, name);
 		handle = dlopen(filename, mode);
+		if (!handle)
+			SNDERR("snd_dlopen: %s: %s", filename, dlerror());
 		free(filename);
 	}
 	if (!handle)
 		handle = dlopen(name, mode);
+	if (!handle)
+		SNDERR("snd_dlopen: %s: %s", name, dlerror());
 	return handle;
 #else
 	return NULL;
-- 
2.15.0
