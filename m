From: Antonio Ospite <ao2@ao2.it>
Subject: [alsa-utils][PATCH 5/5] INSTALL: document how to
	configure a build for installation in a local dir
Date: Fri,  9 Dec 2016 14:02:32 +0100
Message-ID: <20161209130232.19457-6-ao2@ao2.it>
References: <20161209130232.19457-1-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp205.alice.it (smtp205.alice.it [82.57.200.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EE0F2677A5
 for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2016 14:02:58 +0100 (CET)
In-Reply-To: <20161209130232.19457-1-ao2@ao2.it>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Antonio Ospite <ao2@ao2.it>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 INSTALL | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/INSTALL b/INSTALL
index 544d5d2..d95bb97 100644
--- a/INSTALL
+++ b/INSTALL
@@ -42,5 +42,12 @@ For compilation you can use these commands:
 
 The included gitcompile script does this job for you.
 
+To configure the build to install in a local directory, a command like the
+following can be used:
+
+	./gitcompile --prefix="$PWD/build" \
+	  --with-systemdsystemunitdir="$PWD/build/$(pkg-config systemd --variable=systemdsystemunitdir)" \
+	  --with-udev-rules-dir="$PWD/build/$(pkg-config udev --variable=udevdir)"
+
 Note: Some automake packages have missing aclocal program. Use newer version
       in the case.
-- 
2.11.0
