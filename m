From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ASoC: twl4030 - Fix build error
Date: Mon, 16 Mar 2009 14:14:21 +0000
Message-ID: <20090316141420.GB16539@sirena.org.uk>
References: <4e1455be0903152013kf2158fdpc339a682111417c3@mail.gmail.com>
	<bd7b27490903160001q64ae952fh30f74b2799bb663e@mail.gmail.com>
	<s5h4oxtsw4z.wl%tiwai@suse.de> <s5h3addsvyj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2EEF1103826
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 15:14:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h3addsvyj.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Joonyoung Shim <dofmind@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 16, 2009 at 09:39:16AM +0100, Takashi Iwai wrote:

>   sound/soc/pxa/pxa2xx-ac97.c:136: warning: 'pxa2xx_ac97_hw_aux_params' defined but not used
>   sound/soc/pxa/pxa2xx-ac97.c:151: warning: 'pxa2xx_ac97_hw_mic_params' defined but not used

> The conversion in that commit looks incomplete.  We'd need three different
> dai_ops.

Yup, fixed that one too.
