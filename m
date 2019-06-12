From: Michael Forney <mforney@mforney.org>
Subject: [PATCH 4/6] Make sure parameter qualifiers match
	between declaration and definition
Date: Tue, 11 Jun 2019 23:08:12 -0700
Message-ID: <20190612060814.13534-5-mforney@mforney.org>
References: <20190612060814.13534-1-mforney@mforney.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A74E0F8970C
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 08:08:22 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id p1so6178237plo.2
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 23:08:22 -0700 (PDT)
In-Reply-To: <20190612060814.13534-1-mforney@mforney.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 src/pcm/pcm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index fa51ca99..e0ceccc4 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -1997,7 +1997,7 @@ static const char *const snd_pcm_tstamp_type_names[] = {
  * \param stream PCM stream type
  * \return ascii name of PCM stream type
  */
-const char *snd_pcm_stream_name(snd_pcm_stream_t stream)
+const char *snd_pcm_stream_name(const snd_pcm_stream_t stream)
 {
 	if (stream > SND_PCM_STREAM_LAST)
 		return NULL;
@@ -2009,7 +2009,7 @@ const char *snd_pcm_stream_name(snd_pcm_stream_t stream)
  * \param acc PCM access type
  * \return ascii name of PCM access type
  */
-const char *snd_pcm_access_name(snd_pcm_access_t acc)
+const char *snd_pcm_access_name(const snd_pcm_access_t acc)
 {
 	if (acc > SND_PCM_ACCESS_LAST)
 		return NULL;
@@ -2021,7 +2021,7 @@ const char *snd_pcm_access_name(snd_pcm_access_t acc)
  * \param format PCM sample format
  * \return ascii name of PCM sample format
  */
-const char *snd_pcm_format_name(snd_pcm_format_t format)
+const char *snd_pcm_format_name(const snd_pcm_format_t format)
 {
 	if (format > SND_PCM_FORMAT_LAST)
 		return NULL;
@@ -2033,7 +2033,7 @@ const char *snd_pcm_format_name(snd_pcm_format_t format)
  * \param format PCM sample format
  * \return ascii description of PCM sample format
  */
-const char *snd_pcm_format_description(snd_pcm_format_t format)
+const char *snd_pcm_format_description(const snd_pcm_format_t format)
 {
 	if (format > SND_PCM_FORMAT_LAST)
 		return NULL;
@@ -2072,7 +2072,7 @@ snd_pcm_format_t snd_pcm_format_value(const char* name)
  * \param subformat PCM sample subformat
  * \return ascii name of PCM sample subformat
  */
-const char *snd_pcm_subformat_name(snd_pcm_subformat_t subformat)
+const char *snd_pcm_subformat_name(const snd_pcm_subformat_t subformat)
 {
 	if (subformat > SND_PCM_SUBFORMAT_LAST)
 		return NULL;
@@ -2084,7 +2084,7 @@ const char *snd_pcm_subformat_name(snd_pcm_subformat_t subformat)
  * \param subformat PCM sample subformat
  * \return ascii description of PCM sample subformat
  */
-const char *snd_pcm_subformat_description(snd_pcm_subformat_t subformat)
+const char *snd_pcm_subformat_description(const snd_pcm_subformat_t subformat)
 {
 	if (subformat > SND_PCM_SUBFORMAT_LAST)
 		return NULL;
@@ -2128,7 +2128,7 @@ link_warning(snd_pcm_xrun_mode_name, "Warning: xrun_mode is deprecated, consider
  * \param mode PCM tstamp mode
  * \return ascii name of PCM tstamp mode setting
  */
-const char *snd_pcm_tstamp_mode_name(snd_pcm_tstamp_t mode)
+const char *snd_pcm_tstamp_mode_name(const snd_pcm_tstamp_t mode)
 {
 	if (mode > SND_PCM_TSTAMP_LAST)
 		return NULL;
@@ -2152,7 +2152,7 @@ const char *snd_pcm_tstamp_type_name(snd_pcm_tstamp_type_t type)
  * \param state PCM state
  * \return ascii name of PCM state
  */
-const char *snd_pcm_state_name(snd_pcm_state_t state)
+const char *snd_pcm_state_name(const snd_pcm_state_t state)
 {
 	if (state > SND_PCM_STATE_LAST)
 		return NULL;
-- 
2.20.1
