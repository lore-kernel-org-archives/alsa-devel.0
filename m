From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH]: ARM DaVinci ASoC: Fix module unload error
Date: Fri, 13 Feb 2009 11:16:16 -0800
Message-ID: <87ocx6jgfz.fsf@deeprootsystems.com>
References: <1234508979-13522-1-git-send-email-chaithrika@ti.com>
	<20090213124709.110f408d.hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EFDB243E5
	for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2009 20:16:21 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 26so1333294wfd.23
	for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2009 11:16:20 -0800 (PST)
In-Reply-To: <20090213124709.110f408d.hugo@hugovil.com> (Hugo Villeneuve's
	message of "Fri\, 13 Feb 2009 12\:47\:09 -0500")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: chaithrika@ti.com, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

Hugo Villeneuve <hugo@hugovil.com> writes:

> On Fri, 13 Feb 2009 12:39:39 +0530
> chaithrika@ti.com wrote:
>
>> From: Chaithrika U S <chaithrika@ti.com>
>> 
>> Fix for the error when the audio module is unloaded.
>> On unregistering the platform_device, platform_device_release will
>> free the platform data.If platform data is static the kernel panics
>> when it is freed. Instead use the platform device helper function to
>> add data.
>> 
>> This change has been tested on DM644x EVM.
>> 
>> Signed-off-by: Chaithrika U S <chaithrika@ti.com>
>> ---
>>  sound/soc/davinci/davinci-evm.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> diff --git a/sound/soc/davinci/davinci-evm.c
>> b/sound/soc/davinci/davinci-evm.c index 1aad262..95c44bf 100644
>> --- a/sound/soc/davinci/davinci-evm.c
>> +++ b/sound/soc/davinci/davinci-evm.c
>> @@ -225,7 +225,7 @@ static int __init evm_init(void)
>>  
>>  	platform_set_drvdata(evm_snd_device, &evm_snd_devdata);
>>  	evm_snd_devdata.dev = &evm_snd_device->dev;
>> -	evm_snd_device->dev.platform_data = data;
>> +	platform_device_add_data(evm_snd_device, data, sizeof(data));
>
> Hi,
> I modified your patch for the SFFSDR board and it also fixed the
> problem. Thank-you.
>
> Can you include the fix for the SFFSDR also in your patch? Here is the 
> modification for the SFFSDR:
>
> diff --git a/sound/soc/davinci/davinci-sffsdr.c
> b/sound/soc/davinci/davinci-sffsdr.c index a304ada..6e46258 100644
> --- a/sound/soc/davinci/davinci-sffsdr.c
> +++ b/sound/soc/davinci/davinci-sffsdr.c
> @@ -128,7 +128,7 @@ static int __init sffsdr_init(void)
>
>         platform_set_drvdata(sffsdr_snd_device, &sffsdr_snd_devdata);
>         sffsdr_snd_devdata.dev = &sffsdr_snd_device->dev;
> -       sffsdr_snd_device->dev.platform_data = &sffsdr_snd_data;
> +       platform_device_add_data(sffsdr_snd_device, &sffsdr_snd_data,
> sizeof(sffsdr_snd_data));
>
>         ret = platform_device_add_resources(sffsdr_snd_device,

Hugo,

I will fold your change into Chaithrika's original patch.

Thanks,


Kevin
