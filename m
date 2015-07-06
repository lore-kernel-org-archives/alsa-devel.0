From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] ASoC: Constify reg_default tables
Date: Mon, 6 Jul 2015 11:58:44 +0000
Message-ID: <8270335978364834a89229ee5c15e144@EMAIL.axentia.se>
References: <1436089709.19902.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EMAIL.axentia.se (axentia.se [87.96.186.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 361D92605AB
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 13:59:21 +0200 (CEST)
In-Reply-To: <1436089709.19902.2.camel@ingics.com>
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
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

For the below hunk, in case it matters:

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index aab0af6..bf7596b 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
