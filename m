From: Andrew Eikum <aeikum@codeweavers.com>
Subject: [alsa-lib PATCH 4/4] Improve snd_device_name_hint
	documentation
Date: Wed, 4 Jan 2012 14:11:49 -0600
Message-ID: <20120104201149.GF9868@foghorn.codeweavers.com>
References: <a0053dfb39d22118fce92031e4d6adac948b02fc.1325707699.git.aeikum@codeweavers.com>
Reply-To: alsa-devel <alsa-devel@alsa-project.org>,
	Andrew Eikum <aeikum@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GpGaEY17fSl8rd50"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.codeweavers.com (mail.codeweavers.com [216.251.189.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D61D1039D5
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 21:11:51 +0100 (CET)
Received: from foghorn.codeweavers.com ([216.251.189.130])
	by mail.codeweavers.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.72)
	(envelope-from <aeikum@codeweavers.com>) id 1RiXBe-0008Ob-TG
	for alsa-devel@alsa-project.org; Wed, 04 Jan 2012 14:11:50 -0600
Content-Disposition: inline
In-Reply-To: <a0053dfb39d22118fce92031e4d6adac948b02fc.1325707699.git.aeikum@codeweavers.com>
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


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Disposition: inline

---
 src/control/namehint.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)


--GpGaEY17fSl8rd50
Content-Type: text/x-patch; charset=us-ascii;
	name="0004-Improve-snd_device_name_hint-documentation.patch"
Content-Disposition: inline; filename="0004-Improve-snd_device_name_hint-documentation.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/src/control/namehint.c b/src/control/namehint.c
index faaa5d5..19352be 100644
--- a/src/control/namehint.c
+++ b/src/control/namehint.c
@@ -517,15 +517,18 @@ static int add_software_devices(struct hint_list *l=
ist)
 }
=20
 /**
- * \brief Return string list with device name hints.
+ * \brief Get a set of device name hints
  * \param card Card number or -1 (means all cards)
  * \param iface Interface identification (like "pcm", "rawmidi", "timer"=
, "seq")
- * \param hints Result - array of string with device name hints
+ * \param hints Result - array of device name hints
  * \result zero if success, otherwise a negative error code
  *
- * Note: The device description is separated with '|' char.
+ * hints will receive a NULL-terminated array of device name hints,
+ * which can be passed to #snd_device_name_get_hint to extract usable
+ * values. When no longer needed, hints should be passed to
+ * #snd_device_name_free_hint to release resources.
  *
- * User defined hints are gathered from namehint.IFACE tree like:
+ * User-defined hints are gathered from namehint.IFACE tree like:
  *
  * <code>
  * namehint.pcm {<br>
@@ -534,6 +537,8 @@ static int add_software_devices(struct hint_list *lis=
t)
  * }
  * </code>
  *
+ * Note: The device description is separated with '|' char.
+ *
  * Special variables: defaults.namehint.showall specifies if all device
  * definitions are accepted (boolean type).
  */
@@ -626,8 +631,8 @@ int snd_device_name_hint(int card, const char *iface,=
 void ***hints)
 }
=20
 /**
- * \brief Free a string list with device name hints.
- * \param hints A string list to free
+ * \brief Free a list of device name hints.
+ * \param hints List to free
  * \result zero if success, otherwise a negative error code
  */
 int snd_device_name_free_hint(void **hints)
@@ -646,16 +651,17 @@ int snd_device_name_free_hint(void **hints)
 }
=20
 /**
- * \brief Get a hint Free a string list with device name hints.
+ * \brief Extract a value from a hint
  * \param hint A pointer to hint
- * \param id Hint ID (see bellow)
+ * \param id Hint value to extract ("NAME", "DESC", or "IOID", see below=
)
  * \result an allocated ASCII string if success, otherwise NULL
  *
  * List of valid IDs:
  * NAME - name of device
  * DESC - description of device
- * IOID - input / output identification (Input or Output strings),
- *        not present (NULL) means both
+ * IOID - input / output identification ("Input" or "Output"), NULL mean=
s both
+ *
+ * The return value should be freed when no longer needed.
  */
 char *snd_device_name_get_hint(const void *hint, const char *id)
 {

--GpGaEY17fSl8rd50
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--GpGaEY17fSl8rd50--
