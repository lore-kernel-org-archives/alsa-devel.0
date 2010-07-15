From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH 1/3] ASoC: ak4642: make sure
 snd_soc_codec value for ak4642
Date: Thu, 15 Jul 2010 10:38:42 +0100
Message-ID: <20100715093842.GG23529@rakim.wolfsonmicro.main>
References: <w3pvd8ig9q4.wl%kuninori.morimoto.gx@renesas.com>
	<w3ptyo2g9or.wl%kuninori.morimoto.gx@renesas.com>
	<20100714081311.GA17071@rakim.wolfsonmicro.main>
	<w3p8w5dmw3j.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 938A41038F2
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 11:38:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3p8w5dmw3j.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 15, 2010 at 09:23:33AM +0900, Kuninori Morimoto wrote:

> > Could you be more specific about what you're trying to do here?  This
> > patch adds additional uses of the global variable for finding the codec
> > which is pretty much the opposite direction to where we want to go.  Is
> > it possible you need multi-codec support?
> Now, I would like to use 2 codecs (ak4642/da7210) in same time.
> But if I select both 2 on .config (fsi-ak4642 / fsi-da7210),
> kernel say WARNING which say
> I can not use 2 soc-audio
> (or can I select both ?)

You need to give them both different device numbers - soc-audio.0 and
soc-audio.1 - rather than giving them both -1.

> So, I modified snd_soc_card :: dai_link
> But, if I use "soc_codec_dev_ak4642" for snd_soc_device :: codec_dev,
> snd_soc_codec of function parameter of "da7210" was ak4642's codec.
> This mean register access of da7210 use ak4642's i2c address.
>  -> o da7210 doesn't work
>     o ak4642 register will be broken

Having more than one CODEC in the same card is not currently supported,
you need the multi-component work Liam is doing (which will hopefully be
merged in the next week or two).

> I'm not goot at detail of soc-audio.
> what should I do in this case ?

Are the two CODECs connected in any way on the board or do you
essentially have two separate sound cards on the board?  If it's the
former you should use multi-component.  If it's the latter you should
just create two separate sound cards.
