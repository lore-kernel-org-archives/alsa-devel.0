From: Joe Perches <joe@perches.com>
Subject: Re: [alsa-devel] Improving or replacing snd_printk()
Date: Fri, 31 May 2013 10:06:38 -0700
Message-ID: <1370019998.10556.82.camel@joe-AO722>
References: <s5ha9nbinre.wl%tiwai@suse.de>
	 <Pine.LNX.4.44L0.1305311014330.1276-100000@iolanthe.rowland.org>
	 <s5hwqqf1an3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hwqqf1an3.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2013-05-31 at 16:34 +0200, Takashi Iwai wrote:
> Also, another expected problem is that neither card->card_dev nor
> card->dev are set when snd_card_err() is called.  Many drivers set the
> device pointers at the late stage just before the device
> registration.  So, systematic replacements won't work as expected in
> many cases.  (The same is applied for replacement with dev_*(), too.)

If all the pointers are null, then the logging function could
use pr_<level> and %pf, __builtin_return_addr() or another
method to look up the module name.
