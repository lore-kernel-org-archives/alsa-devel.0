From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Ordering in soc_pcm_hw_params()
Date: Tue, 12 Aug 2014 07:45:52 -0400
Message-ID: <CAKON4Ow3HFL0Sv2AV7+-XS0PBHnP9WW_8FBgrV=cKp14LER9XA@mail.gmail.com>
References: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>
 <53E9D383.5060103@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f176.google.com (mail-lb0-f176.google.com
 [209.85.217.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 883D72650B4
 for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2014 13:45:53 +0200 (CEST)
Received: by mail-lb0-f176.google.com with SMTP id u10so6829899lbd.21
 for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2014 04:45:53 -0700 (PDT)
In-Reply-To: <53E9D383.5060103@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 12, 2014 at 4:42 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 08/11/2014 03:35 PM, jonsmirl@gmail.com wrote:
>>
>> soc_pcm_hw_params() sets the parameters in this order:
>> link, codec, cpu, platform
>>
>> This is tripping me up when switching between the 44100 and 48000
>> families.  If previous song was 44100 then the codec has sysclk set to
>> the 44100 family.
>>
>> Now I play a 48000 family song. codec gets new hardware params and
>> errors out because sysclk is still in the 44100 family.
>>
>> I have code in the cpu set_hw_params which will switch the sysclk, but
>> it never gets to run because the codec set_hw_params() has already
>> errored out.
>>
>> Shouldn't this order be:
>> platform, link, cpu, codec
>
>
> What I don't understand is why does the CPU DAI driver change the sysclk for
> the CODEC DAI driver? What I'd expect is that the machine driver sets the
> sysclk for both the CODEC and the CPU DAI. In this case everything should
> work fine.

The machine driver is simple-card. It is not smart enough to change
the sysclk between 22.5Mhz and 24.5Mhz depending on what music is
being played.


>
> - Lars
>



-- 
Jon Smirl
jonsmirl@gmail.com
