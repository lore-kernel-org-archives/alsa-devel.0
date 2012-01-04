From: Andrew Eikum <aeikum@codeweavers.com>
Subject: [alsa-lib PATCH 2/4] Search-and-replace improve
 documentation language
Date: Wed, 4 Jan 2012 14:11:37 -0600
Message-ID: <20120104201137.GD9868@foghorn.codeweavers.com>
References: <a0053dfb39d22118fce92031e4d6adac948b02fc.1325707699.git.aeikum@codeweavers.com>
Reply-To: alsa-devel <alsa-devel@alsa-project.org>,
	Andrew Eikum <aeikum@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vGgW1X5XWziG23Ko"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.codeweavers.com (mail.codeweavers.com [216.251.189.131])
	by alsa0.perex.cz (Postfix) with ESMTP id CE47E1038A0
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 21:11:38 +0100 (CET)
Received: from foghorn.codeweavers.com ([216.251.189.130])
	by mail.codeweavers.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.72)
	(envelope-from <aeikum@codeweavers.com>) id 1RiXBS-0008OI-7Z
	for alsa-devel@alsa-project.org; Wed, 04 Jan 2012 14:11:38 -0600
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


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Disposition: inline

---
 src/pcm/pcm.c |  146 ++++++++++++++++++++++++++-------------------------------
 1 files changed, 67 insertions(+), 79 deletions(-)


--vGgW1X5XWziG23Ko
Content-Type: text/x-patch; charset=us-ascii;
	name="0002-Search-and-replace-improve-documentation-language.patch"
Content-Disposition: inline; filename="0002-Search-and-replace-improve-documentation-language.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index bc5c6e4..dc91f79 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -2882,15 +2882,14 @@ int snd_pcm_hw_params_dump(snd_pcm_hw_params_t *p=
arams, snd_output_t *out)
 }
=20
 /**
- * \brief Check, if hardware supports sample-resolution mmap for given c=
onfiguration
+ * \brief Check if hardware supports sample-resolution mmap for given co=
nfiguration
  * \param params Configuration space
- * \return Boolean value
  * \retval 0 Hardware doesn't support sample-resolution mmap
  * \retval 1 Hardware supports sample-resolution mmap
  *
- * The return value is always one when given configuration is not exactl=
y one.
- * Usually, #snd_pcm_hw_params() function chooses one configuration
- * from the configuration space.
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
  */
 int snd_pcm_hw_params_can_mmap_sample_resolution(const snd_pcm_hw_params=
_t *params)
 {
@@ -2903,15 +2902,14 @@ int snd_pcm_hw_params_can_mmap_sample_resolution(=
const snd_pcm_hw_params_t *para
 }
=20
 /**
- * \brief Check, if hardware does double buffering for start/stop for gi=
ven configuration
+ * \brief Check if hardware does double buffering for start/stop for giv=
en configuration
  * \param params Configuration space
- * \return Boolean value
  * \retval 0 Hardware doesn't do double buffering for start/stop
  * \retval 1 Hardware does double buffering for start/stop
  *
- * It is not allowed to call this function when given configuration is n=
ot exactly one.
- * Usually, #snd_pcm_hw_params() function chooses one configuration
- * from the configuration space.
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
  */
 int snd_pcm_hw_params_is_double(const snd_pcm_hw_params_t *params)
 {
@@ -2924,15 +2922,14 @@ int snd_pcm_hw_params_is_double(const snd_pcm_hw_=
params_t *params)
 }
=20
 /**
- * \brief Check, if hardware does double buffering for data transfers fo=
r given configuration
+ * \brief Check if hardware does double buffering for data transfers for=
 given configuration
  * \param params Configuration space
- * \return Boolean value
  * \retval 0 Hardware doesn't do double buffering for data transfers
  * \retval 1 Hardware does double buffering for data transfers
  *
- * It is not allowed to call this function when given configuration is n=
ot exactly one.
- * Usually, #snd_pcm_hw_params() function chooses one configuration
- * from the configuration space.
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
  */
 int snd_pcm_hw_params_is_batch(const snd_pcm_hw_params_t *params)
 {
@@ -2945,15 +2942,14 @@ int snd_pcm_hw_params_is_batch(const snd_pcm_hw_p=
arams_t *params)
 }
=20
 /**
- * \brief Check, if hardware does block transfers for samples for given =
configuration
+ * \brief Check if hardware does block transfers for samples for given c=
onfiguration
  * \param params Configuration space
- * \return Boolean value
  * \retval 0 Hardware doesn't block transfers
  * \retval 1 Hardware does block transfers
  *
- * It is not allowed to call this function when given configuration is n=
ot exactly one.
- * Usually, #snd_pcm_hw_params() function chooses one configuration
- * from the configuration space.
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
  */
 int snd_pcm_hw_params_is_block_transfer(const snd_pcm_hw_params_t *param=
s)
 {
@@ -2966,15 +2962,14 @@ int snd_pcm_hw_params_is_block_transfer(const snd=
_pcm_hw_params_t *params)
 }
=20
 /**
- * \brief Check, if timestamps are monotonic for given configuration
+ * \brief Check if timestamps are monotonic for given configuration
  * \param params Configuration space
- * \return Boolean value
  * \retval 0 Device doesn't do monotomic timestamps
  * \retval 1 Device does monotonic timestamps
  *
- * It is not allowed to call this function when given configuration is n=
ot exactly one.
- * Usually, #snd_pcm_hw_params() function chooses one configuration
- * from the configuration space.
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
  */
 int snd_pcm_hw_params_is_monotonic(const snd_pcm_hw_params_t *params)
 {
@@ -2987,15 +2982,14 @@ int snd_pcm_hw_params_is_monotonic(const snd_pcm_=
hw_params_t *params)
 }
=20
 /**
- * \brief Check, if hardware supports overrange detection
+ * \brief Check if hardware supports overrange detection
  * \param params Configuration space
- * \return Boolean value
  * \retval 0 Hardware doesn't support overrange detection
  * \retval 1 Hardware supports overrange detection
  *
- * It is not allowed to call this function when given configuration is n=
ot exactly one.
- * Usually, #snd_pcm_hw_params() function chooses one configuration
- * from the configuration space.
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
  */
 int snd_pcm_hw_params_can_overrange(const snd_pcm_hw_params_t *params)
 {
@@ -3008,15 +3002,14 @@ int snd_pcm_hw_params_can_overrange(const snd_pcm=
_hw_params_t *params)
 }
=20
 /**
- * \brief Check, if hardware supports pause
+ * \brief Check if hardware supports pause
  * \param params Configuration space
- * \return Boolean value
  * \retval 0 Hardware doesn't support pause
  * \retval 1 Hardware supports pause
  *
- * It is not allowed to call this function when given configuration is n=
ot exactly one.
- * Usually, #snd_pcm_hw_params() function chooses one configuration
- * from the configuration space.
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
  */
 int snd_pcm_hw_params_can_pause(const snd_pcm_hw_params_t *params)
 {
@@ -3029,15 +3022,14 @@ int snd_pcm_hw_params_can_pause(const snd_pcm_hw_=
params_t *params)
 }
=20
 /**
- * \brief Check, if hardware supports resume
+ * \brief Check if hardware supports resume
  * \param params Configuration space
- * \return Boolean value
  * \retval 0 Hardware doesn't support resume
  * \retval 1 Hardware supports resume
  *
- * It is not allowed to call this function when given configuration is n=
ot exactly one.
- * Usually, #snd_pcm_hw_params() function chooses one configuration
- * from the configuration space.
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
  */
 int snd_pcm_hw_params_can_resume(const snd_pcm_hw_params_t *params)
 {
@@ -3050,15 +3042,14 @@ int snd_pcm_hw_params_can_resume(const snd_pcm_hw=
_params_t *params)
 }
=20
 /**
- * \brief Check, if hardware does half-duplex only
+ * \brief Check if hardware does half-duplex only
  * \param params Configuration space
- * \return Boolean value
  * \retval 0 Hardware doesn't do half-duplex
  * \retval 1 Hardware does half-duplex
  *
- * It is not allowed to call this function when given configuration is n=
ot exactly one.
- * Usually, #snd_pcm_hw_params() function chooses one configuration
- * from the configuration space.
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
  */
 int snd_pcm_hw_params_is_half_duplex(const snd_pcm_hw_params_t *params)
 {
@@ -3071,15 +3062,14 @@ int snd_pcm_hw_params_is_half_duplex(const snd_pc=
m_hw_params_t *params)
 }
=20
 /**
- * \brief Check, if hardware does joint-duplex (playback and capture are=
 somewhat correlated)
+ * \brief Check if hardware does joint-duplex (playback and capture are =
somewhat correlated)
  * \param params Configuration space
- * \return Boolean value
  * \retval 0 Hardware doesn't do joint-duplex
  * \retval 1 Hardware does joint-duplex
  *
- * It is not allowed to call this function when given configuration is n=
ot exactly one.
- * Usually, #snd_pcm_hw_params() function chooses one configuration
- * from the configuration space.
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
  */
 int snd_pcm_hw_params_is_joint_duplex(const snd_pcm_hw_params_t *params)
 {
@@ -3092,15 +3082,14 @@ int snd_pcm_hw_params_is_joint_duplex(const snd_p=
cm_hw_params_t *params)
 }
=20
 /**
- * \brief Check, if hardware supports synchronized start with sample res=
olution
+ * \brief Check if hardware supports synchronized start with sample reso=
lution
  * \param params Configuration space
- * \return Boolean value
  * \retval 0 Hardware doesn't support synchronized start
  * \retval 1 Hardware supports synchronized start
  *
- * It is not allowed to call this function when given configuration is n=
ot exactly one.
- * Usually, #snd_pcm_hw_params() function chooses one configuration
- * from the configuration space.
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
  */
 int snd_pcm_hw_params_can_sync_start(const snd_pcm_hw_params_t *params)
 {
@@ -3115,7 +3104,6 @@ int snd_pcm_hw_params_can_sync_start(const snd_pcm_=
hw_params_t *params)
 /**
  * \brief Check if hardware can disable period wakeups
  * \param params Configuration space
- * \return Boolean value
  * \retval 0 Hardware cannot disable period wakeups
  * \retval 1 Hardware can disable period wakeups
  */
@@ -3136,9 +3124,9 @@ int snd_pcm_hw_params_can_disable_period_wakeup(con=
st snd_pcm_hw_params_t *param
  * \param rate_den Pointer to returned rate denominator
  * \return 0 otherwise a negative error code if the info is not availabl=
e
  *
- * It is not allowed to call this function when given configuration is n=
ot exactly one.
- * Usually, #snd_pcm_hw_params() function chooses one configuration
- * from the configuration space.
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
  */
 int snd_pcm_hw_params_get_rate_numden(const snd_pcm_hw_params_t *params,
 				      unsigned int *rate_num, unsigned int *rate_den)
@@ -3158,9 +3146,9 @@ int snd_pcm_hw_params_get_rate_numden(const snd_pcm=
_hw_params_t *params,
  * \param params Configuration space
  * \return signification bits in sample otherwise a negative error code =
if the info is not available
  *
- * It is not allowed to call this function when given configuration is n=
ot exactly one.
- * Usually, #snd_pcm_hw_params() function chooses one configuration
- * from the configuration space.
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
  */
 int snd_pcm_hw_params_get_sbits(const snd_pcm_hw_params_t *params)
 {
@@ -3173,13 +3161,13 @@ int snd_pcm_hw_params_get_sbits(const snd_pcm_hw_=
params_t *params)
 }
=20
 /**
- * \brief Get hard are FIFO size info from a configuration space
+ * \brief Get hardware FIFO size info from a configuration space
  * \param params Configuration space
  * \return FIFO size in frames otherwise a negative error code if the in=
fo is not available
  *
- * It is not allowed to call this function when given configuration is n=
ot exactly one.
- * Usually, #snd_pcm_hw_params() function chooses one configuration
- * from the configuration space.
+ * This function should only be called when the configuration space
+ * contains a single configuration. Call #snd_pcm_hw_params to choose
+ * a single configuration from the configuration space.
  */
 int snd_pcm_hw_params_get_fifo_size(const snd_pcm_hw_params_t *params)
 {
@@ -3558,7 +3546,7 @@ void snd_pcm_hw_params_copy(snd_pcm_hw_params_t *ds=
t, const snd_pcm_hw_params_t
  * \brief Extract access type from a configuration space
  * \param params Configuration space
  * \param access Returned value
- * \return access type otherwise a negative error code if not exactly on=
e is present
+ * \return access type otherwise a negative error code if the configurat=
ion space does not contain a single value
  */
 #ifndef DOXYGEN
 int INTERNAL(snd_pcm_hw_params_get_access)(const snd_pcm_hw_params_t *pa=
rams, snd_pcm_access_t *access)
@@ -3659,7 +3647,7 @@ int snd_pcm_hw_params_get_access_mask(snd_pcm_hw_pa=
rams_t *params, snd_pcm_acces
  * \brief Extract format from a configuration space
  * \param params Configuration space
  * \param format returned format
- * \return format otherwise a negative error code if not exactly one is =
present
+ * \return format otherwise a negative error code if the configuration s=
pace does not contain a single value
  */
 #ifndef DOXYGEN
 int INTERNAL(snd_pcm_hw_params_get_format)(const snd_pcm_hw_params_t *pa=
rams, snd_pcm_format_t *format)
@@ -3753,7 +3741,7 @@ void snd_pcm_hw_params_get_format_mask(snd_pcm_hw_p=
arams_t *params, snd_pcm_form
  * \brief Extract subformat from a configuration space
  * \param params Configuration space
  * \param subformat Returned subformat value
- * \return subformat otherwise a negative error code if not exactly one =
is present
+ * \return subformat otherwise a negative error code if the configuratio=
n space does not contain a single value
  */
 #ifndef DOXYGEN
 int INTERNAL(snd_pcm_hw_params_get_subformat)(const snd_pcm_hw_params_t =
*params, snd_pcm_subformat_t *subformat)
@@ -3847,7 +3835,7 @@ void snd_pcm_hw_params_get_subformat_mask(snd_pcm_h=
w_params_t *params, snd_pcm_s
  * \brief Extract channels from a configuration space
  * \param params Configuration space
  * \param val Returned channels count
- * \return 0 otherwise a negative error code if not exactly one is prese=
nt
+ * \return 0 otherwise a negative error code if the configuration space =
does not contain a single value
  */
 #ifndef DOXYGEN
 int INTERNAL(snd_pcm_hw_params_get_channels)(const snd_pcm_hw_params_t *=
params, unsigned int *val)
@@ -4003,7 +3991,7 @@ int snd_pcm_hw_params_set_channels_last(snd_pcm_t *=
pcm, snd_pcm_hw_params_t *par
  * \param params Configuration space
  * \param val Returned approximate rate
  * \param dir Sub unit direction
- * \return 0 otherwise a negative error code if not exactly one is prese=
nt
+ * \return 0 otherwise a negative error code if the configuration space =
does not contain a single value
  *
  * Actual exact value is <,=3D,> the approximate one following dir (-1, =
0, 1)
  */
@@ -4219,7 +4207,7 @@ int snd_pcm_hw_params_get_rate_resample(snd_pcm_t *=
pcm, snd_pcm_hw_params_t *par
 }
=20
 /**
- * \brief Restrict a configuration space to allow the buffer accessible =
from outside
+ * \brief Restrict a configuration space to allow the buffer to be acces=
sible from outside
  * \param pcm PCM handle
  * \param params Configuration space
  * \param val 0 =3D disable, 1 =3D enable (default) exporting buffer
@@ -4306,7 +4294,7 @@ int snd_pcm_hw_params_get_period_wakeup(snd_pcm_t *=
pcm, snd_pcm_hw_params_t *par
  * \param params Configuration space
  * \param val Returned approximate period duration in us
  * \param dir Sub unit direction
- * \return 0 otherwise a negative error code if not exactly one is prese=
nt
+ * \return 0 otherwise a negative error code if the configuration space =
does not contain a single value
  *
  * Actual exact value is <,=3D,> the approximate one following dir (-1, =
0, 1)
  */
@@ -4494,7 +4482,7 @@ int snd_pcm_hw_params_set_period_time_last(snd_pcm_=
t *pcm, snd_pcm_hw_params_t *
  * \param params Configuration space
  * \param val Returned approximate period size in frames
  * \param dir Sub unit direction
- * \return 0 otherwise a negative error code if not exactly one is prese=
nt
+ * \return 0 otherwise a negative error code if the configuration space =
does not contain a single value
  *
  * Actual exact value is <,=3D,> the approximate one following dir (-1, =
0, 1)
  */
@@ -4731,7 +4719,7 @@ int snd_pcm_hw_params_set_period_size_integer(snd_p=
cm_t *pcm, snd_pcm_hw_params_
  * \param params Configuration space
  * \param val approximate periods per buffer
  * \param dir Sub unit direction
- * \return 0 otherwise a negative error code if not exactly one is prese=
nt
+ * \return 0 otherwise a negative error code if the configuration space =
does not contain a single value
  *
  * Actual exact value is <,=3D,> the approximate one following dir (-1, =
0, 1)
  */
@@ -4931,7 +4919,7 @@ int snd_pcm_hw_params_set_periods_integer(snd_pcm_t=
 *pcm, snd_pcm_hw_params_t *p
  * \param params Configuration space
  * \param val Returned buffer time in us
  * \param dir Sub unit direction
- * \return 0 otherwise a negative error code if not exactly one is prese=
nt
+ * \return 0 otherwise a negative error code if the configuration space =
does not contain a single value
  *
  * Actual exact value is <,=3D,> the approximate one following dir (-1, =
0, 1)
  */
@@ -5119,7 +5107,7 @@ int snd_pcm_hw_params_set_buffer_time_last(snd_pcm_=
t *pcm, snd_pcm_hw_params_t *
  * \brief Extract buffer size from a configuration space
  * \param params Configuration space
  * \param val Returned buffer size in frames
- * \return 0 otherwise a negative error code if not exactly one is prese=
nt
+ * \return 0 otherwise a negative error code if the configuration space =
does not contain a single value
  */
 #ifndef DOXYGEN
 int INTERNAL(snd_pcm_hw_params_get_buffer_size)(const snd_pcm_hw_params_=
t *params, snd_pcm_uframes_t *val)
@@ -5318,7 +5306,7 @@ int snd_pcm_hw_params_set_buffer_size_last(snd_pcm_=
t *pcm, snd_pcm_hw_params_t *
  * \param params Configuration space
  * \param val Returned approximate tick duration in us
  * \param dir Sub unit direction
- * \return 0 otherwise a negative error code if not exactly one is prese=
nt
+ * \return 0 otherwise a negative error code if the configuration space =
does not contain a single value
  *
  * Actual exact value is <,=3D,> the approximate one following dir (-1, =
0, 1)
  */
@@ -5508,7 +5496,7 @@ int snd_pcm_hw_params_set_tick_time_last(snd_pcm_t =
*pcm, snd_pcm_hw_params_t *pa
  * \brief Get the minimum transfer align value in samples
  * \param params Configuration space
  * \param val Returned minimum align value
- * \return 0 otherwise a negative error code if not exactly one is prese=
nt
+ * \return 0 otherwise a negative error code if the configuration space =
does not contain a single value
  */
 int snd_pcm_hw_params_get_min_align(const snd_pcm_hw_params_t *params, s=
nd_pcm_uframes_t *val)
 {

--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--vGgW1X5XWziG23Ko--
