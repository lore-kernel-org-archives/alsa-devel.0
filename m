From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH RFC 00/13] Adding SPDIF support
	to	kirkwood-i2s
Date: Fri, 30 Aug 2013 10:26:07 +0200
Message-ID: <5220571F.5020006@metafoo.de>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com> <20130805115947.GA9858@sirena.org.uk>
 <51FFA348.2010503@gmail.com> <51FFB267.3030107@metafoo.de>
 <87wqnzhek5.wl%kuninori.morimoto.gx@renesas.com>
 <87li3jr6et.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-137.synserver.de (smtp-out-137.synserver.de
 [212.40.185.137])
 by alsa0.perex.cz (Postfix) with ESMTP id 60FAB2619E6
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2013 10:24:37 +0200 (CEST)
In-Reply-To: <87li3jr6et.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/30/2013 09:20 AM, Kuninori Morimoto wrote:
> 
> Hi
> 
>>> Kuninori Morimoto started working on a xlate callback for CODECs and DAIs
>>> some time ago[1]. If nobody else is going to pick this up I'm probably going
>>> to continue his work on this.
>>
>> Thank you for your offer about above.
>> I'm sorry for my late work for xlate callback.
>> but, unfortunately, I busy now, so, I can't work for it now.
>> I'm very happy if someone/you can work for it.
> 
> My understanding for this ASoC DT support milestone is that
> 
>  1) merge codec/component
>  2) add .of_xlate_dai_name on it
>  3) add DT support
> 
> But, do you think 1) is possible ?
> Becouse, now, too many functions are based on/using "codec"
> struct snd_soc_codec / struct snd_soc_codec_driver.
> In reality, merging these is super difficult IMO.
> 
> But adding .of_xlate_dai_name on each codec/component
> is not difficult, and, I can do it immediately.
> 
> what is your opinion ?

The idea is to use the component struct as a base class for the codec and
platform struct. So drivers will keep seeing what they see now and don't
need to be updated. Lots of the fields that can be shared between component,
platform and codec are only used by the core.

- Lars
