From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] ALSA: firewire-tascam: off by one in identify_model()
Date: Sat, 17 Oct 2015 15:02:32 +0300
Message-ID: <20151017120232.GU7289@mwanda>
References: <20151015181828.GC3163@mwanda>
 <s5hlhb1dcsx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hlhb1dcsx.wl-tiwai@suse.de>
Sender: kernel-janitors-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 17, 2015 at 12:11:58PM +0200, Takashi Iwai wrote:
> On Thu, 15 Oct 2015 20:18:29 +0200,
> Dan Carpenter wrote:
> > 
> > In the original code, we potentially put a NUL character in model[8] and
> > it caused a static checker warning.  We can put the NUL in model[7]
> > instead.
> 
> I guess it's better to expand model[] to 9 bytes instead.  The logic
> is to retrieve the string from the config rom, and it's up to 8
> letters.

Ok.  I will resend.

regards,
dan carpenter

