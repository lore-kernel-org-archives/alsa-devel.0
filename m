From: Hugo Villeneuve <hugo@hugovil.com>
Subject: Re: [PATCH]: ARM DaVinci ASoC: Fix module unload error
Date: Fri, 13 Feb 2009 12:47:09 -0500
Message-ID: <20090213124709.110f408d.hugo@hugovil.com>
References: <1234508979-13522-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.hugovil.com (201-217-static-ppp.3menatwork.com
	[64.235.217.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 45BF724356
	for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2009 18:47:12 +0100 (CET)
In-Reply-To: <1234508979-13522-1-git-send-email-chaithrika@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: chaithrika@ti.com
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Fri, 13 Feb 2009 12:39:39 +0530
chaithrika@ti.com wrote:

> From: Chaithrika U S <chaithrika@ti.com>
> 
> Fix for the error when the audio module is unloaded.
> On unregistering the platform_device, platform_device_release will
> free the platform data.If platform data is static the kernel panics
> when it is freed. Instead use the platform device helper function to
> add data.
> 
> This change has been tested on DM644x EVM.
> 
> Signed-off-by: Chaithrika U S <chaithrika@ti.com>
> ---
>  sound/soc/davinci/davinci-evm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-evm.c
> b/sound/soc/davinci/davinci-evm.c index 1aad262..95c44bf 100644
> --- a/sound/soc/davinci/davinci-evm.c
> +++ b/sound/soc/davinci/davinci-evm.c
> @@ -225,7 +225,7 @@ static int __init evm_init(void)
>  
>  	platform_set_drvdata(evm_snd_device, &evm_snd_devdata);
>  	evm_snd_devdata.dev = &evm_snd_device->dev;
> -	evm_snd_device->dev.platform_data = data;
> +	platform_device_add_data(evm_snd_device, data, sizeof(data));

Hi,
I modified your patch for the SFFSDR board and it also fixed the
problem. Thank-you.

Can you include the fix for the SFFSDR also in your patch? Here is the 
modification for the SFFSDR:

diff --git a/sound/soc/davinci/davinci-sffsdr.c
b/sound/soc/davinci/davinci-sffsdr.c index a304ada..6e46258 100644
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -128,7 +128,7 @@ static int __init sffsdr_init(void)

        platform_set_drvdata(sffsdr_snd_device, &sffsdr_snd_devdata);
        sffsdr_snd_devdata.dev = &sffsdr_snd_device->dev;
-       sffsdr_snd_device->dev.platform_data = &sffsdr_snd_data;
+       platform_device_add_data(sffsdr_snd_device, &sffsdr_snd_data,
sizeof(sffsdr_snd_data));

        ret = platform_device_add_resources(sffsdr_snd_device,
                                            sffsdr_snd_resources,
