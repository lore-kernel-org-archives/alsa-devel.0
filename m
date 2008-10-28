From: "Manish Katiyar" <mkatiyar@gmail.com>
Subject: [PATCH] Remove unused variable 'codec' from
	sound/soc/codecs/tlv320aic23.c
Date: Tue, 28 Oct 2008 11:55:34 +0530
Message-ID: <ea11fea30810272325u64fa091bmf7bcf090cc1f6a28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 1584E24545
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 07:25:35 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id j3so1334981tid.8
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 23:25:34 -0700 (PDT)
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
To: arunks@mistralsolutions.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
Cc: mkatiyar@gmail.com
List-Id: alsa-devel@alsa-project.org

[ Apologies if this is not the proper list for this patch, but I
couldn't find any list more appropriate for this]

Below patch removes the following warning.
sound/soc/codecs/tlv320aic23.c:424: warning: unused variable 'codec'


Signed-off-by: Manish Katiyar <mkatiyar@gmail.com>
---
 sound/soc/codecs/tlv320aic23.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 44308da..45395d0 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -421,8 +421,6 @@ static int tlv320aic23_set_dai_fmt(struct
snd_soc_dai *codec_dai,
 static int tlv320aic23_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				      int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-
 	switch (freq) {
 	case 12000000:
 		return 0;
-- 
1.5.4.3


Thanks -
Manish
