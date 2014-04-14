From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/1] driver/snd: es18xx driver should use udelay error
Date: Mon, 14 Apr 2014 14:00:40 +0200
Message-ID: <534BCDE8.1090202@ladisch.de>
References: <1397468588-18559-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397468588-18559-1-git-send-email-zhen-hual@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Li, Zhen-Hua" <zhen-hual@hp.com>, Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Li, Zhen-Hua wrote:
> udelay with more than 20000 may cause __bad_udelay.
> Use mdelay for instead.
>
>  #ifdef AVOID_POPS
>  		/* Avoid pops */
> -                udelay(100000);
> +		mudelay(100);

This will not compile.  Please test with AVOID_POPS enabled.


Regards,
Clemens
