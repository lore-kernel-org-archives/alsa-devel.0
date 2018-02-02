From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/3] cplay: add option to specify codec
	ID
Date: Fri, 2 Feb 2018 23:06:16 +0530
Message-ID: <20180202173616.GI18649@localhost>
References: <20180202043246.10481-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 4506D26791F
 for <alsa-devel@alsa-project.org>; Fri,  2 Feb 2018 18:31:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180202043246.10481-1-suzuki.katsuhiro@socionext.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 02, 2018 at 01:32:44PM +0900, Katsuhiro Suzuki wrote:
> This patch adds a -I command line option to set the codec ID,
> same as crecord.

Applied all 3 patches with below nit fix, thanks

diff --git a/src/utils/cplay.c b/src/utils/cplay.c
index f15c72876fb0..98d71a2199da 100644
--- a/src/utils/cplay.c
+++ b/src/utils/cplay.c
@@ -304,7 +304,7 @@ void get_codec_mp3(FILE *file, struct compr_config *config,
        codec->format = 0;
 }

-int get_codec_iec(FILE *file, struct compr_config *config,
+void get_codec_iec(FILE *file, struct compr_config *config,
                struct snd_codec *codec)
 {
        codec->id = SND_AUDIOCODEC_IEC61937;


-- 
~Vinod
