From: Andrew Eikum <aeikum@codeweavers.com>
Subject: [alsa-lib PATCH] Remove docs for snd_names_list and
 snd_names_list_free
Date: Wed, 2 Nov 2011 12:40:49 -0500
Message-ID: <20111102174049.GF3966@foghorn.codeweavers.com>
Reply-To: alsa-devel <alsa-devel@alsa-project.org>,
	Andrew Eikum <aeikum@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="iFRdW5/EC4oqxDHL"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.codeweavers.com (mail.codeweavers.com [216.251.189.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F4E224383
	for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2011 18:40:53 +0100 (CET)
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
To: alsa-devel <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Disposition: inline


"Deprecated," to me, doesn't necessarily imply "completely useless,"
especially if there are complete docs attached. To prevent future
confusion, make it clear that these functions are now unimplemented.

---
 src/names.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)


--iFRdW5/EC4oqxDHL
Content-Type: text/x-patch; charset=us-ascii;
	name="0001-Remove-docs-for-snd_names_list-and-snd_names_list_fr.patch"
Content-Disposition: inline; filename="0001-Remove-docs-for-snd_names_list-and-snd_names_list_fr.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/src/names.c b/src/names.c
index e7a6887..000e574 100644
--- a/src/names.c
+++ b/src/names.c
@@ -36,14 +36,8 @@
 #include "local.h"
=20
 /**=20
- * \brief Give a list of device names and associated comments for select=
ed interface
- * \param iface a string identifying interface ("pcm", "ctl", "seq", "ra=
wmidi")
- * \param list result - a pointer to list
- * \return A non-negative value if successful, otherwise a negative erro=
r code.
+ * \brief This function is unimplemented.
  * \deprecated Since 1.0.14
- *
- * The global configuration files are specified in the environment varia=
ble
- * \c ALSA_NAMES_FILE.
  */
 int snd_names_list(const char *iface ATTRIBUTE_UNUSED,
 		   snd_devname_t **list ATTRIBUTE_UNUSED)
@@ -53,11 +47,8 @@ int snd_names_list(const char *iface ATTRIBUTE_UNUSED,
 link_warning(snd_names_list, "Warning: snd_names_list is deprecated, use=
 snd_device_name_hint");
=20
 /**
- * \brief Release the list of device names
- * \param list the name list to release
+ * \brief This function is unimplemented.
  * \deprecated Since 1.0.14
- *
- * Releases the list of device names allocated via #snd_names_list().
  */
 void snd_names_list_free(snd_devname_t *list ATTRIBUTE_UNUSED)
 {

--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--iFRdW5/EC4oqxDHL--
