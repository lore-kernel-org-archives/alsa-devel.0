From: Renu Tyagi <renu.tyagi@samsung.com>
Subject: Re: [PATCH v2 04/11] rawmidi : close handle h
Date: Tue, 23 Sep 2014 04:22:07 +0000 (GMT)
Message-ID: <18246145.61351411446127682.JavaMail.weblogic@epv6ml10>
Reply-To: renu.tyagi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 884BB262632
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 06:22:23 +0200 (CEST)
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NCC00EGR6TAKCE0@mailout3.samsung.com> for
 alsa-devel@alsa-project.org; Tue, 23 Sep 2014 13:22:22 +0900 (KST)
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
 src/rawmidi/rawmidi.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/src/rawmidi/rawmidi.c b/src/rawmidi/rawmidi.c
index b835b47..ac699b4 100644
--- a/src/rawmidi/rawmidi.c
+++ b/src/rawmidi/rawmidi.c
@@ -256,8 +256,11 @@ static int snd_rawmidi_open_conf(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp
                snd_config_delete(type_conf);
        if (err >= 0)
                err = open_func(inputp, outputp, name, rawmidi_root, rawmidi_conf, mode);
-       if (err < 0)
+       if (err < 0) {
+               if (h)
+                       snd_dlclose(h);
                return err;
+       }
        if (inputp) {
                (*inputp)->dl_handle = h; h = NULL;
                snd_rawmidi_params_default(*inputp, &params);
--
1.7.1
