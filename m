From: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
Subject: Re: [PATCH 03/14] ASoC: cs4271: Fix wrong value
 references for boolean kctl
Date: Tue, 10 Mar 2015 13:14:49 +0000
Message-ID: <000f424d.62f04d674689d696@cirrus.com>
References: <1425987556-569-1-git-send-email-tiwai@suse.de>,
 <1425987556-569-4-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077474.ppops.net (mx0b-001ae601.pphosted.com [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 2281F261ACA
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 14:14:51 +0100 (CET)
In-Reply-To: <1425987556-569-4-git-send-email-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "tiwai@suse.de" <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "lars@metafoo.de" <lars@metafoo.de>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



------ Original message------

From: Takashi Iwai

Date: Tue, Mar 10, 2015 6:39 AM

To: Mark Brown;

Cc: Liam Girdwood;Lars-Peter Clausen;Austin, Brian;Handrigan, Paul;Charles Keepax;alsa-devel@alsa-project.org<mailto:;alsa-devel@alsa-project.org>;

Subject:[PATCH 03/14] ASoC: cs4271: Fix wrong value references for boolean kctl


The correct values referred by a boolean control are
value.integer.va<http://value.integer.va>lue[], not value.enumerated.it<http://value.enumerated.it>em[].
The former is long while the latter is int, so it's even incompatible
on 64bit architectures.

Cc: ><mailto:<stable@vger.kernel.org>
Signed-off-by: Takashi Iwai ><mailto:<tiwai@suse.de>
---
 sound/soc/codecs/cs4271.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 79a4efcb894c..7d3a6accaf9a 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c

Thanks!

Acked-by: Paul Handrigan ><mailto:<Paul.Handrigan@cirrus.com>
