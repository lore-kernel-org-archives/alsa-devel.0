From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [RFC 0/4] Add support for DAI link addition
 dynamically
Date: Mon, 22 Feb 2016 16:51:48 +0800
Message-ID: <56CACC24.9040400@linux.intel.com>
References: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
 <56C1DF0F.4080503@metafoo.de> <56C40AA9.4050008@linux.intel.com>
 <56C42E71.8030805@linux.intel.com>
 <CANQOkFEnNn8JVeFfgFzBd+-SdFB6jF4fbNHo64ArmDcXypJNAg@mail.gmail.com>
 <56C5554F.6060800@linux.intel.com>
 <CANQOkFHMEeSQY1hVBrQX_YFTf48pD3yBsecG79C1qT1=5=2PMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DC1A8260789
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 09:50:41 +0100 (CET)
In-Reply-To: <CANQOkFHMEeSQY1hVBrQX_YFTf48pD3yBsecG79C1qT1=5=2PMA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, vinod.koul@intel.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 02/18/2016 03:57 PM, Vaibhav Agarwal wrote:
> On 18 February 2016 at 10:53, Mengdong Lin <mengdong.lin@linux.intel.com> wrote:


>> Since the codec driver is generic and can be used for many machines so I
>> feel we should avoid adding too machine-specific code to it (e.g. the soc
>> card name) as much as possible.
>
> We are not adding any machine-specific code in generic codec driver.
> In case we are using generic codec driver (existing in
> sound/soc/codecs), it would need a helper driver to glue it to soc
> card dynamically. Otherwise, for a specific platform, we can have a
> wrapper codec driver that can fetch capabilities of removable codec
> (may be via binary data) and expose them to already known soc cards
> for that device.
>
>>
>> I think the machine driver can understand all use cases for a platform,
>> including static or removable connections between the SOC and codecs. So
>> it's able to specify the removable codec and the codec DAIs needed by the
>> machine, as well as these removable links. Please correct me if my
>> understanding is wrong.
>
> As per my opinion, in case a platform supports say I2S interface, then
> any removable codec module utilizing I2S mode should work with that
> platform. So, knowing complete info about the codec may not be
> possible.
>

Okay. Then the machine driver has no way to pre-define the removal codec 
and the BE links. Thanks for your clarification.

Can the machine driver leave the codec and codec dai empty in the 
removable BE links? When a compatible codec is registered, the ASoC core 
will fill these fields and bind the links. When the codec is removed, 
the ASoC will unbind the links and clear the fields.


>> Do you mean the machine driver has no idea about these removal codecs?
>> And could you share more info about the removal codec in your use case?
>>
>
> A removable codec can be of any manufacturer using xyz codec. As
> mentioned before, it may not have info about possible codec to be
> connected. But, it can definitely choose the functionality supported
> based on it own capabilities.


>>
>> But IMHO I hope we can avoid this. So I suggested let machine driver define
>> some 'removable' links and ASoC core can bind/unbind them automatically with
>> the registration/unregistration of the codec component. I think most of your
>> code for ASoC core can still be reused.
>
> I wonder, if we can extend snd_soc_add_dai_link() to perform complete
> binding as well, with a conditional check for (!card->instantiated) to
> exit early. This would enable us using this API itself for the purpose
> we intend too.  Any thoughts/suggestions?

Yes. I think we can extend this function like this if need.

Thanks
Mengdong

>
> Also, keeping in mind that we don't have codec & codec_dai info in
> advance, I can't see any value addition of keeping place holders for
> DAI link based on platform capability.
>
> --
> Thanks,
> ./va
>
