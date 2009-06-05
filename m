From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and
	add	Left_J support
Date: Fri, 5 Jun 2009 19:26:30 +0200
Message-ID: <20090605172630.GG26148@buzzloop.caiaq.de>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090603131819.GQ26148@buzzloop.caiaq.de>
	<37b631400906040207o169abbc2ob33100879ac68911@mail.gmail.com>
	<1719ee7f0906040244t3890b069s5039c3f0c8bbe09a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id DA6181037F4
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Jun 2009 19:26:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1719ee7f0906040244t3890b069s5039c3f0c8bbe09a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Shen <boshen9@gmail.com>
Cc: alsa-devel@alsa-project.org, bshen9@marvell.com, eric.y.miao@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

Hi Paul,

sorry for the delay.

On Thu, Jun 04, 2009 at 05:44:55PM +0800, Paul Shen wrote:
> > The tdm time slot configuration needs to be set again in my board support
> > code just like in your example: snd_soc_set_tdm_slot(cpu_dai, 3, 2). And
> > the PXA_SSP_DIV_SCR value needed to be doubled from 4 to 8.
> >
> I tested  with below  codes to set the cpu_dai  :
> 
> format = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
>                          SND_SOC_DAIFMT_CBS_CFS | PXA_SSP_FRM_64FS;

Ah - the PXA_SSP_FRM_64FS is the detail I missed. With that option set,
my system works well, so I'm generally fine with the changes.

However, I proposed a generic way (not pxa/ssp specific) to let the
format flags carry the information about such frame format details some
months ago and the approach was rejected because there are already too
many ways to let the DAI know about this. In particular, the DIV_SCR
(serial clock rate divider) is used to propagate the base frequency
ratio and together with other options, you can find out the desired
frame format.

In my implementation, the '32 bit over 64fs case' was detected with this
condition in pxa_ssp_hw_params():

  (scr == 4) && (snd_pcm_format_physical_width(params_format(params)) == 16)

Now, SCR isn't used at all any more but instead PXA_SSP_FRM_WIDTH()
handles the case. Eventually this might be a matter of taste, but if we
go this way, why shouldn't that definitions be in ASoC's generic
headers?

Anyway, the code looks much cleaner now :)

Thanks,
Daniel
