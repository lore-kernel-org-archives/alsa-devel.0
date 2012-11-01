From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] snd-es1968: remove pm_whitelist
Date: Thu, 1 Nov 2012 21:29:43 +0000
Message-ID: <20121101212943.3f9fa50a@pyramind.ukuu.org.uk>
References: <201211012155.54713.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201211012155.54713.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 1 Nov 2012 21:55:54 +0100
Ondrej Zary <linux@rainbow-software.org> wrote:

> pm_whitelist breaks suspend on all non-whitelisted cards for unknown purpose.
> Remove it. This fixes suspend on Terratec DMX and SF64-PCE2 cards.

Because lots of them broke laptops.

Why not just whitelist the ones you know works, given there are ones we
know doesn't so your patch is an instant regression guarantee ?

(and yes a blacklist might have been brighter but I don't know the
history and it's a bit late to fix)
