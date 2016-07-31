From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] sound: Fix empty menuconfig SND_ARM
Date: Sun, 31 Jul 2016 11:05:07 +0200
Message-ID: <87a8gyyy7w.fsf@belgarion.home>
References: <20160730140019.20305-1-rosca.eugeniu@gmail.com>
 <87eg6byzzz.fsf@belgarion.home> <20160730151413.GA25440@eugeniu-X230>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp11.smtpout.orange.fr
 [80.12.242.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 75D22260442
 for <alsa-devel@alsa-project.org>; Sun, 31 Jul 2016 11:05:16 +0200 (CEST)
In-Reply-To: <20160730151413.GA25440@eugeniu-X230> (Eugeniu Rosca's message of
 "Sat, 30 Jul 2016 17:14:13 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eugeniu Rosca <roscaeugeniu@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Eugeniu Rosca <roscaeugeniu@gmail.com> writes:

> On Sat, Jul 30, 2016 at 04:14:24PM +0200, Robert Jarzmik wrote:
>> Eugeniu Rosca <roscaeugeniu@gmail.com> writes:
>> 
>> > commit 3c8f7710c1c4 ("ASoC: fix broken pxa SoC support") has removed
>> > the SND_ARM dependency from SND_PXA2XX_LIB and SND_PXA2XX_LIB_AC97,
>> > by moving these config entries outside of the "if SND_ARM ... endif"
>> > construct.
>> >
>> > However, by placing these 2 symbols right between the SND_ARM
>> > menuconfig definition and the first SND_ARM menu entry, the side
>> > effect is that the SND_ARM menu becomes empty and all the config
>> > entries caught between "if SND_ARM ... endif" no more belong to
>> > menuconfig SND_ARM, but to its parent (menuconfig SND).
>> >
>> > Fix this.
>> NAK.
>> 
>> The reason is that SND_PXA2XX_LIB is used outside of SND_ARM, see
>> sound/soc/pxa/Kconfig, SND_PXA2XX_SOC and co.
>> 
>> With you commit you're breaking every board relying on SND_PXA2XX_SOC but not
>> SND_ARM.
>> 
>> Cheers.
>> 
>> --
>> Robert
>
> Hi Robert and thanks for the quick reply!

Hi Eugeniu,

Thanks for the explanation, it's very clear.

Moreover I reread your patch, and tested it, and you're actually putting the
SND_PXA2XX_LIB and SND_PXA2XX_LIB_AC97 _after_ the endif, while I was reading
you put them in the middle of "if ARM ... endif", hence my initial complaint.

Therefore, I remove my NAK, and :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
