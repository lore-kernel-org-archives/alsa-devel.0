From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/10] ASoC: doc: ReSTize jack.txt
Date: Thu, 10 Nov 2016 22:47:21 +0100
Message-ID: <20161110214722.14698-10-tiwai@suse.de>
References: <20161110214722.14698-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CFB402673D0
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:47:26 +0100 (CET)
In-Reply-To: <20161110214722.14698-1-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

A simple conversion from a plain text file.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/soc/index.rst                       | 1 +
 Documentation/sound/{alsa/soc/jack.txt => soc/jack.rst} | 1 +
 2 files changed, 2 insertions(+)
 rename Documentation/sound/{alsa/soc/jack.txt => soc/jack.rst} (99%)

diff --git a/Documentation/sound/soc/index.rst b/Documentation/sound/soc/index.rst
index 0055abe16e7e..85ec51764e83 100644
--- a/Documentation/sound/soc/index.rst
+++ b/Documentation/sound/soc/index.rst
@@ -15,3 +15,4 @@ The documentation is spilt into the following sections:-
    machine
    pops-clicks
    clocking
+   jack
diff --git a/Documentation/sound/alsa/soc/jack.txt b/Documentation/sound/soc/jack.rst
similarity index 99%
rename from Documentation/sound/alsa/soc/jack.txt
rename to Documentation/sound/soc/jack.rst
index fcf82a417293..644b99ecba35 100644
--- a/Documentation/sound/alsa/soc/jack.txt
+++ b/Documentation/sound/soc/jack.rst
@@ -1,3 +1,4 @@
+===================
 ASoC jack detection
 ===================
 
-- 
2.10.2
