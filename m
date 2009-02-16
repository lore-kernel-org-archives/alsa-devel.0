From: York Sun <yorksun@freescale.com>
Subject: Re: dma buffer format
Date: Mon, 16 Feb 2009 16:57:10 -0600
Message-ID: <1234825030.28678.10.camel@oslab-l1>
References: <1234822919.23239.20.camel@oslab-l1> <s5h1vtykohm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 239342443C
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 23:57:11 +0100 (CET)
In-Reply-To: <s5h1vtykohm.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2009-02-16 at 23:26 +0100, Takashi Iwai wrote:
> At Mon, 16 Feb 2009 16:21:59 -0600,
> York Sun wrote:
> > 
> > Takashi,
> > 
> > I am now working on a surround sound driver for the first time. I am
> > confused by the packed format of dma buffer. If the channel number is 6,
> > is the buffer filled with data as
> > 
> > front left, front right, rear left, rear right, center, LFE
> > 
> > or
> > 
> > front left, rear left, center, front right, rear left, LFE?
> 
> It's supposed to be FL/FR/RL/RR/C/LFE.
> That's so to be consitent with 4 channels (just cut the last two
> channels).
> 
Thanks for the quick reply. I am curious if it is the only format
supported, or can it be customized?


York
