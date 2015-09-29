From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: Document DAI signal polarity
Date: Tue, 29 Sep 2015 14:34:33 -0700
Message-ID: <CAOMFOmW3RCcrGn6o0xsQWREz5gqVT_ucjO5uDAf=zexZrxWEdA@mail.gmail.com>
References: <1441054258-33200-1-git-send-email-anatol.pomozov@gmail.com>
 <20150918135427.GI12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f43.google.com (mail-vk0-f43.google.com
 [209.85.213.43])
 by alsa0.perex.cz (Postfix) with ESMTP id C301F265854
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 23:34:34 +0200 (CEST)
Received: by vkfp126 with SMTP id p126so13661500vkf.3
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 14:34:33 -0700 (PDT)
In-Reply-To: <20150918135427.GI12027@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, =?UTF-8?B?6Zmz56uL5bOw?= <albertchen@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Hi

On Fri, Sep 18, 2015 at 6:54 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Aug 31, 2015 at 01:50:58PM -0700, Anatol Pomozov wrote:
>
>> Per discussion at [1] currently there is no clear definition of what is FSYNC polarity.
>> Different drivers use its own definition of what is "normal" and what is "inverted"
>> fsync in different modes. This leads to compatibility problems between drivers.
>
> Please keep changelogs wrapped at under 80 columns as is covered in
> SubmittingPatches and please write free standing changelogs that don't
> require reference to external discussions unless there is a strong
> reason to do so.  This makes both the e-mails and the git changelogs
> easier to read, ensuring that people don't need to go online to read
> things and links don't go bad.

I see that external links quite actively used by developers:
$ git log --grep Link

but no problem, I can inline info into the commit description.

>
>> + * For BCLK:
>> + *  - "normal" polarity means signal sensing happens at rising edge of BCLK
>> + *  - "inverted" polarity means signal sensing happens at falling edge of BCLK
>
> This is OK, though it's more normal to say that data "is available" or
> "is sampled" - the term "signal sensing" is a bit unusual.

Done.

>
>> + * For FSYNC:
>> + *  - "normal" polarity means frame starts at rising edge of FSYNC
>> + *  - "inverted" polarity means frame starts at falling edge of FSYNC
>
> This isn't true (or at least isn't clear) for I2S based modes, normally
> the left channel is thought of as the first channel sent and the left
> channel starts on the falling edge of LRCLK, not the rising edge (which
> signals the start of the right frame).

In the I2S docs/specs I found I2S format has frames like you described
- starts at falling edge, left channel first. Per description above
this will have "negative" FSYNC polarity.

The I2S docs do not define frame polarity. Polarity is purely Linux
driver thing and we can choose definition we want.

>  It is true for DSP based modes.
>
> It's probably going to be more sensible to define the modes and then
> define inversion relative to the definition of the modes (which is
> basically what the existing documentation is doing).  I think what we
> really need here is an explicit definition of the DSP modes.

The beauty of rule "positive polarity is when frame starts at rising
FSYNC edge" that it easily applicable to all formats (I2S and DSP-*).

Or you keep another definition of polarity in mind?
