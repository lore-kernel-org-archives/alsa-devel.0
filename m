From: Sergej Sawazki <ce3a@gmx.de>
Subject: [PATCH resend] ASoC: wm8741: Fix rates constraints
	values
Date: Tue, 24 Mar 2015 21:13:22 +0100
Message-ID: <1427228002-10214-1-git-send-email-ce3a@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by alsa0.perex.cz (Postfix) with ESMTP id D3B8E26061D
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 21:13:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Sergej Sawazki <ce3a@gmx.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

The WM8741 DAC supports the following typical audio sampling rates:
  44.1kHz, 88.2kHz, 176.4kHz (eg: with a master clock of 22.5792MHz)
  32kHz, 48kHz, 96kHz, 192kHz (eg: with a master clock of 24.576MHz)

For the rates lists, we should use 82000 instead of 88235, 176400
instead of 1764000 and 192000 instead of 19200 (seems to be a typo).

Signed-off-by: Sergej Sawazki <ce3a@gmx.de>
---
 sound/soc/codecs/wm8741.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 31bb480..9e71c76 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -123,7 +123,7 @@ static struct {
 };
 
 static const unsigned int rates_11289[] = {
-	44100, 88235,
+	44100, 88200,
 };
 
 static const struct snd_pcm_hw_constraint_list constraints_11289 = {
@@ -150,7 +150,7 @@ static const struct snd_pcm_hw_constraint_list constraints_16384 = {
 };
 
 static const unsigned int rates_16934[] = {
-	44100, 88235,
+	44100, 88200,
 };
 
 static const struct snd_pcm_hw_constraint_list constraints_16934 = {
@@ -168,7 +168,7 @@ static const struct snd_pcm_hw_constraint_list constraints_18432 = {
 };
 
 static const unsigned int rates_22579[] = {
-	44100, 88235, 1764000
+	44100, 88200, 176400
 };
 
 static const struct snd_pcm_hw_constraint_list constraints_22579 = {
@@ -186,7 +186,7 @@ static const struct snd_pcm_hw_constraint_list constraints_24576 = {
 };
 
 static const unsigned int rates_36864[] = {
-	48000, 96000, 19200
+	48000, 96000, 192000
 };
 
 static const struct snd_pcm_hw_constraint_list constraints_36864 = {
-- 
1.9.1
