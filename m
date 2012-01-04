From: Andrew Eikum <aeikum@codeweavers.com>
Subject: [alsa-lib PATCH 3/4] Improve hw_params documentation
Date: Wed, 4 Jan 2012 14:11:44 -0600
Message-ID: <20120104201144.GE9868@foghorn.codeweavers.com>
References: <a0053dfb39d22118fce92031e4d6adac948b02fc.1325707699.git.aeikum@codeweavers.com>
Reply-To: alsa-devel <alsa-devel@alsa-project.org>,
	Andrew Eikum <aeikum@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HG+GLK89HZ1zG0kk"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.codeweavers.com (mail.codeweavers.com [216.251.189.131])
	by alsa0.perex.cz (Postfix) with ESMTP id E073524469
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 21:11:45 +0100 (CET)
Received: from foghorn.codeweavers.com ([216.251.189.130])
	by mail.codeweavers.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.72)
	(envelope-from <aeikum@codeweavers.com>) id 1RiXBZ-0008OP-9N
	for alsa-devel@alsa-project.org; Wed, 04 Jan 2012 14:11:45 -0600
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


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Disposition: inline

---
 include/pcm.h |   17 ++++++++++++++++-
 src/pcm/pcm.c |   10 +++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)


--HG+GLK89HZ1zG0kk
Content-Type: text/x-patch; charset=us-ascii;
	name="0003-Improve-hw_params-documentation.patch"
Content-Disposition: inline; filename="0003-Improve-hw_params-documentation.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/include/pcm.h b/include/pcm.h
index be355a9..4997557 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -44,8 +44,23 @@ extern "C" {
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
+ *  When a parameter is set or restricted using a snd_pcm_hw_params_set*
+ *  function, all of the other ranges will be updated to exclude as many
+ *  impossible configurations as possible. Attempting to set a parameter
+ *  outside of its acceptable range will result in the function failing
+ *  and an error code being returned.
+ */
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

--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--HG+GLK89HZ1zG0kk--
