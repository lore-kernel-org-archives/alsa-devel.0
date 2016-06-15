From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Subject: [PATCH] ALSA: seq_oss: Change structure initialisation
	to C99 style
Date: Wed, 15 Jun 2016 13:33:31 +0530
Message-ID: <20160615080331.GA17884@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 232C82608B3
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 10:03:36 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id 62so1237201pfd.3
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 01:03:36 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr, michael.leibowitz@intel.com, keescook@chromium.org
List-Id: alsa-devel@alsa-project.org

Replace the in order struct initialisation style with explicit field
style.

The Coccinelle semantic patch used to make this change is as follows:

@decl@
identifier i1,fld;
type T;
field list[n] fs;
@@

struct i1 {
 fs
 T fld;
 ...};

@@
identifier decl.i1,i2,decl.fld;
expression e;
position bad.p, bad.fix;
@@

struct i1 i2@p = { ...,
+ .fld = e
- e@fix
 ,...};

Also, removed some unnecessary comments.

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 sound/core/seq/oss/seq_oss_synth.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_synth.c b/sound/core/seq/oss/seq_oss_synth.c
index b16dbef..cd0e0eb 100644
--- a/sound/core/seq/oss/seq_oss_synth.c
+++ b/sound/core/seq/oss/seq_oss_synth.c
@@ -70,11 +70,11 @@ struct seq_oss_synth {
 static int max_synth_devs;
 static struct seq_oss_synth *synth_devs[SNDRV_SEQ_OSS_MAX_SYNTH_DEVS];
 static struct seq_oss_synth midi_synth_dev = {
-	-1, /* seq_device */
-	SYNTH_TYPE_MIDI, /* synth_type */
-	0, /* synth_subtype */
-	16, /* nr_voices */
-	"MIDI", /* name */
+	.seq_device = -1,
+	.synth_type = SYNTH_TYPE_MIDI,
+	.synth_subtype = 0,
+	.nr_voices = 16,
+	.name = "MIDI",
 };
 
 static DEFINE_SPINLOCK(register_lock);
-- 
1.9.1
