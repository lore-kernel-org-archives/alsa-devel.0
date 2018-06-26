From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4/4] alsa: Fix references to
	Documentation/.*/MultiSound
Date: Tue, 26 Jun 2018 06:24:40 -0300
Message-ID: <167fc9011e09d3db32e21a03a6a0edb4c949e963.1530004939.git.mchehab+samsung@kernel.org>
References: <cover.1530004939.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from osg.samsung.com (osg.samsung.com [64.30.133.232])
 by alsa0.perex.cz (Postfix) with ESMTP id CE45526784B
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 11:24:47 +0200 (CEST)
In-Reply-To: <cover.1530004939.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1530004939.git.mchehab+samsung@kernel.org>
References: <cover.1530004939.git.mchehab+samsung@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>
List-Id: alsa-devel@alsa-project.org

Now that the documentation/script file got restored, fix the
references within the Kernel tree.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sound/alsa-configuration.rst | 2 +-
 sound/isa/Kconfig                          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
index 4d83c1c0ca04..4a3cecc8ad38 100644
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -1568,7 +1568,7 @@ joystick_io
 The driver requires firmware files ``turtlebeach/msndinit.bin`` and
 ``turtlebeach/msndperm.bin`` in the proper firmware directory.
 
-See Documentation/sound/oss/MultiSound for important information
+See Documentation/sound/cards/multisound.sh for important information
 about this driver.  Note that it has been discontinued, but the 
 Voyetra Turtle Beach knowledge base entry for it is still available
 at
diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index 43b35a873d78..d7db1eeebc84 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -459,7 +459,7 @@ config SND_MSND_CLASSIC
 	  Say M here if you have a Turtle Beach MultiSound Classic, Tahiti or
 	  Monterey (not for the Pinnacle or Fiji).
 
-	  See <file:Documentation/sound/oss/MultiSound> for important information
+	  See <file:Documentation/sound/cards/multisound.sh> for important information
 	  about this driver.  Note that it has been discontinued, but the
 	  Voyetra Turtle Beach knowledge base entry for it is still available
 	  at <http://www.turtlebeach.com/site/kb_ftp/790.asp>.
-- 
2.17.1
