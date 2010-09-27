From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.37
Date: Mon, 27 Sep 2010 09:21:14 +0100
Message-ID: <1285575674.4658.5.camel@dplaptop>
References: <20100927002429.GB10992@opensource.wolfsonmicro.com>
	<s5htylbiu70.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 816C71037F1
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 10:21:16 +0200 (CEST)
In-Reply-To: <s5htylbiu70.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

>   sound/soc/codecs/wm8985.c: In function 'wm8985_hw_params':
>   sound/soc/codecs/wm8985.c:731:2: warning: format '%d' expects type 'int', but argument 4 has type 'size_t'
> 
> Actually the variable is fine as int.

I'd guess the expected fix is to change '%d' to '%zu'. The reason for it
being size_t is that is used in an expression involving ARRAY_SIZE(...)
which uses sizeof. But it does not really matter in actual fact because
the array will never be large enough to cause sign confusion.

Thanks,
Dimitrios
