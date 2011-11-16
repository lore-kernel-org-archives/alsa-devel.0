From: Andrew Eikum <aeikum@codeweavers.com>
Subject: [PATCH 2/2] Improve hw_params documentation
Date: Wed, 16 Nov 2011 13:56:07 -0600
Message-ID: <20111116195607.GI30602@foghorn.codeweavers.com>
Reply-To: alsa-devel <alsa-devel@alsa-project.org>,
	Andrew Eikum <aeikum@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uCPdOCrL+PnN2Vxy"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.codeweavers.com (mail.codeweavers.com [216.251.189.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F5D5243BE
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 20:56:09 +0100 (CET)
Received: from foghorn.codeweavers.com ([216.251.189.130])
	by mail.codeweavers.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.72)
	(envelope-from <aeikum@codeweavers.com>) id 1RQlab-0001jR-1O
	for alsa-devel@alsa-project.org; Wed, 16 Nov 2011 13:56:09 -0600
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


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Disposition: inline

---
 include/pcm.h |   14 +++++++++++++-
 src/pcm/pcm.c |   10 +++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)


--uCPdOCrL+PnN2Vxy
Content-Type: text/x-patch; charset=us-ascii;
	name="0002-Improve-hw_params-documentation.patch"
Content-Disposition: inline; filename="0002-Improve-hw_params-documentation.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/include/pcm.h b/include/pcm.h
index be355a9..961c6a0 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -44,8 +44,20 @@ extern "C" {
=20
 /** PCM generic info container */
 typedef struct _snd_pcm_info snd_pcm_info_t;
-/** PCM hardware configuration space container */
+
+/** PCM hardware configuration space container
+ *
+ *  snd_pcm_hw_params_t is an opaque structure which contains a set of p=
ossible
+ *  PCM hardware configurations. For example, a given instance might inc=
lude a
+ *  range of buffer sizes, a range of period sizes, and a set of several=
 sample
+ *  formats. Some subset of all possible combinations these sets may be =
valid,
+ *  but not necessarily any combination will be valid.
+ *
+ *  No validation is done by the various snd_pcm_hw_params_set* function=
s.
+ *  Instead, #snd_pcm_hw_params will return an error code if the request=
ed
+ *  set of parameters can't be resolved to a single valid configuration.=
 */
 typedef struct _snd_pcm_hw_params snd_pcm_hw_params_t;
+
 /** PCM software configuration container */
 typedef struct _snd_pcm_sw_params snd_pcm_sw_params_t;
 /** PCM status container */
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index dc91f79..ea1afdc 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -809,7 +809,9 @@ int snd_pcm_hw_params_current(snd_pcm_t *pcm, snd_pcm=
_hw_params_t *params)
  *
  * The configuration is chosen fixing single parameters in this order:
  * first access, first format, first subformat, min channels, min rate,=20
- * min period time, max buffer size, min tick time
+ * min period time, max buffer size, min tick time. If no mutually
+ * compatible set of parameters can be chosen, a negative error code
+ * will be returned.
  *
  * After this call, #snd_pcm_prepare() is called automatically and
  * the stream is brought to \c #SND_PCM_STATE_PREPARED state.
@@ -817,6 +819,9 @@ int snd_pcm_hw_params_current(snd_pcm_t *pcm, snd_pcm=
_hw_params_t *params)
  * The hardware parameters cannot be changed when the stream is
  * running (active). The software parameters can be changed
  * at any time.
+ *
+ * The configuration space will be updated to reflect the chosen
+ * parameters.
  */
 int snd_pcm_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 {
@@ -3183,6 +3188,9 @@ int snd_pcm_hw_params_get_fifo_size(const snd_pcm_h=
w_params_t *params)
  * \brief Fill params with a full configuration space for a PCM
  * \param pcm PCM handle
  * \param params Configuration space
+ *
+ * The configuration space will be filled with all possible ranges
+ * for the PCM device.
  */
 int snd_pcm_hw_params_any(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 {

--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--uCPdOCrL+PnN2Vxy--
