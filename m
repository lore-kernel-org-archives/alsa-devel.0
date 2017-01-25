From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 6/7] dmasound_core: Move two assignments for
 the variable "ret" in state_open()
Date: Wed, 25 Jan 2017 08:40:27 +0100
Message-ID: <5701efac-3c37-8b6c-fbe7-89a54e988998@ladisch.de>
References: <f2404d64-27c8-4afa-b893-fc72601c0136@users.sourceforge.net>
 <b4d0b274-23ac-4369-7119-a77e5108578b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <b4d0b274-23ac-4369-7119-a77e5108578b@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Martin Koegler <martin.koegler@chello.at>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

SF Markus Elfring wrote:
> A local variable was set to an error code in two cases before a concrete
> error situation was detected.

And why would that be a problem?

http://yarchive.net/comp/linux/error_jumps.html

> -	ret = -EBUSY;
> -	if (state.busy)
> +	if (state.busy) {
> +		ret = -EBUSY;
>  		goto out;
> +	}


Regards,
Clemens
