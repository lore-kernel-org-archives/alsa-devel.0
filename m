From: Renu Tyagi <renu.tyagi@samsung.com>
Subject: Re: [PATCH v2 03/11] sbase : fixed missing free
Date: Tue, 23 Sep 2014 04:20:34 +0000 (GMT)
Message-ID: <22469549.61261411446034864.JavaMail.weblogic@epv6ml10>
Reply-To: renu.tyagi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 57D08261B35
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 06:20:37 +0200 (CEST)
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NCC00KHR6QBGG60@mailout1.samsung.com> for
 alsa-devel@alsa-project.org; Tue, 23 Sep 2014 13:20:35 +0900 (KST)
MIME-version: 1.0
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: renu tyagi <renu.tyagi@samsung.com>
---
 modules/mixer/simple/sbase.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/modules/mixer/simple/sbase.c b/modules/mixer/simple/sbase.c
index 97feee8..bb2f59d 100644
--- a/modules/mixer/simple/sbase.c
+++ b/modules/mixer/simple/sbase.c
@@ -377,6 +377,7 @@ static int simple_event_add1(snd_mixer_class_t *class,
                if (ctype != SND_CTL_ELEM_TYPE_BOOLEAN) {
                      __invalid_type:
                        snd_mixer_selem_id_free(id);
+                       free(hsimple);
                        return -EINVAL;
                }
                break;
--
1.7.1
