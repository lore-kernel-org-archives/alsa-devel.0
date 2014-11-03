From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 1/2] ALSA: echoaudio: add reference of struct
 echoaudio
Date: Mon, 03 Nov 2014 07:08:08 -0800
Message-ID: <1415027288.17743.16.camel@perches.com>
References: <1415010853-4334-1-git-send-email-sudipm.mukherjee@gmail.com>
	 <s5hwq7c1i7k.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hwq7c1i7k.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2014-11-03 at 15:17 +0100, Takashi Iwai wrote:
> At Mon,  3 Nov 2014 16:04:12 +0530,
> Sudip Mukherjee wrote:
> > 
> > added reference of struct echoaudio to free_firmware function.
> > this structure will be later used to get a reference of the card
> > when converting snd_printk to dev_* in the next patch of the series.
> > 
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> 
> Thanks, now applied both.  Though, I noticed that there is also a
> dev_notice() usage that should be also dev_dbg().  Corrected such
> lines in my side.

Are any of these changes going to cause a
null pointer dereference of chip->card->dev?

ftrace exists and is generic.

Several of these seem to be function tracing
style uses and should just be deleted instead.
