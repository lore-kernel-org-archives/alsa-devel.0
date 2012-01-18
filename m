From: Andrew Eikum <aeikum@codeweavers.com>
Subject: [alsa-lib PATCH] Document strdup allocation in
 snd_card_get_name family
Date: Wed, 18 Jan 2012 08:58:08 -0600
Message-ID: <20120118145808.GR24575@foghorn.codeweavers.com>
Reply-To: alsa-devel <alsa-devel@alsa-project.org>,
	Andrew Eikum <aeikum@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yzvKDKJiLNESc64M"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.codeweavers.com (mail.codeweavers.com [216.251.189.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CECF245FF
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 15:58:12 +0100 (CET)
Received: from foghorn.codeweavers.com ([216.251.189.130])
	by mail.codeweavers.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.72)
	(envelope-from <aeikum@codeweavers.com>) id 1RnWxm-0003fE-5O
	for alsa-devel@alsa-project.org; Wed, 18 Jan 2012 08:58:10 -0600
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


--yzvKDKJiLNESc64M
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This was spotted by J=C3=B6rg H=C3=B6hle on the wine-patches ML.

Signed-off-by: Andrew Eikum <aeikum@codeweavers.com>
---

I noticed my documentation patches haven't been making their way into
alsa-lib.git. Am I submitting these wrong? I added the SOB line above,
although I notice not all patches that get into ALSA have it. On the
other hand, alsa-lib.git hasn't been changed since November so perhaps
my patches are sitting in someone's tree waiting to be pushed :)

Please let me know if I can help get these in.

 src/control/cards.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)


--yzvKDKJiLNESc64M
Content-Type: text/x-patch; charset=us-ascii;
	name="0001-Document-strdup-allocation-in-snd_card_get_name-fami.patch"
Content-Disposition: inline; filename="0001-Document-strdup-allocation-in-snd_card_get_name-fami.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/src/control/cards.c b/src/control/cards.c
index 0bb8f86..b528e33 100644
--- a/src/control/cards.c
+++ b/src/control/cards.c
@@ -166,6 +166,9 @@ int snd_card_get_index(const char *string)
  * \param card Card number
  * \param name Result - card name corresponding to card number
  * \result zero if success, otherwise a negative error code
+ *
+ * The value returned in name is allocated with strdup and should be
+ * freed when no longer used.
  */
 int snd_card_get_name(int card, char **name)
 {
@@ -193,6 +196,9 @@ int snd_card_get_name(int card, char **name)
  * \param card Card number
  * \param name Result - card long name corresponding to card number
  * \result zero if success, otherwise a negative error code
+ *
+ * The value returned in name is allocated with strdup and should be
+ * freed when no longer used.
  */
 int snd_card_get_longname(int card, char **name)
 {

--yzvKDKJiLNESc64M
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--yzvKDKJiLNESc64M--
