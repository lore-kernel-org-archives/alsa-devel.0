From: Andrew Eikum <aeikum@codeweavers.com>
Subject: [alsa-lib PATCH 1/4] Remove docs for snd_names_list
 and snd_names_list_free
Date: Wed, 4 Jan 2012 14:11:27 -0600
Message-ID: <20120104201127.GC9868@foghorn.codeweavers.com>
Reply-To: alsa-devel <alsa-devel@alsa-project.org>,
	Andrew Eikum <aeikum@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.codeweavers.com (mail.codeweavers.com [216.251.189.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 29146243B5
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 21:11:31 +0100 (CET)
Received: from foghorn.codeweavers.com ([216.251.189.130])
	by mail.codeweavers.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.72)
	(envelope-from <aeikum@codeweavers.com>) id 1RiXBI-0008OB-CT
	for alsa-devel@alsa-project.org; Wed, 04 Jan 2012 14:11:28 -0600
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
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Disposition: inline


No need to have misleading docs for functions that do nothing.
---

Resending the whole sequence. New patch 4/4 improves the documentation
for the name hints functions.

 src/names.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)


--5mCyUwZo2JvN/JJP
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

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--5mCyUwZo2JvN/JJP--
