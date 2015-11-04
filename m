From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V1 2/3] ASoC: fsl_spdif: spba clk is needed
 by spdif device
Date: Wed, 4 Nov 2015 09:31:28 -0800
Message-ID: <20151104173127.GA3794@Asurada-CZ80>
References: <cover.1442469788.git.shengjiu.wang@freescale.com>
 <5fd6e6c463c2e8d141cf4b485f585f007a71442e.1442469788.git.shengjiu.wang@freescale.com>
 <20150917110154.GC12027@sirena.org.uk>
 <20150917175407.GA2544@Asurada-CZ80>
 <20150919135040.GM12027@sirena.org.uk>
 <20151010102657.GC25804@shlinux2>
 <CAOMZO5AY7wZ6mJEAW0rBZv_grgbnBKxSa5UZTdBRx79M96mTXw@mail.gmail.com>
 <20151010203556.GA2522@Asurada-CZ80>
 <20151104083442.GA21193@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 48A2B260481
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 18:31:35 +0100 (CET)
Received: by pabfh17 with SMTP id fh17so58704157pab.0
 for <alsa-devel@alsa-project.org>; Wed, 04 Nov 2015 09:31:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151104083442.GA21193@shlinux2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 04, 2015 at 04:34:44PM +0800, Shengjiu Wang wrote:
> I discussed this issue with IC team. The SPBA bus has 3 master port,
> one is for SDMA, one is for MCU (ARM core), the third one is for DSP (
> currently there is no connection for DSP). Any two master port are used
> simultaneously, there will be arbitration issue when SPBA clock is not
> enabled.
> 
> So I think it is better put SPBA clock in Audio IP, because if there is
> DSP master port + MCU master used, there will be issue too. (DSP master 
> port is not used in i.MX chip). Anyway I think put it in SDMA driver is
> not good choice, if SDMA is removed, there will be still issue. Put it
> in Audio IP maybe more safe.

It's really ambiguous here as it's not easy to say which side is
the best. I'm personally okay if you insist so. However, you need
to refine the patch as I suggested in my first reply and document
it well: Apparently, "dma" is not a good name for this clock. And
it should be an optional property so as not to break the old DTBs.
And only the platforms (check DT compatible) that use the arbiter
can fetch the clock or get a warning when not present in the DTB.

Thanks
Nicolin
