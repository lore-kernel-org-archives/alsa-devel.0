From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Mon, 12 Apr 2010 13:11:13 +0100
Message-ID: <q2z74fd948d1004120511hebf19eaauc41ee9ed25dea19e@mail.gmail.com>
References: <20100407090623.GN30807@buzzloop.caiaq.de>
	 <Pine.LNX.4.44L0.1004071036060.1779-100000@iolanthe.rowland.org>
	 <87sk719hbm.fsf@basil.nowhere.org>
	 <20100412111439.GU30801@buzzloop.caiaq.de>
	 <20100412115300.GM18855@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100412115300.GM18855@one.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Daniel Mack <daniel@caiaq.de>, Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12 April 2010 12:53, Andi Kleen <andi@firstfloor.org> wrote:
>> Which is exactly what usb_buffer_alloc() does already. So at least for
>> x86 you say this is the right thing to do? However, we don't necessarily
>> need coherent memory on other platforms, which is why I hessitate to
>> enforce that type of memory for all transfer_buffer allocations.
>
> Yes today it's faster at least.
>
> Probably we should have better interfaces for this, but we don't.
>
>>
>> > Or just use GFP_KERNEL and pci_map_* later.
>>
>> The USB core does this already, but at least on Pedro's machine, this
>> seems unsufficient. Unfortunately, I can't reproduce the issue yet, even
>> with more than 4GB of RAM installed.
>
> Then something must be broken in Pedro's system and likely other drivers
> will also not work. I don't think it should be worked around in the USB layer.
>
> -Andi


I'm not putting into question whether something is broken in my
system, but if it is, it must be the ICH9 platform, because I was able
to reproduce it in another laptop.

My laptop is a Lenovo T400 and I was able to reproduce it in a Acer
Aspire 59xx (I don't remember the exact model, but it is one of the
new ones with 15.6 inch - i think they all use the same base). And the
common thing between them is the ICH9 platform.

The only which solved this problem was the first patch sent to me by
Daniel Mack. I've been using it for days straight and it works fine.

Pedro
