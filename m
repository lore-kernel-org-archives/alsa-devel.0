From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: wm8940: Fix mask for setting
	BCLKDIV
Date: Thu, 27 Oct 2011 16:24:57 +0800
Message-ID: <CAF+7xW=5tUW4Tn6HZt4dC=OE_VipO+rMsa0v4+HSpsbUU+Ojxw@mail.gmail.com>
References: <1319594021.2517.0.camel@phoenix> <1319594139.2517.2.camel@phoenix>
	<20111027071659.GB3053@opensource.wolfsonmicro.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id ABCE02468B
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Oct 2011 10:25:17 +0200 (CEST)
Received: by faao24 with SMTP id o24so2560430faa.38
	for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2011 01:25:17 -0700 (PDT)
In-Reply-To: <20111027071659.GB3053@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Chris Paulson-Ellis <chris@edesix.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

2011/10/27 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Wed, Oct 26, 2011 at 09:55:39AM +0800, Axel Lin wrote:
>> According to the datasheet:
>> BCLK is controlled by BIT[4:2] of WM8940_CLOCK(06h) register.
>
> This doesn't apply against current code.
>
Ooops. sorry.
I generate the patch base on the for-3.3 branch of the asoc tree.
The commit bdb527e "ASoC: wm8940: Fix a typo for the mask of setting
WM8940_BCLKDIV"
in the for-3.3 branch should be dropped, because it is fixed by this commit now.

I'll send a v2 base on your for-next tree.

Thanks,
Axel
