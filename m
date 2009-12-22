From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: [PATCH 1/1] Do not write to invalid registers on the
	wm9712.
Date: Tue, 22 Dec 2009 12:28:58 -0500
Message-ID: <1261502938-11137-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: grant.likely@secretlab.ca, alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

This patch fixes a bug where "virtual" registers were being written to the
ac97 bus.  This was causing unrelated registers to become corrupted (headphone 0x04,
touchscreen 0x78, etc).

This patch duplicates protection that was included in the wm9713 driver.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---
 sound/soc/codecs/wm9712.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 0ac1215..e237bf6 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -463,7 +463,8 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 {
        u16 *cache = codec->reg_cache;

-       soc_ac97_ops.write(codec->ac97, reg, val);
+       if (reg < 0x7c)
+               soc_ac97_ops.write(codec->ac97, reg, val);
        reg = reg >> 1;
        if (reg < (ARRAY_SIZE(wm9712_reg)))
                cache[reg] = val;
--
1.6.3.1


This e-mail and the information, including any attachments, it contains are intended to be a confidential communication only to the person or entity to whom it is addressed and may contain information that is privileged. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
