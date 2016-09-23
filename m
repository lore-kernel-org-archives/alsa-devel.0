From: Antonio Ospite <ao2@ao2.it>
Subject: [alsa-lib][PATCH] ucm: fix crash when calling
	snd_use_case_geti() with no device or modifier
Date: Fri, 23 Sep 2016 18:11:16 +0200
Message-ID: <20160923161116.26359-1-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp205.alice.it (smtp205.alice.it [82.57.200.101])
 by alsa0.perex.cz (Postfix) with ESMTP id A16D62665D9
 for <alsa-devel@alsa-project.org>; Fri, 23 Sep 2016 18:11:31 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Antonio Ospite <ao2@ao2.it>
List-Id: alsa-devel@alsa-project.org

When calling snd_use_case_geti(uc_mgr, "_devstatus", &lvalue) the code
ends up calling device_status(uc_mgr, NULL), which result in a crash in
strcmp(dev->name, NULL), when there are enabled devices.

This happens because snd_use_case_geti() allows a "_devstatus"
identifier even if it's only supposed to allow the form
"_devstatus/{device}".

So check that the device name is not null.

The same issue occurs with "_modstatus", this change fixes that as well.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---

Hi,

the bug can be reproduced with a command like this:

  # alsaucm -n -b - <<EOM
  open bytcr-rt5640
  reset
  set _verb HiFi
  set _device Speaker
  geti _devstatus
  EOM
  Segmentation fault

I decided to add the check once per command instead of doing this:

  @@ -1525,7 +1525,8 @@ int snd_use_case_geti(snd_use_case_mgr_t *uc_mgr,
                                  goto __end;
                           }
                   } else {
  -                       str = NULL;
  +                       err = -EINVAL;
  +                       goto __end;
                   }

because the function body seems to be prepared to accept other forms of
identifiers, possibly even without a "prefix/suffix" structure.

Ciao ciao,
   Antonio

P.S. the source code in src/ucm has a mixed indentation style of TABs and
spaces, would you accept a patch to uniform the style?

 src/ucm/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 24d9510..d5e418e 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -1528,12 +1528,20 @@ int snd_use_case_geti(snd_use_case_mgr_t *uc_mgr,
                         str = NULL;
                 }
                 if (check_identifier(identifier, "_devstatus")) {
+			if(!str) {
+				err = -EINVAL;
+				goto __end;
+			}
                         err = device_status(uc_mgr, str);
 			if (err >= 0) {
 				*value = err;
 				err = 0;
 			}
 		} else if (check_identifier(identifier, "_modstatus")) {
+			if(!str) {
+				err = -EINVAL;
+				goto __end;
+			}
                         err = modifier_status(uc_mgr, str);
 			if (err >= 0) {
 				*value = err;
-- 
2.9.3
