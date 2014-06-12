From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH RESEND] ASoC: rt5677: Convert to use
	rl6231_get_clk_info
Date: Thu, 12 Jun 2014 17:56:51 +0800
Message-ID: <CAFRkauDVBhTp0WZVOrMePhw4j=gwwz057fkc_LtFKh=7wQUCUg@mail.gmail.com>
References: <1402361856.4636.0.camel@phoenix>
 <CAFRkauCDgnGt1HpRQQDY59ASF8=oSYX+NdOgGan2iZEiwry6pg@mail.gmail.com>
 <20140612094958.GT5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f45.google.com (mail-qa0-f45.google.com
 [209.85.216.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 170BC265753
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 11:56:52 +0200 (CEST)
Received: by mail-qa0-f45.google.com with SMTP id v10so1299806qac.32
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 02:56:52 -0700 (PDT)
In-Reply-To: <20140612094958.GT5099@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

2014-06-12 17:49 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Thu, Jun 12, 2014 at 08:26:25AM +0800, Axel Lin wrote:
>
>> This patch ensures SND_SOC_RL6231 will be built.
>> This patch is required to fix build error with commit
>> "ASoC: rt5677: Convert to use rl6231_calc_dmic_clk".
>
> Sure, but remember that that patch isn't in -next yet since the merge
> window is still open.  I'll get to it at some point before it is.

OK, and thanks.
I sent the mail because I got a build error report from "kbuild test robot".
Axel
