From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: [RFC][PATCH] Coding style fix
	sound/pci/ca0106/ca_midi.h
Date: Wed, 01 Aug 2007 16:45:34 +0200
Message-ID: <46B09C8E.3010103@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 2031E10381D
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Aug 2007 16:46:04 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so55198nfd
	for <alsa-devel@alsa-project.org>; Wed, 01 Aug 2007 07:46:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrew Morton <akpm@linux-foundation.org>, Tilman Kranz <tilde@tk-sls.de>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Coding style fix

Regards,
Michal

--
LOG
http://www.stardust.webpages.pl/log/

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

--- linux-mm-clean/sound/pci/ca0106/ca_midi.h	2007-07-09 01:32:17.000000000 +0200
+++ linux-mm/sound/pci/ca0106/ca_midi.h	2007-08-01 16:38:54.000000000 +0200
@@ -22,9 +22,9 @@
  *
  */
 
-#include<linux/spinlock.h>
-#include<sound/rawmidi.h>
-#include<sound/mpu401.h>
+#include <linux/spinlock.h>
+#include <sound/rawmidi.h>
+#include <sound/mpu401.h>
 
 #define CA_MIDI_MODE_INPUT	MPU401_MODE_INPUT
 #define CA_MIDI_MODE_OUTPUT	MPU401_MODE_OUTPUT
