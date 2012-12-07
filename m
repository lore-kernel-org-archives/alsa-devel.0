From: Padma Venkat <padma.kvr@gmail.com>
Subject: Re: [PATCH V2 1/2] ASoC: Samsung: Do not register samsung audio dma
 device as pdev
Date: Fri, 7 Dec 2012 13:47:30 +0530
Message-ID: <CAAgF-BdWSNpeh6nKeUsPwP-R19kZF9cbRm9akumjDFs74phyTA@mail.gmail.com>
References: <1354765837-3469-1-git-send-email-padma.v@samsung.com>
	<1354765837-3469-2-git-send-email-padma.v@samsung.com>
	<20121207064644.GI26070@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20121207064644.GI26070@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Padmavathi Venna <padma.v@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, sbkim73@samsung.com, lrg@ti.com, tiwai@suse.de, ben-linux@fluff.org, kgene.kim@samsung.com, ben@simtec.co.uk, lrg@slimlogic.co.uk, jassisinghbrar@gmail.com, anarsoul@gmail.com, graeme.gregory@wolfsonmicro.com, philipp.zabel@gmail.com, dgreenday@gmail.com, chripell@evolware.org, mcuelenaere@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Fri, Dec 7, 2012 at 12:16 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Dec 06, 2012 at 09:20:36AM +0530, Padmavathi Venna wrote:
>> Previously, the ASoC 'platform' (PCM/DMA) object was instantiated via a
>> platform_device. This didn't represent the hardware well, since there
>> was no separate hardware associated with this platform_device; it was a
>> virtual device with sole purpose to call snd_soc_register_platform().
>
> Looks good however this doesn't apply against my topic/samsung branch -
> can you please check if I need anything from Kukjin's tree?  Though I
> guess the easiest thing is just to wait until the merge window is over,
> we're near to the next release.

I will resend the patches re-based on your topic/samsung branch.

Thanks
Padma
