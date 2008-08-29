From: Liam Girdwood <lrg@kernel.org>
Subject: Re: get rid of controls with snd_ctl_remove
Date: Fri, 29 Aug 2008 21:10:58 +0100
Message-ID: <1220040658.6499.81.camel@odin>
References: <200808291454.42441.harryrat@postnuklear.de>
	<s5hhc94gel4.wl%tiwai@suse.de> <1220015812.6499.42.camel@odin>
	<s5h8wuggcqm.wl%tiwai@suse.de> <1220018193.6499.49.camel@odin>
	<s5htzd3g4db.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id E7A4D2434D
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Aug 2008 22:11:03 +0200 (CEST)
In-Reply-To: <s5htzd3g4db.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Harald Radke <harryrat@postnuklear.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2008-08-29 at 18:42 +0200, Takashi Iwai wrote:
> At Fri, 29 Aug 2008 14:56:33 +0100,
> Liam Girdwood wrote:

> > Yes, exactly :) We can now add this to our machine drivers to disable
> > never used controls (for each machine) and also call this when scenario
> > changes too.
> > 
> > Even more interestingly, it could also be called by DAPM......
> 
> Good to hear that.  Just let me know if you need this in the upstream.
> I don't want to push such an API addition too early before any use.

I agree, although I'm now not is a position to test anything atm (no
hardware until later next week). 

Harald, could you give this a try with your WM8750 based device. Please
feel free to mail with any questions you may have re WM8750 mixers.

Thanks

Liam
