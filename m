From: "John Kacur" <jkacur@gmail.com>
Subject: Re: No pcm device?
Date: Mon, 20 Oct 2008 15:16:27 +0200
Message-ID: <520f0cf10810200616s2ead02cdg4c034de280cd716c@mail.gmail.com>
References: <520f0cf10810200534j3ccb84cag3e012c4e101de2fe@mail.gmail.com>
	<20081020124038.GB24360@sirena.org.uk>
	<520f0cf10810200551y9b4b6c9xc67f7b025497b96e@mail.gmail.com>
	<20081020130200.GC24360@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 5701E2450C
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 15:16:46 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so1824366wfg.23
	for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2008 06:16:27 -0700 (PDT)
In-Reply-To: <20081020130200.GC24360@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 20, 2008 at 3:02 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Mon, Oct 20, 2008 at 02:51:04PM +0200, John Kacur wrote:
>> On Mon, Oct 20, 2008 at 2:40 PM, Mark Brown <broonie@sirena.org.uk> wrote:
>
>> >> There is however no sound card, thus no PCM device. Now the question
>> >> is how to proceed? In other words what kind of minimal PCM layer do I
>> >> need if any?
>
>> > Could you please clarify what you're attempting to do here?
>
>> On a simple level, I'm just trying to provide sound, by implementing
>> an alsa driver. I've implemented a low-level library that can
>> manipulate all my hardware's i2s registers, and I've been mirroring
>> other alsa-soc drivers, and I'm at the point where I'm scratching my
>> head over what to do about PCM. The confusion to me, is that the code
>> seems to describe actually hardware - and the only thing I can think
>> of it what my hardware i2s is capable of transmitting, does that sound
>> right?
>
> I think you've misunderstood how this is supposed to work.  None of the
> drivers for I2S or DMA controllers are responsible for creating a sound
> card by themselves.  They provide support for the features of the I2S
> or DMA controller but then rely on a separate machine driver to describe
> how they are actually connected into the system.
>
> There's some documentation of the model that's being used here in:
>
>        Documentation/sound/alsa/soc
>
> In your case you'll want to implement I2S and DMA drivers for your
> platform and a codec driver for the MAX5556 (looking at the datasheet it
> has no control of its own but you'll need to provide a DAI for it) and
> then provide a machine driver which connects them together.
>

I've surely misunderstood a thing or two without question. :)
However, I have read all of the documentation in
Documentation/sound/alsa/soc, and more than once. And I've been
reading the code for the ASoC drivers as well, and have been trying to
emulate it, especially, the code in sound/soc/s3c24xx and
sound/soc/pxa (as well as davinci at first until I realized that it
was incomplete)

...but I'm still scratching my head when I look at files like
sound/soc/s3c24xx/s3c24xx-pcm.c
It appears to be part of the DAI that connects the i2s driver and
codec together? So, back to my current source of confusion, do I need
to implement some basic kind of pcm driver for my scenario?

Thank again for taking the time to answer all my somewhat confused questions.
