From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: No pcm device?
Date: Mon, 20 Oct 2008 14:02:01 +0100
Message-ID: <20081020130200.GC24360@sirena.org.uk>
References: <520f0cf10810200534j3ccb84cag3e012c4e101de2fe@mail.gmail.com>
	<20081020124038.GB24360@sirena.org.uk>
	<520f0cf10810200551y9b4b6c9xc67f7b025497b96e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 77265103805
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 15:02:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <520f0cf10810200551y9b4b6c9xc67f7b025497b96e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Kacur <jkacur@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 20, 2008 at 02:51:04PM +0200, John Kacur wrote:
> On Mon, Oct 20, 2008 at 2:40 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> >> There is however no sound card, thus no PCM device. Now the question
> >> is how to proceed? In other words what kind of minimal PCM layer do I
> >> need if any?

> > Could you please clarify what you're attempting to do here?

> On a simple level, I'm just trying to provide sound, by implementing
> an alsa driver. I've implemented a low-level library that can
> manipulate all my hardware's i2s registers, and I've been mirroring
> other alsa-soc drivers, and I'm at the point where I'm scratching my
> head over what to do about PCM. The confusion to me, is that the code
> seems to describe actually hardware - and the only thing I can think
> of it what my hardware i2s is capable of transmitting, does that sound
> right?

I think you've misunderstood how this is supposed to work.  None of the
drivers for I2S or DMA controllers are responsible for creating a sound
card by themselves.  They provide support for the features of the I2S
or DMA controller but then rely on a separate machine driver to describe
how they are actually connected into the system.

There's some documentation of the model that's being used here in:

	Documentation/sound/alsa/soc

In your case you'll want to implement I2S and DMA drivers for your
platform and a codec driver for the MAX5556 (looking at the datasheet it
has no control of its own but you'll need to provide a DAI for it) and
then provide a machine driver which connects them together.
