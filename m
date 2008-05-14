From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: 2.6.26-rc1 regression: ISA DMA broken (bisected)
Date: Wed, 14 May 2008 21:09:10 +0200
Message-ID: <482B38D6.5030804@keyaccess.nl>
References: <4823AAF2.7070102@keyaccess.nl> <482B0807.9050404@keyaccess.nl>
	<482B3274.2060006@keyaccess.nl>
	<200805141250.57115.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id C7C2C24512
	for <alsa-devel@alsa-project.org>;
	Wed, 14 May 2008 21:07:29 +0200 (CEST)
In-Reply-To: <200805141250.57115.bjorn.helgaas@hp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: alsa-devel@alsa-project.org

On 14-05-08 20:50, Bjorn Helgaas wrote:

> On Wednesday 14 May 2008 12:41:56 pm Rene Herman wrote:

>> You're in a maze of struct device *s, all alike... I was passing the 
>> pnp_card->dev instead of the initialized pnp_dev->dev.
>>
>> And, not doing so brings out a difference between ISAPnP and legacy ISA 
>> again insofar that legacy ISA does not consist of cards with multiple 
>> devices. We just have the single struct device * for the ISA device.
>>
>> This therefore would be the easiest solution (and works fine) but seems 
>> a bit of a hack. Bjorn, do you have an opinion? If I abstract things out 
>> a bit more I might be able to do this nicer. One might on the other hand 
>> argue that the dma_mask is going to be constant for all card devices so 
>> might as well just use the card dev.
> 
> I agree, it seems a bit of a hack to use a DMA mask from the card
> instead of from the device, since the driver should be programming
> the device to do the DMA.
> 
> But I know very little about pnp_card in general, so don't attach too
> much weight to my opinion.

Okay, I'll sit on this for a bit. Right now we're using a global device even 
but this is exactly about cleaning that up so couldn't convince myself. Will 
see what happens when I try to make it nice...

Rene.
