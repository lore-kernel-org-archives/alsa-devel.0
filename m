From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH RFC 1/1] ASoC: fsl_ssi: Make fifo watermark
 and maxburst settings device tree options
Date: Fri, 15 Jan 2016 09:03:28 -0800
Message-ID: <CAG5mAdy553q4Te5755575WaiLxGRp43h=WVH6QzF7idsaCnhbg@mail.gmail.com>
References: <1452788982-11583-1-git-send-email-caleb@crome.org>
 <20160114201858.GA17567@Asurada-Nvidia> <56984BE7.2050303@tabi.org>
 <20160115131325.GW6588@sirena.org.uk> <5698F846.5080604@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f196.google.com (mail-io0-f196.google.com
 [209.85.223.196])
 by alsa0.perex.cz (Postfix) with ESMTP id CEC46260439
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 18:03:48 +0100 (CET)
Received: by mail-io0-f196.google.com with SMTP id k127so52476047iok.1
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 09:03:48 -0800 (PST)
In-Reply-To: <5698F846.5080604@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: devicetree@vger.kernel.org, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 15, 2016 at 5:46 AM, Timur Tabi <timur@tabi.org> wrote:
> Mark Brown wrote:
>>>
>>> >I admit it's a grey area, but the hardware doesn't work if you use the
>>> > wrong
>>> >value, and it is a fixed value per device.  A p1022ds would use a
>>> > different
>>> >value than in in i.MX6, and once you pick a value, it's the same no
>>> > matter
>>> >which sample rate, buffer size, etc you choose.
>
>
>> Caleb's original message suggested this was rate dependant.
>


>
> Yeah, I just noticed that.  In that case, I agree that a device tree
> property is inappropriate, unless it's an array that contains tuples of
> sample rates and watermark/maxburst settings.  That would get unwieldy very
> easily, though.


The rate dependance is only a *potential* issue.  I suspect that a
value of 4 should be functional for all rates and chips.  The only
trade off is more DMA requests/bursts.

In a typical 15 word fifo, 48kHz, stereo, single fifo DMA system,  the
old value was 15-2 = 13, which would mean 7385 13-word DMA
bursts/second.    A new value of 4 would mean 24,000 4-word DMA
bursts/second.

Is that consequential for anybody?  It's about the same total
bandwidth on the system, but just broken up into smaller chunks (I
don't know what the overhead is for a DMA burst)

In a high channel count system (16 channels @ 48kHz), the old value
doesn't work, and the new value would mean 192,000 4-word DMA
bursts/second, which works on my MX6.  So given that 192000 works
fine, I'm not sure that the difference in a typical system would
matter at all.

If nobody objects, we can just set the value to 4 and be done with it.

Another question:  is the watermark ever going to be different than
maxburst?  Is there any reason to have them different?

-Caleb
