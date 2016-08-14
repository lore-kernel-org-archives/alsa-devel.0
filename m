From: David Henningsson <diwic@ubuntu.com>
Subject: [PATCH] mixer: Fix rounding mode documentation
Date: Sun, 14 Aug 2016 09:31:25 +0200
Message-ID: <1471159885-3218-1-git-send-email-diwic@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B5627261585
 for <alsa-devel@alsa-project.org>; Sun, 14 Aug 2016 09:31:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <diwic@ubuntu.com>
List-Id: alsa-devel@alsa-project.org

The documentation specifies three different rounding modes, but this
is wrong, because they all end up calling snd_tlv_convert_from_dB,
which only has two rounding modes.

Signed-off-by: David Henningsson <diwic@ubuntu.com>
---
 src/mixer/simple.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/mixer/simple.c b/src/mixer/simple.c
index fd9ba93..82476d5 100644
--- a/src/mixer/simple.c
+++ b/src/mixer/simple.c
@@ -376,7 +376,7 @@ int snd_mixer_selem_ask_playback_vol_dB(snd_mixer_elem_t *elem, long value, long
  * \brief Return corresponding integer playback volume for given dB value for a mixer simple element
  * \param elem Mixer simple element handle
  * \param value value to be converted to dB range
- * \param dir select direction (-1 = accurate or first bellow, 0 = accurate, 1 = accurate or first above)
+ * \param dir rounding mode - rounds up if dir > 0, otherwise rounds down
  * \param dBvalue pointer to returned dB value
  * \return 0 on success otherwise a negative error code
  */
@@ -454,7 +454,7 @@ int snd_mixer_selem_set_playback_volume(snd_mixer_elem_t *elem, snd_mixer_selem_
  * \param elem Mixer simple element handle
  * \param channel mixer simple element channel identifier
  * \param value control value in dB * 100
- * \param dir select direction (-1 = accurate or first bellow, 0 = accurate, 1 = accurate or first above)
+ * \param dir rounding mode - rounds up if dir > 0, otherwise rounds down
  * \return 0 on success otherwise a negative error code
  */
 int snd_mixer_selem_set_playback_dB(snd_mixer_elem_t *elem, snd_mixer_selem_channel_id_t channel, long value, int dir)
@@ -491,7 +491,7 @@ int snd_mixer_selem_set_playback_volume_all(snd_mixer_elem_t *elem, long value)
  * \brief Set value in dB of playback volume control for all channels of a mixer simple element
  * \param elem Mixer simple element handle
  * \param value control value in dB * 100
- * \param dir select direction (-1 = accurate or first bellow, 0 = accurate, 1 = accurate or first above)
+ * \param dir rounding mode - rounds up if dir > 0, otherwise rounds down
  * \return 0 on success otherwise a negative error code
  */
 int snd_mixer_selem_set_playback_dB_all(snd_mixer_elem_t *elem, long value, int dir)
@@ -706,7 +706,7 @@ int snd_mixer_selem_ask_capture_vol_dB(snd_mixer_elem_t *elem, long value, long
  * \param elem Mixer simple element handle
  * \param dBvalue dB value to be converted to integer range
  * \param value pointer to returned integer value
- * \param dir select direction (-1 = accurate or first bellow, 0 = accurate, 1 = accurate or first above)
+ * \param dir rounding mode - rounds up if dir > 0, otherwise rounds down
  * \return 0 on success otherwise a negative error code
  */
 int snd_mixer_selem_ask_capture_dB_vol(snd_mixer_elem_t *elem, long dBvalue, int dir, long *value)
@@ -777,7 +777,7 @@ int snd_mixer_selem_set_capture_volume(snd_mixer_elem_t *elem, snd_mixer_selem_c
  * \param elem Mixer simple element handle
  * \param channel mixer simple element channel identifier
  * \param value control value in dB * 100
- * \param dir select direction (-1 = accurate or first bellow, 0 = accurate, 1 = accurate or first above)
+ * \param dir rounding mode - rounds up if dir > 0, otherwise rounds down
  * \return 0 on success otherwise a negative error code
  */
 int snd_mixer_selem_set_capture_dB(snd_mixer_elem_t *elem, snd_mixer_selem_channel_id_t channel, long value, int dir)
@@ -814,7 +814,7 @@ int snd_mixer_selem_set_capture_volume_all(snd_mixer_elem_t *elem, long value)
  * \brief Set value in dB of capture volume control for all channels of a mixer simple element
  * \param elem Mixer simple element handle
  * \param value control value in dB * 100
- * \param dir select direction (-1 = accurate or first bellow, 0 = accurate, 1 = accurate or first above)
+ * \param dir rounding mode - rounds up if dir > 0, otherwise rounds down
  * \return 0 on success otherwise a negative error code
  */
 int snd_mixer_selem_set_capture_dB_all(snd_mixer_elem_t *elem, long value, int dir)
-- 
1.9.1
