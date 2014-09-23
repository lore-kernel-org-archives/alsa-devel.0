From: Renu Tyagi <renu.tyagi@samsung.com>
Subject: Re: [PATCH v2 01/11] mixer : fixed double free
Date: Tue, 23 Sep 2014 04:13:02 +0000 (GMT)
Message-ID: <18078000.60941411445581943.JavaMail.weblogic@epv6ml10>
Reply-To: renu.tyagi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 51192261AA5
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 06:13:11 +0200 (CEST)
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NCC00KSM6DSGG50@mailout1.samsung.com> for
 alsa-devel@alsa-project.org; Tue, 23 Sep 2014 13:13:04 +0900 (KST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,
I will prefer "renu tyagi".
I cannot use git send-email from my organization. 
I will resubmit patches where I missed email id in signoff. Or you can see the attachments as they are fine.
If any other issues I will be happy to respond.
Thanks

--------------------------------------------
Signed-off-by: renu tyagi <renu.tyagi@samsung.com>
---
 src/mixer/mixer.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/src/mixer/mixer.c b/src/mixer/mixer.c
index 56e023d..eee9875 100644
--- a/src/mixer/mixer.c
+++ b/src/mixer/mixer.c
@@ -204,10 +204,8 @@ int snd_mixer_attach(snd_mixer_t *mixer, const char *name)
        if (err < 0)
                return err;
        err = snd_mixer_attach_hctl(mixer, hctl);
-       if (err < 0) {
-               snd_hctl_close(hctl);
+       if (err < 0)
                return err;
-       }
        return 0;
 }

--
1.7.1
