From: David Fries <david@fries.net>
Subject: [PATCH] modem.conf Off-hook improve behavior
Date: Fri, 25 Dec 2009 14:22:38 -0600
Message-ID: <20091225202238.GA12403@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SpacedOut.fries.net (SpacedOut.fries.net [67.64.210.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 385081037F8
	for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2009 21:22:42 +0100 (CET)
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-5) with ESMTP id
	nBPKMdFl012451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2009 14:22:40 -0600
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id nBPKMd4c012450
	for alsa-devel@alsa-project.org; Fri, 25 Dec 2009 14:22:39 -0600
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: David Fries <david@fries.net>

Only restore the old value if it differs from the requested
value, because if it has changed restoring the old value
overrides the change.  Take for example, a voice modem with
a .conf that sets preserve off-hook.  Start playback (on-hook
to off-hook), start record (off-hook to off-hook), stop
playback (off-hook to restore on-hook), stop record (on-hook
to restore off-hook), Clearly you don't want to leave the
modem "on the phone" now that there isn't any playback or
recording active.

Signed-off-by: David Fries <david@fries.net>
---
Comments welcome.

The default modem.conf has,
hooks.0 {
	type ctl_elems
	hook_args [
	{
		name "Off-hook Switch"
		preserve true
		value "on"
		lock false
		optional true
	}
	]
}
I wrote the patch to be, if you didn't modify it, don't restore the
value.  I also thought that it might work to check to see if the
current mixer value matches the requested value (which is the value
the program set on open), and only set the old value if it hasn't been
externally modified.  The theory being if something else changed the
mixer value, we don't want to by default overwrite that change.

Some additional flags could also be added to leave the current
behavior alone and add the if you didn't modify it, don't restore it,
or if it changed after you set it, don't restore it.  Here are some
flag names if that would be preferred, preserve_if_different
restore_if_unmodified no_squash restore_overrides preserve_if_changed.

Setting the lock isn't really an option, because then you can't
manually "hang up" the modem if you needed to.

On a side note, do any of the alsa voice/software modems support
notifying userspace when the line is ringing?  I'm using intel8x0m,
not that I think it matters here.

diff --git a/include/control.h b/include/control.h
index 2361dc3..ded884a 100644
--- a/include/control.h
+++ b/include/control.h
@@ -419,6 +419,7 @@ int snd_ctl_elem_value_malloc(snd_ctl_elem_value_t **ptr);
 void snd_ctl_elem_value_free(snd_ctl_elem_value_t *obj);
 void snd_ctl_elem_value_clear(snd_ctl_elem_value_t *obj);
 void snd_ctl_elem_value_copy(snd_ctl_elem_value_t *dst, const snd_ctl_elem_value_t *src);
+int snd_ctl_elem_value_compare(snd_ctl_elem_value_t *left, const snd_ctl_elem_value_t *right);
 void snd_ctl_elem_value_get_id(const snd_ctl_elem_value_t *obj, snd_ctl_elem_id_t *ptr);
 unsigned int snd_ctl_elem_value_get_numid(const snd_ctl_elem_value_t *obj);
 snd_ctl_elem_iface_t snd_ctl_elem_value_get_interface(const snd_ctl_elem_value_t *obj);
diff --git a/src/control/control.c b/src/control/control.c
index df249dd..159b09a 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -2256,6 +2256,18 @@ void snd_ctl_elem_value_copy(snd_ctl_elem_value_t *dst, const snd_ctl_elem_value
 }
 
 /**
+ * \brief compare one #snd_ctl_elem_value_t to another
+ * \param dst pointer to destination
+ * \param src pointer to source
+ * \return 0 on match, less than or greater than otherwise, see memcmp
+ */
+int snd_ctl_elem_value_compare(snd_ctl_elem_value_t *left, const snd_ctl_elem_value_t *right)
+{
+	assert(left && right);
+	return memcmp(left, right, sizeof(*left));
+}
+
+/**
  * \brief Get CTL element identifier of a CTL element id/value
  * \param obj CTL element id/value
  * \param ptr Pointer to returned CTL element identifier
diff --git a/src/control/setup.c b/src/control/setup.c
index 408244e..3606daf 100644
--- a/src/control/setup.c
+++ b/src/control/setup.c
@@ -192,7 +192,17 @@ int snd_sctl_remove(snd_sctl_t *h)
 				return err;
 			}
 		}
-		if (elem->preserve) {
+		/* Only restore the old value if it differs from the requested
+		 * value, because if it has changed restoring the old value
+		 * overrides the change.  Take for example, a voice modem with
+		 * a .conf that sets preserve off-hook.  Start playback (on-hook
+		 * to off-hook), start record (off-hook to off-hook), stop
+		 * playback (off-hook to restore on-hook), stop record (on-hook
+		 * to restore off-hook), Clearly you don't want to leave the
+		 * modem "on the phone" now that there isn't any playback or
+		 * recording active.
+		 */
+		if (elem->preserve && snd_ctl_elem_value_compare(elem->val, elem->old)) {
 			err = snd_ctl_elem_write(h->ctl, elem->old);
 			if (err < 0) {
 				SNDERR("Cannot restore ctl elem");
