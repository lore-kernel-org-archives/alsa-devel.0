From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 02/14] ALSA: hdac: fix memory release for SST and SOF
 drivers
Date: Wed, 5 Jun 2019 10:06:47 -0500
Message-ID: <190f5c09-e6ae-918e-3fcc-d91a72a895da@linux.intel.com>
References: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
 <20190605134556.10322-3-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605134556.10322-3-amadeuszx.slawinski@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= <amadeuszx.slawinski@linux.intel.com>, alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 6/5/19 8:45 AM, Amadeusz Sławiński wrote:
> During the integration of HDaudio support, we changed the way in which
> we get hdev in snd_hdac_ext_bus_device_init() to use one preallocated
> with devm_kzalloc(), however it still left kfree(hdev) in
> snd_hdac_ext_bus_device_exit(). It leads to oopses when trying to
> rmmod and modprobe. Fix it, by just removing kfree call.
> 
> SOF also uses some of the snd_hdac_ functions for HDAudio support but
> allocated the memory with kzalloc. A matching fix is provided
> separately to align all users of the snd_hdac_ library.

There are stability issues with this change (already shared in a 
separate series) and additional findings reported by Libin so this 
should not be applied for now.

> 
> Fixes: 6298542fa33b ("ALSA: hdac: remove memory allocation from snd_hdac_ext_bus_device_init")
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   sound/hda/ext/hdac_ext_bus.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
> index c203af71a099..f33ba58b753c 100644
> --- a/sound/hda/ext/hdac_ext_bus.c
> +++ b/sound/hda/ext/hdac_ext_bus.c
> @@ -170,7 +170,6 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_init);
>   void snd_hdac_ext_bus_device_exit(struct hdac_device *hdev)
>   {
>   	snd_hdac_device_exit(hdev);
> -	kfree(hdev);
>   }
>   EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_exit);
>   
> 
