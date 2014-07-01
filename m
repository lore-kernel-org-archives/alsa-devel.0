From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RFC] question regarding codec DAI ops
Date: Tue, 1 Jul 2014 11:28:44 +0200
Message-ID: <53B27F4C.9040900@st.com>
References: <53A44007.1000008@st.com> <20140621102644.GQ5099@sirena.org.uk>
 <53A7D78B.1050508@st.com> <20140630103127.GX23300@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id B416226577B
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 11:29:06 +0200 (CEST)
In-Reply-To: <20140630103127.GX23300@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


On 06/30/2014 12:31 PM, Mark Brown wrote:
> On Mon, Jun 23, 2014 at 09:30:19AM +0200, Arnaud Pouliquen wrote:
>> On 06/21/2014 12:26 PM, Mark Brown wrote:
>>> On Fri, Jun 20, 2014 at 04:07:03PM +0200, Arnaud Pouliquen wrote:
>>>> I have a platform with several audio IOs (DAC , HDMI...) and I2S In/out
>>>> connectors.
>>>> I'm using my codec driver but for this I2S output i used dummy codec driver
>>>> with the snd-soc-dummy-dai dai.
>>> Why are you using the dummy driver?  This is intended to stub things out
>>> in some DPCM situations rather than as something that should be used in
>>> normal code.
>> My platform is a base for several projects and customers. In this context
>> some extra I2S bus are available for extensions.
>> I have  two use cases to support.
>> - Possibility to test I2S bus without audio codec associated.
>> - Support client that does not use ASOC for audio codec ( a.e one manage
>> HDMI in his display driver...)
>> To be able to support these use cases i use device tree to construct the
>> alsa card.  if no asoc codec present, i connect dummy one.
> No, this is is not at all sensible - don't do that.  Think about it for
> a minute - if this were something we wanted to do it's going to apply
> just as much to any other I2S controller so we should be doing it in the
> core.
In fact what i really need is a dummy codec driver.
But, perhaps, may i the only one to see advantages of using a dummy codec.
if it is the case i will implement a dummy DAI in my codec driver.
Otherwise tell me if you are interested in a generic dummy codec drivers.

>   If the user really wants to look at the signals with a scope they
> are probably capable of providing a suitable driver for their purposes.
Unfortunately, my experience tells me otherwise.
>
>> If customer want to use another codec they have just  to change device tree.
>> Here is an example of my device tree declaration.
>>      sound {
>>          compatible = "st,snd-soc-sti";
>>          st,card-name = "audio";
>>          st,audio-routing =
>>              /* Analog out route */
>>              "Analog out","DAC",
>>              "DAC","dac_p";
>>
>>          st,asoc-platform = <&sti_asoc_platform>;
>>          backend-name  = "HDMI_out", "PCM_out",
>>                      "Analog_out", "spdif",
>>                      "HDMI_in", "PCM_in";
>>          backend-cpu-dai = <&snd_uni_player0 &snd_uni_player1
>>                      &snd_uni_player2 &snd_uni_player3
>>                      &snd_uni_reader0 &snd_uni_reader1 >;
>>          backend-codec = <&sti_sasg_codec 0
>>                      &sti_sasg_codec &sti_sasg_codec
>>                      0 0>;
>>          backend-codec-dai = "sas-dai-hdmi-out", "snd-soc-dummy-dai",
>>                      "sas-dai-dac", "sas-dai-spdif-out",
>>                      "snd-soc-dummy-dai","snd-soc-dummy-dai";
>>      };
> This looks a lot like you're trying to reinvent simple-card.
Ok , not see that last versions of simple card manage multi DAI links.
i will check if compatible with my design to reuse it instead of my 
machine driver.
Thanks for the remarks.
