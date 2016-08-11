From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: Re: [PATCH -next] ASoC: sun4i-codec: Fix error return code in
 sun4i_codec_probe()
Date: Thu, 11 Aug 2016 22:15:27 +0800
Message-ID: <d48eceb4-c26d-3b3c-8577-1ba19a04b040@gmail.com>
References: <1470836554-11569-1-git-send-email-weiyj.lk@gmail.com>
 <CAGb2v67cVXWtM=AzeFcftnajSs=+C6F12P_EvnXHB=oKsAm5Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGb2v67cVXWtM=AzeFcftnajSs=+C6F12P_EvnXHB=oKsAm5Cw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Emilio Lopez <emilio@elopez.com.ar>, Hans De Goede <hdegoede@redhat.com>, ats@offog.org, fengguang.wu@intel.com, Linux-ALSA <alsa-devel@alsa-project.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi

On 08/10/2016 10:04 PM, Chen-Yu Tsai wrote:
> On Wed, Aug 10, 2016 at 9:42 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
>> Fix to return error code -ENOMEM instead of 0 when create card
>> failed, as done elsewhere in this function.
>>
>> Fixes: 45fb6b6f2aa3 ("ASoC: sunxi: add support for the on-chip
>> codec on early Allwinner SoCs")
>> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
>> ---
>>  sound/soc/sunxi/sun4i-codec.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
>> index 0e19c50..e741659 100644
>> --- a/sound/soc/sunxi/sun4i-codec.c
>> +++ b/sound/soc/sunxi/sun4i-codec.c
>> @@ -846,6 +846,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
>>         card = sun4i_codec_create_card(&pdev->dev);
>>         if (!card) {
>>                 dev_err(&pdev->dev, "Failed to create our card\n");
>> +               ret = -ENOMEM;
>>                 goto err_unregister_codec;
>>         }
>>
> This works, though it might be better to fix the create_card function and
> any custom functions called in there to pass back a proper error value.
>
Since sun4i_codec_create_card() can only failed when kmalloc() return NULL, so
still need to change sun4i_codec_create_card()?
