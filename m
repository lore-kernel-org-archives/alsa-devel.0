From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH] snd-es1968: remove pm_whitelist
Date: Thu, 1 Nov 2012 22:58:30 +0100
Message-ID: <201211012258.31310.linux@rainbow-software.org>
References: <201211012155.54713.linux@rainbow-software.org> <20121101212943.3f9fa50a@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121101212943.3f9fa50a@pyramind.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thursday 01 November 2012 22:29:43 Alan Cox wrote:
> On Thu, 1 Nov 2012 21:55:54 +0100
>
> Ondrej Zary <linux@rainbow-software.org> wrote:
> > pm_whitelist breaks suspend on all non-whitelisted cards for unknown
> > purpose. Remove it. This fixes suspend on Terratec DMX and SF64-PCE2
> > cards.
>
> Because lots of them broke laptops.
>
> Why not just whitelist the ones you know works, given there are ones we
> know doesn't so your patch is an instant regression guarantee ?
>
> (and yes a blacklist might have been brighter but I don't know the
> history and it's a bit late to fix)

I wonder what does the suspend/resume code break? Currently, all 
non-whitelisted cards are broken (not working after resume).

The problem with adding cards to the whitelist is that Terratec DMX has 
generic subsystem ID:
ESS Technology ES1978 Maestro 2E [125d:1978] (rev 10)
Subsystem: ESS Technology ES1978 Maestro 2E [125d:1978]

Adding this to the whitelist does not look like a good idea...

-- 
Ondrej Zary
