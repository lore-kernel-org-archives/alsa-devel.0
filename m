From: "J. Scott Merritt" <alsauser@pragmasoft.com>
Subject: Re: SALSA Lib - TLV Deprecated warnings
Date: Sun, 21 Oct 2007 13:13:22 -0400
Message-ID: <20071021131322.718dcc22.alsauser@pragmasoft.com>
References: <20070930111058.10171169.alsauser@pragmasoft.com>
	<s5habqsvetc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.server.rpi.edu (smtp6.server.rpi.edu [128.113.2.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A3EA245F4
	for <alsa-devel@alsa-project.org>;
	Sun, 21 Oct 2007 19:12:49 +0200 (CEST)
In-Reply-To: <s5habqsvetc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 09 Oct 2007 11:05:03 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 30 Sep 2007 11:10:58 -0400,
> J. Scott Merritt wrote:
> > 
> > It appears that if SALSA Lib 0.0.12 is built -without- TLV enabled in
> > the configuration options, then simply -including- asoundlib.h from an
> > application program will trigger deprecated warnings on some of the
> > TLV read/write function definitions (even though they are not called
> > from the application).
> > 
> > Is there something we can do to the header files to eliminate these
> > warnings ?
> 
> Try to build with --disable-deprecated option.  See GENERAL:MISC
> section in README.

How about the following patch to SALSA Lib 0.0.12 to eliminate
the warnings if TLV is not enabled ?   ...   Thanks, Scott.

--- a/src/hctl_macros.h	2007-08-29 12:05:25.000000000 -0400
+++ b/src/hctl_macros.h	2007-10-21 12:54:28.000000000 -0400
@@ -129,6 +129,7 @@
 	return snd_ctl_elem_write(elem->hctl->ctl, value);
 }
 
+#if SALSA_HAS_TLV_SUPPORT
 static inline
 int snd_hctl_elem_tlv_read(snd_hctl_elem_t *elem, unsigned int *tlv,
 			   unsigned int tlv_size)
@@ -148,6 +149,28 @@
 	return snd_ctl_elem_tlv_command(elem->hctl->ctl, &elem->id, tlv);
 }
 
+#else /* SALSA_HAS_TLV_SUPPORT */
+
+static inline __SALSA_NOT_IMPLEMENTED
+int snd_hctl_elem_tlv_read(snd_hctl_elem_t *elem, unsigned int *tlv,
+			   unsigned int tlv_size)
+{
+	return -ENXIO;
+}
+
+static inline __SALSA_NOT_IMPLEMENTED
+int snd_hctl_elem_tlv_write(snd_hctl_elem_t *elem, const unsigned int *tlv)
+{
+	return -ENXIO;
+}
+
+static inline __SALSA_NOT_IMPLEMENTED
+int snd_hctl_elem_tlv_command(snd_hctl_elem_t *elem, const unsigned int *tlv)
+{
+	return -ENXIO;
+}
+#endif /* SALSA_HAS_TLV_SUPPORT */
+
 static inline
 snd_hctl_t *snd_hctl_elem_get_hctl(snd_hctl_elem_t *elem)
 {
