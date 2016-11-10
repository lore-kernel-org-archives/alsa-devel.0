From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 17/30] ALSA: doc: ReSTize Jack-Controls.txt
Date: Thu, 10 Nov 2016 22:06:28 +0100
Message-ID: <20161110210641.5907-18-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 91C612673C8
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:56 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C4879ADF2
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

A simple conversion from a plain text file.
Put to designs subdirectory.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/designs/index.rst                       |  1 +
 .../{alsa/Jack-Controls.txt => designs/jack-controls.rst}   | 13 +++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)
 rename Documentation/sound/{alsa/Jack-Controls.txt => designs/jack-controls.rst} (86%)

diff --git a/Documentation/sound/designs/index.rst b/Documentation/sound/designs/index.rst
index 798b1a44bbbd..04dcdae3e4f2 100644
--- a/Documentation/sound/designs/index.rst
+++ b/Documentation/sound/designs/index.rst
@@ -8,6 +8,7 @@ Designs and Implementations
    channel-mapping-api
    compress-offload
    timestamping
+   jack-controls
    procfile
    powersave
    oss-emulation
diff --git a/Documentation/sound/alsa/Jack-Controls.txt b/Documentation/sound/designs/jack-controls.rst
similarity index 86%
rename from Documentation/sound/alsa/Jack-Controls.txt
rename to Documentation/sound/designs/jack-controls.rst
index fe1c5e0c8555..ae25b1531bb0 100644
--- a/Documentation/sound/alsa/Jack-Controls.txt
+++ b/Documentation/sound/designs/jack-controls.rst
@@ -1,3 +1,7 @@
+==================
+ALSA Jack Controls
+==================
+
 Why we need Jack kcontrols
 ==========================
 
@@ -29,11 +33,12 @@ How to use jack kcontrols
 =========================
 
 In order to keep compatibility, snd_jack_new() has been modified by
-adding two params :-
+adding two params:
 
- - @initial_kctl: if true, create a kcontrol and add it to the jack
-	list.
- - @phantom_jack: Don't create a input device for phantom jacks.
+initial_kctl
+  if true, create a kcontrol and add it to the jack list.
+phantom_jack
+  Don't create a input device for phantom jacks.
 
 HDA jacks can set phantom_jack to true in order to create a phantom
 jack and set initial_kctl to true to create an initial kcontrol with
-- 
2.10.2
