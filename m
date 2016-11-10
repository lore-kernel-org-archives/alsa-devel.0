From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 23/30] ALSA: doc: ReSTize VIA82xx-mixer.txt
Date: Thu, 10 Nov 2016 22:06:34 +0100
Message-ID: <20161110210641.5907-24-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DD86D2673CF
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:56 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D2806ADF7
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 21:06:53 +0000 (UTC)
In-Reply-To: <20161110210641.5907-1-tiwai@suse.de>
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

Another simple conversion from a plain text file.
Put to cards directory.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa/VIA82xx-mixer.txt  | 8 --------
 Documentation/sound/cards/index.rst         | 1 +
 Documentation/sound/cards/via82xx-mixer.rst | 8 ++++++++
 3 files changed, 9 insertions(+), 8 deletions(-)
 delete mode 100644 Documentation/sound/alsa/VIA82xx-mixer.txt
 create mode 100644 Documentation/sound/cards/via82xx-mixer.rst

diff --git a/Documentation/sound/alsa/VIA82xx-mixer.txt b/Documentation/sound/alsa/VIA82xx-mixer.txt
deleted file mode 100644
index 1b0ac06ba95d..000000000000
--- a/Documentation/sound/alsa/VIA82xx-mixer.txt
+++ /dev/null
@@ -1,8 +0,0 @@
-
-				VIA82xx mixer
-				=============
-
-On many VIA82xx boards, the 'Input Source Select' mixer control does not work.
-Setting it to 'Input2' on such boards will cause recording to hang, or fail
-with EIO (input/output error) via OSS emulation.  This control should be left
-at 'Input1' for such cards.
diff --git a/Documentation/sound/cards/index.rst b/Documentation/sound/cards/index.rst
index 251f1d7675f7..4fcb88049ccc 100644
--- a/Documentation/sound/cards/index.rst
+++ b/Documentation/sound/cards/index.rst
@@ -9,3 +9,4 @@ Card-Specific Information
    sb-live-mixer
    audigy-mixer
    emu10k1-jack
+   via82xx-mixer
diff --git a/Documentation/sound/cards/via82xx-mixer.rst b/Documentation/sound/cards/via82xx-mixer.rst
new file mode 100644
index 000000000000..6ee993d4535b
--- /dev/null
+++ b/Documentation/sound/cards/via82xx-mixer.rst
@@ -0,0 +1,8 @@
+=============
+VIA82xx mixer
+=============
+
+On many VIA82xx boards, the ``Input Source Select`` mixer control does not work.
+Setting it to ``Input2`` on such boards will cause recording to hang, or fail
+with EIO (input/output error) via OSS emulation.  This control should be left
+at ``Input1`` for such cards.
-- 
2.10.2
