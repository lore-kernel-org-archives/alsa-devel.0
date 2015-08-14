From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: add wm8960 support
Date: Fri, 14 Aug 2015 02:22:53 -0700
Message-ID: <20150814092252.GA4164@Asurada-CZ80>
References: <dc4e5a52a90982cea95445e27a30f2ad6cb73513.1439349623.git.zidan.wang@freescale.com>
 <20150812034257.GA2980@Asurada-CZ80>
 <20150812044505.GA21786@shlinux2>
 <20150812064053.GA2807@Asurada-CZ80>
 <20150812073859.GB21786@shlinux2>
 <20150812222735.GA57015@Asurada-CZ80>
 <20150814022116.GA11145@shlinux2> <20150814035805.GA2180@Asurada>
 <20150814073758.GB11145@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id DF26E2650F5
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 11:22:58 +0200 (CEST)
Received: by paccq16 with SMTP id cq16so12973024pac.1
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 02:22:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150814073758.GB11145@shlinux2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, shawnguo@kernel.org
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, tiwai@suse.com, timur@tabi.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

I have to add Shawn for help :)

On Fri, Aug 14, 2015 at 03:38:16PM +0800, Zidan Wang wrote:

> ccm ----->1------------------>2<------------>3
> 	  |                   |
>     	  |                   |		
> 	  4 SAIx MCLK1        5 SAIx MCLK2
> 
> If this bit is set, the clock route is ccm->1->2->3, 2 to 5 is disconnect.
> If this bit is clear, the clock route is 3->2->5, 1 to 2 is disconnect.

@Shawn

Suppose 1 and 2 are clock MUXs that we can't specifically touch
via registers. And 3 is an IO PAD that can either output a clock
from CCM or input a clock from an external source outside SoC.
Both 4 and 5 are two clock sources for one single SAI, SAI2 for
example.

There is a bit in the GPR register to control above routes. And
my question is where should be the best place to put this bit.

Apparently it's outside the CCM and SAI, not to mention it is
hard to relate this bit to this ASoC dai-link driver which's
supposed to solve problems between the SAI and CODECs.

Thanks
Nicolin
