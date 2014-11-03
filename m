From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v2 1/2] ALSA: echoaudio: add reference of struct echoaudio
Date: Mon, 3 Nov 2014 22:22:43 +0530
Message-ID: <20141103165243.GA7562@sudip-PC>
References: <1415010853-4334-1-git-send-email-sudipm.mukherjee@gmail.com>
 <s5hwq7c1i7k.wl-tiwai@suse.de>
 <1415027288.17743.16.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415027288.17743.16.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 03, 2014 at 07:08:08AM -0800, Joe Perches wrote:
> On Mon, 2014-11-03 at 15:17 +0100, Takashi Iwai wrote:
> > At Mon,  3 Nov 2014 16:04:12 +0530,
> > Sudip Mukherjee wrote:
> > > 
> > > added reference of struct echoaudio to free_firmware function.
> > > this structure will be later used to get a reference of the card
> > > when converting snd_printk to dev_* in the next patch of the series.
> > > 
> > > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > 
> > Thanks, now applied both.  Though, I noticed that there is also a
> > dev_notice() usage that should be also dev_dbg().  Corrected such
> > lines in my side.
> 
> Are any of these changes going to cause a
> null pointer dereference of chip->card->dev?
should not. while converting i have checked the place from where the particular function is called, to see if chip is valid there.
if chip is valid, then chip->card->dev should be ok. card is coming from snd_card_new and chip from snd_echo_create.
> 
> ftrace exists and is generic.
> 
> Several of these seem to be function tracing
> style uses and should just be deleted instead.

function tracing style uses means?
there are some prints which are printing the function name while printing the debug message.
are those function tracing style uses??

thanks
sudip
> 
> 
