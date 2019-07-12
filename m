From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v2] ASoC: audio-graph-card: Constify reg in
 graph_get_dai_id
Date: Thu, 11 Jul 2019 20:52:44 -0700
Message-ID: <20190712035244.GA67442@archlinux-epyc>
References: <20190712014357.84245-1-natechancellor@gmail.com>
 <20190712014554.62465-1-natechancellor@gmail.com>
 <87muhk53j1.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87muhk53j1.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Wen Yang <wen.yang99@zte.com.cn>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 12, 2019 at 12:37:51PM +0900, Kuninori Morimoto wrote:
> 
> Hi Nathan
> 
> > clang errors:
> > 
> > sound/soc/generic/audio-graph-card.c:87:7: error: assigning to 'u32 *'
> > (aka 'unsigned int *') from 'const void *' discards qualifiers
> > [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> >                 reg = of_get_property(node, "reg", NULL);
> >                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 1 error generated.
> > 
> > Move the declaration up a bit to keep the reverse christmas tree look.
> > 
> > Fixes: c152f8491a8d ("ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/600
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> 
> Maybe
> 
> ec3042ad39d4e2ddbc3a3344f90bb10d8feb53bc
> ("ASoC: audio-graph-card: add missing const at graph_get_dai_id()")
> 
> Thank you for your help !!
> Best regards
> ---
> Kuninori Morimoto

Ugh, I even checked Mark's tree before sending this, just completely
glossed over that patch. Sorry for the noise :(

Cheers,
Nathan
