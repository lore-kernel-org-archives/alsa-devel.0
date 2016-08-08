From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [alsa-devel] [PATCH 000/159] ASoC: codec cleanup - codec
 duplicate functions
Date: Mon, 8 Aug 2016 18:36:46 +0800
Message-ID: <CAGb2v66xQuMuDLdCoUr-gsOTamPssDOJoyNZsNx5PtdanFPHzA@mail.gmail.com>
References: <87wpjr8xld.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87wpjr8xld.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Aug 8, 2016 at 4:45 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Mark
>
> These are codec duplicate functions cleanup patches - v1
> We would like to switch to "component" style base ASoC in the future
> instead of current "CPU/Codec/Platform/Card" style.
>
> Current "component" already has callback functions, and "codec" is based
> on "component", but "codec" is still requesting/using its original callback.
> This is bacause of historical reason, but this is the time to cleanup.
>
> Lars's opinion is that this kind of cleanup can be final stage,
> but I think these are needed for "component" base style switching
>
> These are very big patch-set, but it doesn't add new features.
> [001/159] - [158/159] move callback functions from codec to component,
> and last [159/159] will remove codec side callback.

This series would probably be better for others to look through if the
codec name came after "ASoC: ", instead of at the end of the subject,
where it gets pushed way beyond 80 characters due to the "[alsa-devel]"
and "[PATCH xxx/yyy]" tags.


Regards
ChenYu

> We need this kind of cleanup for .probe/.remove too, and on Platform too.
> This cares codec duplicate callback function only as 1st step.
> I will post codec .probe/.remove cleanup if these are accepted,
> and will post platform side cleanup too.
>
> I build-tested these patches with make allyesconfig on x86,
> and tested on Lager board.
>
> Best regards
> ---
> Kuninori Morimoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
