From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: SGTL500 and its external MCLK
Date: Sat, 9 Aug 2014 12:42:43 -0400
Message-ID: <CAKON4OzHeB-bJKj_hB=L84jMROz-7vRgp7uqb45KLg4VHva2Zw@mail.gmail.com>
References: <CAKON4OxRr-igCSZ2HwXcKGFT7O6sQjJUMP_aF19kSRP59ZxFew@mail.gmail.com>
 <20140808052901.GA6028@MrMyself>
 <CAKON4OwgT8=moQUPugpR8CfPNkJomDGpHob0CRnzRSd4eC7kQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 310382610C5
 for <alsa-devel@alsa-project.org>; Sat,  9 Aug 2014 18:42:44 +0200 (CEST)
Received: by mail-lb0-f170.google.com with SMTP id l4so2824208lbv.1
 for <alsa-devel@alsa-project.org>; Sat, 09 Aug 2014 09:42:43 -0700 (PDT)
In-Reply-To: <CAKON4OwgT8=moQUPugpR8CfPNkJomDGpHob0CRnzRSd4eC7kQg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, zengzm.kernel@gmail.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 8, 2014 at 1:07 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> On Fri, Aug 8, 2014 at 1:29 AM, Nicolin Chen <Guangyu.Chen@freescale.com> wrote:
>> On Thu, Aug 07, 2014 at 03:37:47PM -0400, jonsmirl@gmail.com wrote:
>>> Since the sgtl5000 driver has the handle to the clock, can't it just
>>> ask the clock for its rate? If it directly asked the clock for its
>>> rate it looks like this codec could be bound with simple-audio-card
>>> and not need a machine driver.
>>
>> I think Simple Card should already have the capability to support
>> this without changing sgtl5000's code. It has two properties that
>> can make it call set_sysclk() for you during the init(). They are
>> 'clocks' and 'system-clock-frequency'. Please refer to its binding
>> doc for details.

Simple has a hard coded clock ID of zero. Which just happens to match
codecs/sgtl5000.h:#define SGTL5000_SYSCLK 0x00

Lucky coincidence?

static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
     struct snd_pcm_hw_params *params)
{
struct snd_soc_pcm_runtime *rtd = substream->private_data;
struct snd_soc_dai *codec_dai = rtd->codec_dai;
struct simple_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
unsigned int mclk;
int ret = 0;

if (priv->mclk_fs) {
mclk = params_rate(params) * priv->mclk_fs;
ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
    SND_SOC_CLOCK_IN);
}

return ret;
}



>>
>> And the topic why not let sgtl5000 fully control the clock has been
>> discussed in this thread:
>> http://comments.gmane.org/gmane.linux.alsa.devel/109093
>>
>> So I think the change can be done as well?
>
> I tried hacking on it some. One problem is with clocks that aren't
> 100% accurate. For example my clock is off a little - 22.571428. So
> when the code divides that by 44100 it gets 511.8 which truncates to
> 511 and the test for equal to 512 fails.
>
>
>>
>> Best regards,
>> Nicolin
>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com



-- 
Jon Smirl
jonsmirl@gmail.com
