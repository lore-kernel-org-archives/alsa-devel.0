From: "John L. Utz III" <john.utz@dmx.com>
Subject: alsa git: which version of ac97_codec.c am i supposed
	to hxr?
Date: Fri, 15 Aug 2008 16:15:45 -0700
Message-ID: <op.ufyawjke647oa9@jutz-gnto64>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DA652473B
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Aug 2008 01:16:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello All;

I feel confused by the presence of 2 different copies of ac97_codec.c:

   jutz-gnto ~ # find . -name ac97_codec.c
     ./alsa-driver/pci/ac97/ac97_codec.c
     ./alsa-kmirror/pci/ac97/ac97_codec.c

worse yet,they are not in sync:

jutz-gnto ~ # diff -w ./alsa-driver/pci/ac97/ac97_codec.c  
./alsa-kmirror/pci/ac97/ac97_codec.c
1d0
< #include "adriver.h"
38c37
< #include "../../alsa-kernel/pci/ac97/ac97_id.h"
---
> #include "ac97_id.h"
40c39
< #include "../../alsa-kernel/pci/ac97/ac97_patch.c"
---
> #include "ac97_patch.c"
1917d1915
< #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
1929d1926
< #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 14)
1931d1927
< #endif
1953,1956d1948
< #else /* <= 2.6.0 */
< #define snd_ac97_dev_register NULL
< #define snd_ac97_dev_disconnect       NULL
< #endif


Which of these am i supposed to use? am i supposed to change both of them  
for some backward compatibility purpose?

tnx!

johnu
