From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH] SOUND: Fix non-ISA_DMA_API build failure
Date: Fri, 24 Jun 2011 08:35:22 -0300
Message-ID: <4E04767A.5020201@infradead.org>
References: <20110623144750.GA10180@linux-mips.org>
	<s5hzkl7zlcq.wl%tiwai@suse.de>
	<20110624111608.GA6327@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 068CD24416
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 13:35:29 +0200 (CEST)
In-Reply-To: <20110624111608.GA6327@linux-mips.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Em 24-06-2011 08:16, Ralf Baechle escreveu:
> On Fri, Jun 24, 2011 at 10:26:13AM +0200, Takashi Iwai wrote:
> 
>> Hrm...  I still don't understand why ES18XX or others were selected at
>> the first place.  Isn't it covered by the conditional in
>> sound/isa/Kconfig like below?
>>
>> ================================================================
>> menuconfig SND_ISA
>> 	bool "ISA sound devices"
>> 	depends on ISA && ISA_DMA_API
>> ...
>> if SND_ISA
>> ...
>> config SND_ES18XX
>> 	tristate "Generic ESS ES18xx driver"
>> ...
>> endif	# SND_ISA
>> ================================================================
>>
>> Isn't SND_ISA=n in your case although ISA_DMA_API=n?
> 
> The answer is hidden in this Kconfig warning:
> 
> warning: (RADIO_MIROPCM20) selects SND_ISA which has unmet direct dependencies (SOUND && !M68K && SND && ISA && ISA_DMA_API)
> 
> This is due to the following in drivers/media/radio/Kconfig:
> 
> config RADIO_MIROPCM20
>         tristate "miroSOUND PCM20 radio"
>         depends on ISA && VIDEO_V4L2 && SND
>         select SND_ISA
>         select SND_MIRO
> 
> So SND_ISA gets forced on even though the dependency on ISA_DMA_API is not
> fulfilled.  That's solved by adding the dependency on ISA_DMA_API to
> RADIO_MIROPCM20.

Another option would be to convert the two above selects into depends on.

Cheers,
Mauro
