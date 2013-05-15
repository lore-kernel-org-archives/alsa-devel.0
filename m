From: Jordi Mallach <jordi@debian.org>
Subject: =?utf-8?q?=5BPATCH_3/3=5D_Fix_several_spelling_error?=
	=?utf-8?q?s_for_=E2=80=9Cwritable=E2=80=9D_and_derivatives=2E?=
Date: Wed, 15 May 2013 19:06:00 +0200
Message-ID: <1368637560-28962-4-git-send-email-jordi@debian.org>
References: <1368637560-28962-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id ECCA52616DD
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:06:25 +0200 (CEST)
Received: from penyagolosa.oskuro.net (169.219.14.37.dynamic.jazztel.es
 [37.14.219.169])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id 3FF50628EE
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:06:25 +0200 (CEST)
In-Reply-To: <1368637560-28962-1-git-send-email-jordi@debian.org>
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
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 src/alisp/alisp.c     |    4 ++--
 src/alisp/alisp_snd.c |    2 +-
 src/rawmidi/rawmidi.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/alisp/alisp.c b/src/alisp/alisp.c
index 5dd5b06..1796c33 100644
--- a/src/alisp/alisp.c
+++ b/src/alisp/alisp.c
@@ -989,7 +989,7 @@ static void dump_objects(struct alisp_instance *instance, const char *fname)
 	else
 		err = snd_output_stdio_open(&out, fname, "w+");
 	if (err < 0) {
-		SNDERR("alisp: cannot open file '%s' for writting (%s)", fname, snd_strerror(errno));
+		SNDERR("alisp: cannot open file '%s' for writing (%s)", fname, snd_strerror(errno));
 		return;
 	}
 
@@ -1062,7 +1062,7 @@ static void dump_obj_lists(struct alisp_instance *instance, const char *fname)
 	else
 		err = snd_output_stdio_open(&out, fname, "w+");
 	if (err < 0) {
-		SNDERR("alisp: cannot open file '%s' for writting (%s)", fname, snd_strerror(errno));
+		SNDERR("alisp: cannot open file '%s' for writing (%s)", fname, snd_strerror(errno));
 		return;
 	}
 
diff --git a/src/alisp/alisp_snd.c b/src/alisp/alisp_snd.c
index de429d9..0a1a3b4 100644
--- a/src/alisp/alisp_snd.c
+++ b/src/alisp/alisp_snd.c
@@ -572,7 +572,7 @@ static struct alisp_object * FA_hctl_elem_info(struct alisp_instance * instance,
 	}
 	p1 = add_cons(instance, p1, 1, "type", new_string(instance, snd_ctl_elem_type_name(type)));
 	p1 = add_cons(instance, p1, 1, "readable", new_integer(instance, snd_ctl_elem_info_is_readable(info)));
-	p1 = add_cons(instance, p1, 1, "writeable", new_integer(instance, snd_ctl_elem_info_is_writable(info)));
+	p1 = add_cons(instance, p1, 1, "writable", new_integer(instance, snd_ctl_elem_info_is_writable(info)));
 	p1 = add_cons(instance, p1, 1, "volatile", new_integer(instance, snd_ctl_elem_info_is_volatile(info)));
 	p1 = add_cons(instance, p1, 1, "inactive", new_integer(instance, snd_ctl_elem_info_is_inactive(info)));
 	p1 = add_cons(instance, p1, 1, "locked", new_integer(instance, snd_ctl_elem_info_is_locked(info)));
diff --git a/src/rawmidi/rawmidi.c b/src/rawmidi/rawmidi.c
index 0bd6b96..b835b47 100644
--- a/src/rawmidi/rawmidi.c
+++ b/src/rawmidi/rawmidi.c
@@ -63,7 +63,7 @@ contents of written buffer - passed by snd_rawmidi_write() - atomically
 to output ring buffer in the kernel space. This flag also means that device
 is not opened exclusively, so more applications can share given rawmidi device.
 Note that applications must send the whole MIDI message including the running status,
-because another writting application might break the MIDI message in the output
+because another writing application might break the MIDI message in the output
 buffer.
 
 \subsection rawmidi_open_sync Sync open (flag)
-- 
1.7.10.4
