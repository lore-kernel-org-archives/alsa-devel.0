From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 3/3 v2]sound/pci/intel8x0.c Update broken web
	addresses.
Date: Mon, 13 Sep 2010 13:17:03 -0700
Message-ID: <1284409023-4419-3-git-send-email-justinmattock@gmail.com>
References: <1284409023-4419-1-git-send-email-justinmattock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D36510385B
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Sep 2010 22:16:37 +0200 (CEST)
Received: by mail-pw0-f51.google.com with SMTP id 4so2372820pwi.38
	for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2010 13:16:37 -0700 (PDT)
In-Reply-To: <1284409023-4419-1-git-send-email-justinmattock@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: trivial@kernel.org
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, linux-kernel@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>
List-Id: alsa-devel@alsa-project.org

This is a resend from the original, due to Clemens Ladisch providing
the right locations of the *.pdf's etc..

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/pci/intel8x0.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 4677492..400f9eb 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -716,7 +716,7 @@ static void snd_intel8x0_setup_periods(struct intel8x0 *chip, struct ichdev *ich
  * Intel 82443MX running a 100MHz processor system bus has a hardware bug,
  * which aborts PCI busmaster for audio transfer.  A workaround is to set
  * the pages as non-cached.  For details, see the errata in
- *	http://www.intel.com/design/chipsets/specupdt/245051.htm
+ *	http://download.intel.com/design/chipsets/specupdt/24505108.pdf
  */
 static void fill_nocache(void *buf, int size, int nocache)
 {
-- 
1.7.2.1
