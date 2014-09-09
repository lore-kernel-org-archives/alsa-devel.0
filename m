From: jiwang <jiada_wang@mentor.com>
Subject: question about two ASoC commits
Date: Tue, 9 Sep 2014 17:36:36 +0900
Message-ID: <540EBC14.6090002@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 0859A26262A
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 10:36:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "Frkuska,
 Joshua" <Joshua_Frkuska@mentor.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi

Can anyone tell me what is the reasoning of the following two commits
commit: 5d16333 ASoC: SND_SOC_DAIFMT_NB_NF become 0 as default settings
commit: eef28e1 ASoC: SND_SOC_DAIFMT_GATED become 0 as default settings

with these two commits, now we have
#define SND_SOC_DAIFMT_GATED            (0 << 4)
#define SND_SOC_DAIFMT_NB_NF            (0 << 8)
in soc-dai.h
what's the good to shift 0 with different numbers?
no matter the number, they both equal to 0.

IMO all bit flags which share same variable (in this case SND_SOC_DAIFMT)
should have different value, isn't it?

Thanks,
Jiada
