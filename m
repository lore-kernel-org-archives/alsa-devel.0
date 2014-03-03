From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] ALSA: usb-audio - Capture and duplex
 support for Digidesign Mbox 1 sound card.
Date: Mon, 03 Mar 2014 22:01:21 +0100
Message-ID: <5314EDA1.5040101@zonque.org>
References: <52E5254A.8090308@gmail.com> <52E53D57.3010700@ladisch.de>
 <52E5CC2E.1010000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id C8163265695
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 22:01:22 +0100 (CET)
In-Reply-To: <52E5CC2E.1010000@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien.zammit@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi Damien,

Thanks for your patch! See my two comments below.

On 01/27/2014 04:02 AM, Damien Zammit wrote:
> On 27/01/14 03:52, Clemens Ladisch wrote:
>>> >> This patch creates a dual endpoint quirk.
>>>> >> >The quirk interface needs a second audioformat struct for this to work
>>>> >> >which I called ".data2".
>> > Couldn't you just let .data point to an array of two structs?
> Thanks Clemens, I have created a new patch using this suggestion.

[...]

> +	fp2 = kmemdup((const struct audioformat*)(quirk->data + sizeof(const struct audioformat)), sizeof(*fp2), GFP_KERNEL);
> +	if (!fp2) {
> +		snd_printk(KERN_ERR "cannot memdup 2\n");
> +		return -ENOMEM;
> +	}
> +	if (fp1->nr_rates > MAX_NR_RATES) {
> +		kfree(fp1);
> +		kfree(fp2);

Please do proper error unwinding here with jump labels rather than
open-coding the kfree() calls from multiple places.

Also, I wonder whether a more generic quirk type to set up a dynamic
number of fixed interfaces wouldn't be nicer. IOW, add a field to struct
snd_usb_audio_quirk to denote the number of array members in quirk->data
and call the quirk type QUIRK_AUDIO_FIXED_MULTI_ENDPOINT or something.
Then, rewrite the logic to iterate over the interfaces in a loop. That
might also make the code more readable.


Thanks,
Daniel
