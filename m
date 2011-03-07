From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH v2] intel8x0m: wait a bit before warm reset check
Date: Mon, 07 Mar 2011 11:36:34 +0100
Message-ID: <1299494225.2470.21.camel@t41.thuisdomein>
References: <1299366106.2470.5.camel@t41.thuisdomein>
	 <alpine.LNX.2.00.1103060105550.6297@swampdragon.chaosbits.net>
	 <s5hei6jgsq9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hei6jgsq9.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jesper Juhl <jj@chaosbits.net>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-03-07 at 10:55 +0100, Takashi Iwai wrote:
> Also, as mentioned earlier, it's better to use usleep_range() than
> udelay().  There is no hard upper-limit in this case, and any longer
> sleep works.

So something like, say, usleep_range(500, 1000) should be OK?


Paul
