From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH 2/5 v4] drm/i2c/adv7511: Add audio support
Date: Mon, 11 Apr 2016 12:32:41 +0100
Message-ID: <570B8B59.7000900@synopsys.com>
References: <cover.1460047238.git.joabreu@synopsys.com>
 <d56087fae14074198f6c1bc749ce4da3cab62324.1460047238.git.joabreu@synopsys.com>
 <5707D249.5040707@metafoo.de> <5707D88A.3010400@synopsys.com>
 <57091999.4010906@metafoo.de> <570B6DF2.1080008@synopsys.com>
 <570B6F7B.2020906@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.synopsys.com (us01smtprelay-2.synopsys.com
 [198.182.47.9]) by alsa0.perex.cz (Postfix) with ESMTP id 71A4226055E
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 13:32:55 +0200 (CEST)
In-Reply-To: <570B6F7B.2020906@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Jose Abreu <Jose.Abreu@synopsys.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: architt@codeaurora.org, airlied@linux.ie, Vineet.Gupta1@synopsys.com, Alexey.Brodkin@synopsys.com, CARLOS.PALMINHA@synopsys.com, lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Hi Lars,


On 11-04-2016 10:33, Lars-Peter Clausen wrote:
> On 04/11/2016 11:27 AM, Jose Abreu wrote:
>> Hi Lars,
>>
>>
>> On 09-04-2016 16:02, Lars-Peter Clausen wrote:
>>> On 04/08/2016 06:12 PM, Jose Abreu wrote:
>>> [...]
>>>>> [...]
>>>>>> +- adi,enable-audio: If set the ADV7511 driver will register a codec interface
>>>>>> +  into ALSA SoC.
>>>>> This is not a description of the hardware.
>>>> Is this okay: "adi,enable-audio: Set this boolean parameter if ADV7511
>>>> transmitter routes audio signals" ?
>>> I don't think we need this property. There is no problem with registering
>>> the audio part unconditionally. As long as there is no connection we wont
>>> create a sound card that is exposed to userspace.
>>>
>> This change was suggested by Laurent Pinchart and was introduced in v3. Quoting
>> Laurent:
>> "The idea is that enabling support for ADV7511 audio in the kernel isn't coupled
>> with whether the system includes audio support. It would be confusing, and would
>> also waste resources, to create a Linux sound device when no sound channel is
>> routed on the board."
> I wouldn't care too much about this at this point, the extra amount of
> resources required for registering the CODEC (but not the sound card) is
> just a few bytes (sizeof(struct snd_soc_codec)).
>
> Nevertheless what we should do is describe the hardware and from this
> information infer whether there is a audio connection or not and if there is
> none we might skip registering the CODEC. In my opinion this hardware
> description should be modeled using of-graph, having a connection between
> the SoC side and the adv7511 SPDIF or I2S port.
>

You mean something like this:

sound_playback: sound_playback {
    compatible = "simple-audio-card";
    [...]
    simple-audio-card,format = "i2s";
    [...]
}

adv7511@xx {
    compatible = "adi,adv7511";
    [...]

    ports {
        [...]
        /* Audio Output */
        port@x {
            reg = <x>;
            endpoint {
                remote-endpoint = <&sound_playback>;
            }
        }
    }
}

?

Best regards,
Jose Miguel Abreu
