From: Maciej Paszta <maciej.paszta@mobile.put.edu.pl>
Subject: Re: Follow Up: "Why my linux OS has only 8 sound cards
 ? How can I modify it ?"
Date: Tue, 08 May 2012 16:15:24 +0200
Message-ID: <4FA92A7C.2010609@mobile.put.edu.pl>
References: <4FA9170E.60306@mobile.put.edu.pl> <4FA91969.10000@ladisch.de>
	<s5hzk9in6h9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from seawolf.cs.put.poznan.pl (seawolf.cs.put.poznan.pl
	[150.254.23.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A00410405F
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 16:15:24 +0200 (CEST)
Received: from [192.168.1.105] (c78-206.icpnet.pl [62.21.78.206])
	by seawolf.cs.put.poznan.pl (Postfix) with ESMTPSA id E3814121920
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 16:15:21 +0200 (CEST)
In-Reply-To: <s5hzk9in6h9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks!

Changing to 256 made all devices appear!

On 2012-05-08 15:32, Takashi Iwai wrote:
> At Tue, 08 May 2012 15:02:33 +0200,
> Clemens Ladisch wrote:
>> Maciej Paszta wrote:
>>> Quick reminder: I have  10 sound cards which need to have oss emulation
>>> enabled. However, I only see 8 devices (dsp-dsp7). Takashi suggested a
>>> patch to workaround this problem:
>>> http://mailman.alsa-project.org/pipermail/alsa-devel/2011-November/045764.html
>>> I've applied it to kernel 3.0.0 and the only result I get is message
>>> appearing in kernel logs: "unable to register OSS PCM device 8:0". I've
>>> done some debugging and the registration fails on these lines
>>> (sound/core/sound_oss.c):
>>> register1 = register_sound_special_device(f_ops, minor, carddev);
>> Try replacing 128 with 256 in register_sound_special_device() in
>> sound/sound_core.c.
> Actually it should be 256, instead of 256 + unit, like the patch below.
>
>
> Takashi
>
> ---
> diff --git a/sound/sound_core.c b/sound/sound_core.c
> index c6e81fb..fb9255c 100644
> --- a/sound/sound_core.c
> +++ b/sound/sound_core.c
> @@ -361,7 +361,7 @@ int register_sound_special_device(const struct file_operations *fops, int unit,
>   				  struct device *dev)
>   {
>   	const int chain = unit % SOUND_STEP;
> -	int max_unit = 128 + chain;
> +	int max_unit = 256;
>   	const char *name;
>   	char _name[16];
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
Maciej Paszta
Mobile Systems Research Labs, Poznan University of Technology
