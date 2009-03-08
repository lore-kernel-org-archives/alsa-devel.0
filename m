From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] CS4270: comments: slave mode is
	now	supported
Date: Sun, 8 Mar 2009 17:51:52 +0100
Message-ID: <20090308165152.GA13309@buzzloop.caiaq.de>
References: <1236528963-11943-1-git-send-email-daniel@caiaq.de>
	<ed82fe3e0903080940n4af2a4ffide7d44bd15bb22c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 2EE901037F8
	for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2009 17:51:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ed82fe3e0903080940n4af2a4ffide7d44bd15bb22c8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Timur,

On Sun, Mar 08, 2009 at 11:40:30AM -0500, Timur Tabi wrote:
> On Sun, Mar 8, 2009 at 11:16 AM, Daniel Mack <daniel@caiaq.de> wrote:
> 
> > - * 3) Only Master mode is supported, not Slave.
> > - * 4) The machine driver's 'startup' function must call
> > + * 3) The machine driver's 'startup' function must call
> 
> I would have been simpler if you just said that both Master and Slave
> mode is supported. 

Right, I mistakenly read the whole list as limitations, but the headline
says 'features' as well.

> However, if you really want to delete #3, you may
> as well get rid of all the numbers, so that we don't have to renumber
> them again in the future.

Ok, that makes sense. What about the patch below?

Daniel


>From 5bf6359108726950c48f9f709eabc2c7e3a09eba Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Sun, 8 Mar 2009 17:48:12 +0100
Subject: [PATCH] CS4270: bring feature/limitations list in sync

Removes numbers from the list of features/limitations and makes it
reflect recent changes to the code.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/soc/codecs/cs4270.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 4c7e546..d16aa81 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -12,14 +12,13 @@
  *
  * Current features/limitations:
  *
- * 1) Software mode is supported.  Stand-alone mode is not supported.
- * 2) Only I2C is supported, not SPI
- * 3) Only Master mode is supported, not Slave.
- * 4) The machine driver's 'startup' function must call
- *    cs4270_set_dai_sysclk() with the value of MCLK.
- * 5) Only I2S and left-justified modes are supported
- * 6) Power management is not supported
- * 7) The only supported control is volume and hardware mute (if enabled)
+ * - Software mode is supported.  Stand-alone mode is not supported.
+ * - Only I2C is supported, not SPI
+ * - Support for master and slave mode
+ * - The machine driver's 'startup' function must call
+ *   cs4270_set_dai_sysclk() with the value of MCLK.
+ * - Only I2S and left-justified modes are supported
+ * - Power management is not supported
  */
 
 #include <linux/module.h>
-- 
1.6.1.3
