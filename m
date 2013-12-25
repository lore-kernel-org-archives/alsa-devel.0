From: "H.J. Lu" <hjl.tools@gmail.com>
Subject: [PATCH 2/2] Use __compat_aligned_s64 in uapi <sound/asound.h>
Date: Wed, 25 Dec 2013 09:17:46 -0800
Message-ID: <20131225171746.GA1826@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, alan.cox@intel.com, Thomas Gleixner <tglx@linutronix.de>, tiwai@suse.de, perex@perex.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The integer64 field in struct snd_ctl_elem_value has different offsets,
depending the alignment of long long.  This patch replaces long long
with the newly introduced __compat_aligned_s64 so that x32 and ia32
can use the same compat system call for struct snd_ctl_elem_value.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
---
 include/uapi/sound/asound.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index e3983d5..ea6489c 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -877,8 +877,8 @@ struct snd_ctl_elem_value {
 			long *value_ptr;	/* obsoleted */
 		} integer;
 		union {
-			long long value[64];
-			long long *value_ptr;	/* obsoleted */
+			__compat_aligned_s64 value[64];
+			__compat_aligned_s64 *value_ptr;	/* obsoleted */
 		} integer64;
 		union {
 			unsigned int item[128];
-- 
1.8.1.4
