From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Ordering in soc_pcm_hw_params()
Date: Tue, 12 Aug 2014 13:53:30 +0200
Message-ID: <53EA003A.7010709@metafoo.de>
References: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>	<53E9D383.5060103@metafoo.de>	<CAKON4Ow3HFL0Sv2AV7+-XS0PBHnP9WW_8FBgrV=cKp14LER9XA@mail.gmail.com>
 <CAKON4OzrJSAD0RUL5TO6n8mxG0q9rRau0MWaAXvXVo+bSB8Ygg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B119264F10
 for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2014 13:53:32 +0200 (CEST)
In-Reply-To: <CAKON4OzrJSAD0RUL5TO6n8mxG0q9rRau0MWaAXvXVo+bSB8Ygg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

On 08/12/2014 01:46 PM, jonsmirl@gmail.com wrote:
> On Tue, Aug 12, 2014 at 7:45 AM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>> On Tue, Aug 12, 2014 at 4:42 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>> On 08/11/2014 03:35 PM, jonsmirl@gmail.com wrote:
>>>>
>>>> soc_pcm_hw_params() sets the parameters in this order:
>>>> link, codec, cpu, platform
>>>>
>>>> This is tripping me up when switching between the 44100 and 48000
>>>> families.  If previous song was 44100 then the codec has sysclk set to
>>>> the 44100 family.
>>>>
>>>> Now I play a 48000 family song. codec gets new hardware params and
>>>> errors out because sysclk is still in the 44100 family.
>>>>
>>>> I have code in the cpu set_hw_params which will switch the sysclk, but
>>>> it never gets to run because the codec set_hw_params() has already
>>>> errored out.
>>>>
>>>> Shouldn't this order be:
>>>> platform, link, cpu, codec
>>>
>>>
>>> What I don't understand is why does the CPU DAI driver change the sysclk for
>>> the CODEC DAI driver? What I'd expect is that the machine driver sets the
>>> sysclk for both the CODEC and the CPU DAI. In this case everything should
>>> work fine.
>>
>> The machine driver is simple-card. It is not smart enough to change
>> the sysclk between 22.5Mhz and 24.5Mhz depending on what music is
>> being played.
>
> Having said that, should we make simple-card smart enough to do that?

Probably yes. The CPU DAI driver is definitely the wrong place to change the 
CODEC DAI sysclk.
