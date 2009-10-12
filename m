From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: dev_* output functions and ASoC codecs
Date: Mon, 12 Oct 2009 11:48:49 +0100
Message-ID: <20091012104849.GA7994@rakim.wolfsonmicro.main>
References: <8bd0f97a0910051718w5d97df8dr443917def9da9ac@mail.gmail.com>
	<20091006102033.GC27168@sirena.org.uk>
	<3c17e3570910111926u186586cdq2646d5aaade3121a@mail.gmail.com>
	<20091012093601.GA22233@sirena.org.uk>
	<3c17e3570910120334u6646b031vb5300645da8b6ce4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 697CF10387E
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Oct 2009 12:48:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3c17e3570910120334u6646b031vb5300645da8b6ce4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: "Cai, Cliff" <Cliff.Cai@analog.com>, alsa-devel@alsa-project.org, Mike Frysinger <vapier.adi@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 12, 2009 at 06:34:56PM +0800, Barry Song wrote:
> On Mon, Oct 12, 2009 at 5:36 PM, Mark Brown

> In codec:
> "static struct snd_soc_codec *wm8903_codec" is a global variable to
> describe a codec.  The global variable limit the codec driver can only
> support one to work.

Right, currently the WM8903 driver only allows one instance - this will
be addressed in the future but for now the core doesn't really support
this.  Addressing this is the main reason why the drivers need to be
converted away from the old style of probing to using the device model
and supplying struct deviecs - without doing that it's not possible to
support more than one instance of the same CODEC.

> In CPU dai:
> in case there are two same I2S interfaces connecting two same wm8903,
> then an array with two elements for CPU dai is needed.

I'm sorry, I can't quite parse what you're saying here.  If you have two
CPU DAIs then you need an array to hold them but that seems self evident
so is presumably not what you mean?

> In machin driver:
> snd_soc_dai_link connect the multi same CPU dai and codec dai together.
> 
> If we don't use num_links =2, we need to call
> platform_device_alloc("soc-audio",...)/platform_device_add() twice
> with duplicated struct snd_soc_device.

Again, I'm not 100% clear what you're saying here.  If you have a CODEC
with two DAIs which you need to connect to two CPU drivers then you will
need two dai_links.  If you have two unrelated sound subsystems in your
system then you should end up with two separate sound devices at the
ALSA level.  I understand that this currently works OK, though it's not
really supported.
