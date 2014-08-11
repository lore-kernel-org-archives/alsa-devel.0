From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Ordering in soc_pcm_hw_params()
Date: Mon, 11 Aug 2014 12:58:03 -0400
Message-ID: <CAKON4Oya+NjvA8dXWBVuoM4fb8GjzGw4OUjYzct956nJJ0UUJg@mail.gmail.com>
References: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>
 <20140811153342.GE17528@sirena.org.uk>
 <CAKON4OyxjSL4ziaJGdGXhVXGVoL9M4qq9qdtYYuGz_hnCA3muA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f46.google.com (mail-la0-f46.google.com
 [209.85.215.46])
 by alsa0.perex.cz (Postfix) with ESMTP id D56BD260859
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 18:58:03 +0200 (CEST)
Received: by mail-la0-f46.google.com with SMTP id b8so7041959lan.33
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 09:58:03 -0700 (PDT)
In-Reply-To: <CAKON4OyxjSL4ziaJGdGXhVXGVoL9M4qq9qdtYYuGz_hnCA3muA@mail.gmail.com>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 11, 2014 at 12:09 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> On Mon, Aug 11, 2014 at 11:33 AM, Mark Brown <broonie@kernel.org> wrote:
>> On Mon, Aug 11, 2014 at 09:35:51AM -0400, jonsmirl@gmail.com wrote:
>>
>>> I have code in the cpu set_hw_params which will switch the sysclk, but
>>> it never gets to run because the codec set_hw_params() has already
>>> errored out.
>>
>>> Shouldn't this order be:
>>> platform, link, cpu, codec
>>
>> No, the machine driver runs first so it can do any coordination needed
>> between the other devices.  Attempting to fiddle about with the ordering
>> is never going to be robust, someone else will always want a different
>> ordering at some point.
>
> I don't see how to fix this without making a machine driver that
> simply tells the cpu-dai to change the MCLK output from 22.5Mhz to
> 24.5Mhz earlier in the hw_params chain. But that's putting a generic
> piece of code into the machine driver.
>
> Shouldn't codec always be the last in the chain? What would be a case
> where you don't want it at the end of the chain?

Plan B. I added code in the codec's hw_param function to first call
the cpu's hw_param function.  cpu's hw_param will run twice but that
doesn't hurt anything.

/* give the cpu_dai a chance to change sysclk first if needed */
ret = rtd->cpu_dai->driver->ops->hw_params(substream, params, rtd->cpu_dai);

>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com



-- 
Jon Smirl
jonsmirl@gmail.com
