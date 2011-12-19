From: Dmitry Artamonow <mad_soft@inbox.ru>
Subject: Re: ASoC: missed hx4700-audio platform device for
	hx4700
Date: Mon, 19 Dec 2011 08:37:14 +0400
Message-ID: <20111219043713.GA6917@rainbow>
References: <1324114379.28427.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp22.mail.ru (smtp22.mail.ru [94.100.176.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 550752470A
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 05:36:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1324114379.28427.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@marvell.com>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 17:32 Sat 17 Dec     , Axel Lin wrote:
> The iPAQ hx4700 machine driver needs a hx4700-audio platform device which is
> not (yet) merged.
> 
> The patchs was post on LKML: https://lkml.org/lkml/2011/5/18/222
> but [PATCH v3 3/3] pxa/hx4700: add platform device and I2C info for AK4641 codec is missed.

Hi, Axel! Thanks for noticing this. It's sad but true: this trivial
piece haven't been merged, making all merged  ASoC parts of hx4700 audio
support useless. In fact I even resend this patch once (see
http://lkml.org/lkml/2011/9/12/100), but also without much attention.
Have no idea what steps are needed to get this finally merged. I think
it all depends on Eric and he seems to be very busy and lost in incoming
mail (at least it was back in july - http://lkml.org/lkml/2011/7/11/217)

-- 
Best regards,
Dmitry "MAD" Artamonow
