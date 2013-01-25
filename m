From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH next-20130124] Sound: pci: Fix unused variable warning
 in patch_sigmatel.c
Date: Fri, 25 Jan 2013 02:03:16 -0800
Message-ID: <1359108196.2686.6.camel@joe-AO722>
References: <5101B7CE.4070102@semaphore.gr> <s5hehh9d3x7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <s5hehh9d3x7.wl%tiwai@suse.de>
Sender: linux-next-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, Jaroslav Kysela <perex@perex.cz>, David Henningsson <david.henningsson@canonical.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2013-01-25 at 10:09 +0100, Takashi Iwai wrote:
> At Fri, 25 Jan 2013 00:38:06 +0200,
> Stratos Karafotis wrote:
> > Fix the following build warnings
> > sound/pci/hda/patch_sigmatel.c: In function =E2=80=98stac92hd71bxx_=
fixup_hp=E2=80=99:
> > sound/pci/hda/patch_sigmatel.c:2434:24: warning: unused variable =E2=
=80=98spec=E2=80=99 [-Wunused-variable]
[]
> I'm going to fix the definition of snd_printd() itself for fixing thi=
s
> kind of warnings.  We can use inline functions instead of empty macro=
s
> to achieve the same but without triggering compiler warnings.

It's probably better to use a macro like:

do {						\
	if (0)					\
		printk(fmt, ##__VA_ARGS__);	\
} while (0)

to allow the compiler to avoid any argument evaluation
while still doing fmt/arg matching.

Something like:

 include/sound/core.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 93896ad..ce5d224 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -394,8 +394,17 @@ void __snd_printk(unsigned int level, const char *=
file, int line,
=20
 #else /* !CONFIG_SND_DEBUG */
=20
-#define snd_printd(fmt, args...)	do { } while (0)
-#define _snd_printd(level, fmt, args...) do { } while (0)
+#define snd_printd(fmt, ...)						\
+do {									\
+	if (0)								\
+		__snd_printk(1, __FILE__, __LINE__, fmt, ##__VA_ARGS__); \
+} while (0)
+#define _snd_printd(level, fmt, ...)					\
+do {									\
+	if (0)								\
+		__snd_printk(level, __FILE__, __LINE__, fmt, ##__VA_ARGS__); \
+} while (0)
+
 #define snd_BUG()			do { } while (0)
 static inline int __snd_bug_on(int cond)
 {
