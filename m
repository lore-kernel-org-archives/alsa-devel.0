From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: Re: [PATCH V2] ASoC: omap-hdmi: Use devm_snd_soc_register_component
Date: Wed, 9 Jul 2014 17:14:45 +0530
Message-ID: <CAKDJKT66hqeJBohXsr-knSeM6a2wo7J_eaz1WWjA=CFvGsEqHA@mail.gmail.com>
References: <1404838043-5095-1-git-send-email-badarkhe.manish@gmail.com>
	<53BCD799.7000700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <53BCD799.7000700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Peter,

On Wed, Jul 9, 2014 at 11:18 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 07/08/2014 07:47 PM, Manish Badarkhe wrote:
>> Replaced snd_soc_register_component with its devres equivalent,
>> devm_snd_soc_register_component.
>>
>> Signed-off-by: Manish Badarkhe <badarkhe.manish@gmail.com>
>
> Jut to make things easier I think we should not have this patch applied since
> Jyri's OMAP4+ HDMI audio rework series is going to delete this file.

Ok fine.

Thanks
Manish Badarkhe
