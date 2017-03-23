From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v2 1/2] ASoC: STI: Fix reader substream pointer
	set
Date: Thu, 23 Mar 2017 19:39:54 +0100
Message-ID: <1490294395-13416-2-git-send-email-arnaud.pouliquen@st.com>
References: <1490294395-13416-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id C6D48266A33
 for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2017 19:40:00 +0100 (CET)
In-Reply-To: <1490294395-13416-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org

reader->substream is used in IRQ handler for error case but is never set.
Set value to pcm substream on DAI startup and clean it on dai shutdown.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/uniperif_reader.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index 5992c6a..93a8df6 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -349,6 +349,8 @@ static int uni_reader_startup(struct snd_pcm_substream *substream,
 	struct uniperif *reader = priv->dai_data.uni;
 	int ret;
 
+	reader->substream = substream;
+
 	if (!UNIPERIF_TYPE_IS_TDM(reader))
 		return 0;
 
@@ -378,6 +380,7 @@ static void uni_reader_shutdown(struct snd_pcm_substream *substream,
 		/* Stop the reader */
 		uni_reader_stop(reader);
 	}
+	reader->substream = NULL;
 }
 
 static const struct snd_soc_dai_ops uni_reader_dai_ops = {
-- 
1.9.1
