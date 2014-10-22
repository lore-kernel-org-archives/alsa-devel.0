From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 1/2] ARM: pxa: spitz: register
	spitz-audio device
Date: Wed, 22 Oct 2014 10:46:06 +0200
Message-ID: <1935279.fumFSz5CfW@wuerfel>
References: <1413926133-3566-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 507CC261A83
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 10:46:37 +0200 (CEST)
In-Reply-To: <1413926133-3566-1-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

On Wednesday 22 October 2014 01:15:32 Dmitry Eremin-Solenikov wrote:
> Register spitz-audio device to be used by ASoC driver.
> 
> [V2: Removed ifdefs around spitz_audio_init].
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> 

A more general note about your patch description above: when you
write about the changes between versions, put that below the ---
line under your Signed-off-by. Aside from that, your changelog
entry would actually benefit from more verbosity: explain what the
purpose of this is, not just what it does. 

>  /**************************************************************************
>  ****> 
> + * Audio devices
> +
> ***************************************************************************
> ***/ +static struct platform_device spitz_audio_device = {
> +       .name   = "spitz-audio",
> +       .id     = -1,
> +};
> +
> +static inline void spitz_audio_init(void)
> +{
> +       platform_device_register(&spitz_audio_device);
> +}+

I realize that the file has more of these, but it would be better
for a number of reasons to use 'platform_device_register_simple'
instead of platform_device_register. statically defining platform
devices (or any other device) is not recommended.

	Arnd
