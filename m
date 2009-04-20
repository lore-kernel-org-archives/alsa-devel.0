From: "naresh" <x0090427-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 2/6] ARM: DaVinci: ASoC: Add the platform devices for
	ASP
Date: Mon, 20 Apr 2009 08:47:11 +0530
Message-ID: <200904200310.n3K3ArSX027306@symphonyindia.ti.com>
References: <200904200238.n3K2cZSX025247@symphonyindia.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <200904200238.n3K2cZSX025247-RJZogAH3fnI+kTQUpif1claTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: =?windows-1255?Q?'David_Brownell_=FD'?= <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


Dave,

Thanks for the review.

I will re-submit the patch after fixing the comments.

Regards,
Naresh

>
>On Thursday 16 April 2009, Medisetty, Naresh wrote:
>>  arch/arm/mach-davinci/dm355.c            |   29 ++++++++++++-
>>  arch/arm/mach-davinci/dm644x.c           |   27 +++++++++++-
>>  arch/arm/mach-davinci/dm646x.c           |   67
>++++++++++++++++++++++++++
>>  arch/arm/mach-davinci/include/mach/asp.h |   39 ++++++++++++++++-
>
>Note the merge dependency:  most of those aren't yet in mainline.
>I think Kevin sent the dm644x.c changes to the ARM list for their
>first review cycle recently.
>
>My comments below are for the dm355.c changes, but they apply just
>as much to the other two SoC-specific setup files.
>
>
>> +static struct resource dm355_evm_snd_resources[] = {
>> +       {
>> +               .start  = DAVINCI_ASP1_BASE,
>> +               .end    = DAVINCI_ASP1_BASE + SZ_8K - 1,
>> +               .flags  = IORESOURCE_MEM,
>> +       },
>> +};
>> +
>> +static struct evm_snd_platform_data dm355_evm_snd_data = {
>> +       .clk_name       = "asp1",
>> +       .tx_dma_ch      = DAVINCI_DMA_ASP1_TX,
>> +       .rx_dma_ch      = DAVINCI_DMA_ASP1_RX,
>> +};
>
>If you're going to move to proper driver model support
>(good!) ... the DMA channels should be IORESOURCE_DMA
>resources, and the clock should be associated directly
>with that platform device.
>
>That might seem to leave that current platform data
>struct as useless ... not so!  It should tell about how
>the audio is configured:  whether RX and TX are both
>wired, if they're stereo or what, how *audio* clocks
>are set up, and so forth.  All that is specific to the
>specific *board* in use, not to that SoC, so it should
>be provided by board setup code.  A lot of it is now
>encoded in the sound/soc/davinci/davinci-evm.c file.
>
>Example:  dm6446 evm supports six different audio clocks,
>but right now one choice is fixed at board setup time.
>
>ASoC seems to have ways to let drivers make that choice.
>That could be handled by board-specific callbacks and data
>tables, and would be good to package in platform data.
>A different dm6446 board may use a different audio clock
>setup, with different choices.
>
>
>> +
>> +static struct platform_device dm355_asoc_device = {
>> +       .name                           = "davinci-asoc",
>> +       .id                                     = -1,
>> +       .dev.platform_data      = &dm355_evm_snd_data,
>> +       .num_resources          = ARRAY_SIZE(dm355_evm_snd_resources),
>> +       .resource                       = dm355_evm_snd_resources,
>
>Looks like the alignment goofage there (for "=") is more than
>what can be explained by patch mangling from email...
>
>
>> +};
>
>
>> @@ -555,6 +579,7 @@ static int __init dm355_init_devices(void)
>>
>>         davinci_cfg_reg(DM355_INT_EDMA_CC);
>>         platform_device_register(&dm355_edma_device);
>> +       platform_device_register(&dm355_asoc_device);
>
>This does *NOT* belong in the generic dm355 setup code like that.
>Not every DM355 board will even have audio!  Or have it wired
>exactly like Spectrum's EVM boards.
>
>It'd be appropriate to add dm355_init_asoc(asp_num, platform_data)
>or something similar, so that different boards wouldn't need to
>repeat the won't-change parts.  That routine might need to set up
>some pin, IRQ, and EDMA muxing.  Boards with no audio support would
>not call that routine.  Ones with two audio interfaces might need
>to call it once for each interface.
>
>
>>         return 0;
>>  }
>>  postcore_initcall(dm355_init_devices);
>
>
>Similar comments for the two other SoC chips touched by this patch;
>although obviously the dm6446 wouldn't need an asp_num, etc.
>
>- dave
