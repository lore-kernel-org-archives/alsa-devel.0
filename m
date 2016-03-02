From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] ASoC: imx-wm8958: add imx-wm8958
 machine driver
Date: Tue, 1 Mar 2016 20:38:22 -0800
Message-ID: <20160302043821.GA3361@Asurada-CZ80>
References: <6f90780124a7f5bf31452623fdf04225873fc711.1456457898.git.zidan.wang@freescale.com>
 <20160302041101.GZ18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f182.google.com (mail-pf0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 07E992606F5
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 05:38:28 +0100 (CET)
Received: by mail-pf0-f182.google.com with SMTP id 4so47794888pfd.1
 for <alsa-devel@alsa-project.org>; Tue, 01 Mar 2016 20:38:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160302041101.GZ18327@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 02, 2016 at 01:11:01PM +0900, Mark Brown wrote:

> > +	[VOICE_DAI] =   {
> > +			.name = "Voice",
> > +			.stream_name = "Voice",
> > +			.cpu_dai_name = "snd-soc-dummy-dai",
> > +			.codec_name = "wm8994-codec",
> > +			.codec_dai_name = "wm8994-aif2",
> > +			.platform_name = "snd-soc-dummy",
> 
> Why are you mapping in dummy DAIs?  If these devices aren't connected
> then they're not connected and you shouldn't represent them.  If they
> are connected to something then describe those connections, possibly in
> followup patches if you have other devices you need to support upstream
> first.

>From his previous reply to me (he forgot to use reply-all), he
told me that he only tested the aif1 path in the release while
leaving aif2 and aif3 for future use.

In his schematics of the reference board, I found all three aifs
are "connected" but AIF2 and AIF3 are optional through jumpers.
So I think it might be better for him to make the driver flexible
by including all three aifs while creating dai-links depending on
the presence of corresponding cpu-dais.

Thanks
Nicolin
