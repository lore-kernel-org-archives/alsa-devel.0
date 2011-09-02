From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Add missing platform_device_put in
 raumfeld_audio_init error path
Date: Fri, 2 Sep 2011 15:03:36 +0100
Message-ID: <CABS+qY0dq+YxeTCN3=gVtxNS2xqKf9K9TmKOE338wmSTr+gM3g@mail.gmail.com>
References: <1314971261.3699.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog111.obsmtp.com (na3sys009aog111.obsmtp.com
	[74.125.149.205])
	by alsa0.perex.cz (Postfix) with ESMTP id F3A6C24373
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 16:03:38 +0200 (CEST)
Received: by qwm25 with SMTP id 25so2157838qwm.38
	for <alsa-devel@alsa-project.org>; Fri, 02 Sep 2011 07:03:36 -0700 (PDT)
In-Reply-To: <1314971261.3699.0.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

On 2 September 2011 14:47, Axel Lin <axel.lin@gmail.com> wrote:

> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/pxa/raumfeld.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
> index 1a591f1..b899a3b 100644
> --- a/sound/soc/pxa/raumfeld.c
> +++ b/sound/soc/pxa/raumfeld.c
> @@ -306,8 +306,10 @@ static int __init raumfeld_audio_init(void)
>                                     &snd_soc_raumfeld_connector);
>
>        ret = platform_device_add(raumfeld_audio_device);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               platform_device_put(raumfeld_audio_device);
>                return ret;
> +       }
>
>        raumfeld_enable_audio(true);
>        return 0;
> --
> 1.7.4.1
>

Acked-by: Liam Girdwood <lrg@ti.com>
