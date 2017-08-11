From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH alsa-lib] src/rawmidi/rawmidi_symbols.c: use
	rawmidi_virt only when available
Date: Fri, 11 Aug 2017 23:24:03 +0200
Message-ID: <20170811212403.24607-1-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 0563B266D57
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 23:24:05 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

src/rawmidi/Makefile.am only brings rawmidi_virt.c into the build when
BUILD_SEQ is defined (i.e when --enable-seq is passed). However,
rawmidi_symbols.c unconditionally refers to _snd_module_rawmidi_virt,
defined in rawmidi_virt.c.

This causes a link failure when BUILD_SEQ is disabled. For example
when linking ffmpeg against alsa-lib:

/home/thomas/projets/buildroot/output/host/arm-buildroot-linux-uclibcgnueabi/sysroot/usr/lib/libasound.a(pcm_dmix.o): In function `snd_pcm_dmix_sync_ptr':
pcm_dmix.c:(.text+0x83c): warning:
/home/thomas/projets/buildroot/output/host/arm-buildroot-linux-uclibcgnueabi/sysroot/usr/lib/libasound.a(rawmidi_symbols.o):(.data+0x4): undefined reference to `_snd_module_rawmidi_virt'
collect2: error: ld returned 1 exit status

To fix this, we make sure that rawmidi_symbols.c only uses
_snd_module_rawmidi_virt when available.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 src/rawmidi/rawmidi_symbols.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/rawmidi/rawmidi_symbols.c b/src/rawmidi/rawmidi_symbols.c
index cdc06d7..6473433 100644
--- a/src/rawmidi/rawmidi_symbols.c
+++ b/src/rawmidi/rawmidi_symbols.c
@@ -21,11 +21,15 @@
 #ifndef PIC
 
 extern const char *_snd_module_rawmidi_hw;
+#ifdef BUILD_SEQ
 extern const char *_snd_module_rawmidi_virt;
+#endif
 
 static const char **snd_rawmidi_open_objects[] = {
 	&_snd_module_rawmidi_hw,
+#ifdef BUILD_SEQ
 	&_snd_module_rawmidi_virt
+#endif
 };
 	
 void *snd_rawmidi_open_symbols(void)
-- 
2.9.4
