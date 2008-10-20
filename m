From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: No pcm device?
Date: Mon, 20 Oct 2008 15:01:16 +0100
Message-ID: <20081020140115.GE24360@sirena.org.uk>
References: <520f0cf10810200534j3ccb84cag3e012c4e101de2fe@mail.gmail.com>
	<20081020124038.GB24360@sirena.org.uk>
	<520f0cf10810200551y9b4b6c9xc67f7b025497b96e@mail.gmail.com>
	<20081020130200.GC24360@sirena.org.uk>
	<520f0cf10810200616s2ead02cdg4c034de280cd716c@mail.gmail.com>
	<20081020132424.GD24360@sirena.org.uk>
	<520f0cf10810200654r585fa7e5k848e243e211a671e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 41B9424533
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 16:01:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <520f0cf10810200654r585fa7e5k848e243e211a671e@mail.gmail.com>
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

On Mon, Oct 20, 2008 at 03:54:32PM +0200, John Kacur wrote:
> On Mon, Oct 20, 2008 at 3:24 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> Here is the outline of my design. So, if I understand you correctly,
> my jade-pcm.c file is just for implementing dma. Basically, I have a
> simple scenario there is no capture, just read a wav file from user
> space, transport it through i2s to the codec.

> Machine Code (Jade)
> -------------------
> jade-xxsvideo.c
> jade-xxsvideo.h

I gather that both your machine and your CPU are called jade?  That
makes things a little less clear than they normally would be.

> Platform Code
> -------------
> jade-pcm.c
> jade-pcm.h

Normally you'd have a separate I2S driver here - from this...

> DAI (Digital Audio Interface)
> -----------------------------
> 	.cpu_dai 	= &jade_i2s_dai
> 		jade-i2s.c
> 		jade-i2s.h
> 	.codec_dai	= &max5556_dai
> 		max5556.c
> 		max5556.h

...it looks like that's the case, in which case everything looks
sensible.
