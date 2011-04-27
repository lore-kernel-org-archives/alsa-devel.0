From: Andrew Clayton <andrew@digital-domain.net>
Subject: Re: 2.6.38.4 broke my audio
Date: Wed, 27 Apr 2011 02:05:40 +0100
Message-ID: <20110427020540.25803862@omega.digital-domain.net>
References: <20110424113037.11af0b04@omega.digital-domain.net>
	<20110425000126.GA18681@suse.de>
	<s5htydmhed2.wl%tiwai@suse.de>
	<20110425173409.GA32047@suse.de>
	<s5hpqoagjtf.wl%tiwai@suse.de>
	<20110426011212.77630c68@omega.digital-domain.net>
	<s5hwrihb2wm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hwrihb2wm.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg KH <gregkh@suse.de>, Emmanuel Benisty <benisty.e@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Apr 2011 14:41:45 +0200, Takashi Iwai wrote:

> At Tue, 26 Apr 2011 01:12:12 +0100,
> Andrew Clayton wrote:
> > 
> > On Mon, 25 Apr 2011 22:25:16 +0200, Takashi Iwai wrote:
> > 
> > > Andrew, could you give alsa-info.sh outputs on your machine?
> > > Preferably, the outputs both before and after the kernel update
> > > would be really helpful.
> > 
> > Sure, here you go.
> > 
> > The first one is from 2.6.38.3 where the audio is fine. The second
> > is from 2.6.38.4 where the audio is really quiet.
> 
> Thanks.  In your case, "Speaker" mixer volume is set to zero.
> Does the following fix the output?
> 
> 	% amixer -c0 set Speaker 100%

Ah, indeed it does.

> Takashi

Cheers,
Andrew
