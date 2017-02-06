From: Vincent ABRIOU <vincent.abriou@st.com>
Subject: Re: [PATCH] ASoc: hdmi-codec: remove HDMI device
 unregister
Date: Mon, 6 Feb 2017 08:35:48 +0000
Message-ID: <65d4ecec-b0c6-1bfc-5e20-8fa6023256cf@st.com>
References: <1486116634-14930-1-git-send-email-vincent.abriou@st.com>
 <87fujschdc.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 92BA926664F
 for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2017 09:35:56 +0100 (CET)
In-Reply-To: <87fujschdc.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <DA8488464B61FF4F83ADC4E82AED7998@st.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Hi Kuninori,

On 02/06/2017 01:09 AM, Kuninori Morimoto wrote:
>
> Hi Vincent
>
>> While unregistering the hdmi-codec, the hdmi device list must be
>> cleaned up. It avoids kernel page fault when registering again the
>> hdmi-codec.
>>
>> Cc: Liam Girdwood <lgirdwood@gmail.com>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Jaroslav Kysela <perex@perex.cz>
>> Cc: Takashi Iwai <tiwai@suse.com>
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Cc: Jyri Sarha <jsarha@ti.com>
>> Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>>
>> Signed-off-by: Vincent Abriou <vincent.abriou@st.com>
>> ---
>
> Thank you about this patch.
> I added original "hdmi_device_list" to this driver for DW-HDMI device purpose.
> But, actually, 1) DW-HDMI binding method was exchanged, 2) I assumed it
> will not be exchanged, and 3) this patch was accepted under such
> (wrong) assumption.
>
> Thus, this "hdmi_device_list" is no longer needed.
> So, I'm planing to remove 9731f82d60166a19af6914f998092bbd1560f783
> ("ASoC: hdmi-codec: enable multi probe for same device")
> and its related patch soon.
>
> Can you agree about it ?
>

I am fine with you proposal.
Can you keep Arnaud Pouliquen and myself in the loop of your new patche 
series so that we are able to test it on our side.

Thanks.
Vincent

>>  sound/soc/codecs/hdmi-codec.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
>> index 90b5948..1ca405e 100644
>> --- a/sound/soc/codecs/hdmi-codec.c
>> +++ b/sound/soc/codecs/hdmi-codec.c
>> @@ -479,6 +479,18 @@ static int hdmi_codec_probe(struct platform_device *pdev)
>>
>>  static int hdmi_codec_remove(struct platform_device *pdev)
>>  {
>> +	struct device *dev = &pdev->dev;
>> +	struct list_head *pos;
>> +
>> +	list_for_each(pos, &hdmi_device_list) {
>> +		struct hdmi_device *tmp = pos_to_hdmi_device(pos);
>> +
>> +		if (tmp->dev == dev->parent) {
>> +			list_del(pos);
>> +			break;
>> +		}
>> +	}
>> +
>>  	snd_soc_unregister_codec(&pdev->dev);
>>  	return 0;
>>  }
>> --
>> 2.7.4
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
