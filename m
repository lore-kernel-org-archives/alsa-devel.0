From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 8/8] ALSA: Change return value for
	load_dsp_prepare() to -ENOSYS
Date: Thu, 13 Sep 2012 18:15:58 -0700
Message-ID: <1347585358-2403-9-git-send-email-ian_minett@creativelabs.com>
References: <1347585358-2403-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1347585358-2403-1-git-send-email-ian_minett@creativelabs.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

From: Ian Minett <ian_minett@creativelabs.com>

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 159e07a..ac60300 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -1164,7 +1164,7 @@ snd_hda_codec_load_dsp_prepare(struct hda_codec *codec, unsigned int format,
 				unsigned int size,
 				struct snd_dma_buffer *bufp)
 {
-	return 0;
+	return -ENOSYS;
 }
 static inline void
 snd_hda_codec_load_dsp_trigger(struct hda_codec *codec, bool start) {}
-- 
1.7.4.1
