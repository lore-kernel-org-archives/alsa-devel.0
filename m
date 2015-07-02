From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [PATCH] ASoC: dapm: Don't check dummy dai in
 soc_dapm_dai_stream_event
Date: Thu, 2 Jul 2015 16:05:21 +0800
Message-ID: <20150702080519.GA24839@shlinux2>
References: <1434512468-25555-1-git-send-email-shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0140.outbound.protection.outlook.com [207.46.100.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BAB02615C0
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2015 11:14:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1434512468-25555-1-git-send-email-shengjiu.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi maintainers

	Could you please review this patch? I haven't receive any feedback
for about two weeks. Thanks.

Best regards
wang shengjiu

On Wed, Jun 17, 2015 at 11:41:08AM +0800, Shengjiu Wang wrote:
> Dummy dai can be used by multiple sound card. But it only belong to one
> card's dapm list. If another card use it, there will be dapm_assert_locked
> warning.
> 
> [   20.015782] WARNING: CPU: 1 PID: 661 at sound/soc/soc-dapm.c:124 dapm_assert_locked.isra.36+0x4c/0x58()
> [   20.025249] Modules linked in:
> [   20.028349] CPU: 1 PID: 661 Comm: aplay Not tainted 4.1.0-rc6-next-20150605-00004-gaee05d8-dirty #92
> [   20.037528] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   20.044110] Backtrace:
> [   20.046614] [<80012e00>] (dump_backtrace) from [<80012fa0>] (show_stack+0x18/0x1c)
> [   20.054229]  r6:809e8060 r5:00000000 r4:00000000 r3:00000000
> [   20.060002] [<80012f88>] (show_stack) from [<807a0f74>] (dump_stack+0x80/0x9c)
> [   20.067293] [<807a0ef4>] (dump_stack) from [<8002b144>] (warn_slowpath_common+0x7c/0xb4)
> [   20.075427]  r5:0000007c r4:00000000
> [   20.079065] [<8002b0c8>] (warn_slowpath_common) from [<8002b1a0>] (warn_slowpath_null+0x24/0x2c)
> [   20.087898]  r8:00000001 r7:88007c28 r6:ed94a680 r5:809e83e4 r4:ed83d6c0
> [   20.094747] [<8002b17c>] (warn_slowpath_null) from [<8058403c>] (dapm_assert_locked.isra.36+0x4c/0x58)
> [   20.104101] [<80583ff0>] (dapm_assert_locked.isra.36) from [<805842ec>] (dapm_mark_dirty+0x64/0xa4)
> [   20.113165] [<80584288>] (dapm_mark_dirty) from [<805853a8>] (soc_dapm_dai_stream_event.isra.42+0x30/0xc8)
> [   20.122863]  r8:ed9b5dbc r7:00000000 r6:00000001 r5:00000001 r4:ed83d6c0
> [   20.129706] [<80585378>] (soc_dapm_dai_stream_event.isra.42) from [<80587e28>] (snd_soc_dapm_stream_event+0x78/0xa0)
> [   20.140264]  r5:ee2ee62c r4:00000001
> [   20.143918] [<80587db0>] (snd_soc_dapm_stream_event) from [<8058957c>] (soc_pcm_prepare+0x138/0x21c)
> [   20.153058]  r8:ed8d9480 r7:00000000 r6:ed9b0e00 r5:00000001 r4:ee2ee62c r3:00000000
> ...
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> ---
>  sound/soc/soc-dapm.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index aa327c9..b618541 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -3856,6 +3856,9 @@ static void soc_dapm_dai_stream_event(struct snd_soc_dai *dai, int stream,
>  {
>  	struct snd_soc_dapm_widget *w;
>  
> +	if (snd_soc_dai_is_dummy(dai))
> +		return;
> +
>  	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
>  		w = dai->playback_widget;
>  	else
> -- 
> 1.7.9.5
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
