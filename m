From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Correct S24_3LE support
Date: Fri, 13 Dec 2013 14:42:32 +0100
Message-ID: <52AB0EC8.5020802@metafoo.de>
References: <1386939499-5163-1-git-send-email-peter.ujfalusi@ti.com>
 <20131213130443.GY11044@sirena.org.uk> <52AB0BBD.2020001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-047.synserver.de (smtp-out-048.synserver.de
 [212.40.185.48])
 by alsa0.perex.cz (Postfix) with ESMTP id D5C69260376
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 14:41:43 +0100 (CET)
In-Reply-To: <52AB0BBD.2020001@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/13/2013 02:29 PM, Peter Ujfalusi wrote:
> On 12/13/2013 03:04 PM, Mark Brown wrote:
>> On Fri, Dec 13, 2013 at 02:58:19PM +0200, Peter Ujfalusi wrote:
>>
>>> -	case SNDRV_PCM_FORMAT_S24_LE:
>>> +	case SNDRV_PCM_FORMAT_S24_3LE:
>>>  		data |= (0x02 << 4);
>>>  		break;
>>
>> This should be adding the case for the new format rather than replacing
>> the old one shouldn't it?  They ought to turn out the same on the AIF so
>> the CODECs shouldn't care about the difference, ideally the core would
>> hide the difference from them.
> 
> Not really since the codec has only field to specify the data format. The
> codec can not support S24_LE (S24_LE is basically S32_LE msbits==24) since we

S24_LE is a 24 bit sample in a 32 bit word, but it is right aligned, so
there are 8 bits of leading padding, while with S32_LE msbits=24 you'd have
8bits of trailing padding.

> can not say to the codec to ignore the 8bit over the 24 bits of real data.
> In case of S24_3LE the I2S bus will have 24 clocks/per channel which can not
> be used to stream S24_LE either.
> 

Normally you'd expect the I2S core to only put the 24 bits of data onto the
bus for both S24_3LE and S24_LE (it might add necessary trailing padding if
the bit clocks per frame is > 24). A CODEC driver should really not have to
care about the in memory layout of the data since all it will see is a
serialized bit stream. I think ideally we wouldn't check for params_format()
but rather for snd_pcm_format_width(params_format()).

- Lars
