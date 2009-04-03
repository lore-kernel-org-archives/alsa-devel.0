From: Ernesto Torres <skullmate@gmail.com>
Subject: Re: how to use mcbsp for i2s?
Date: Fri, 3 Apr 2009 10:14:45 -0600
Message-ID: <fb44c3530904030914w255d1502pec109d6c494b8f1b@mail.gmail.com>
References: <fb44c3530904011129s7dd5cf1fgcf266fac3fb059d3@mail.gmail.com>
	<bd7b27490904020048h672ce810j3c79868a7f5ef4e0@mail.gmail.com>
	<bd7b27490904020320i714cd812i49bd834676ce4dee@mail.gmail.com>
	<20090402195653.0bcfb59e.jhnikula@gmail.com>
	<fb44c3530904021027r7a1387cag8507c4a1a88811ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.158])
	by alsa0.perex.cz (Postfix) with ESMTP id A86DF10387A
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Apr 2009 18:14:47 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 4so841026yxp.2
	for <alsa-devel@alsa-project.org>; Fri, 03 Apr 2009 09:14:46 -0700 (PDT)
In-Reply-To: <fb44c3530904021027r7a1387cag8507c4a1a88811ca@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Im getting this output from muxing:

MUX: setup AF6_3430_MCBSP3_DX (0xd800216c): 0x0004 ->
0x0000
MUX: setup AE6_3430_MCBSP3_DR (0xd800216e): 0x0004 ->
0x0000
MUX: setup AF5_3430_MCBSP3_CLKX (0xd8002170): 0x0004 ->
0x0000
MUX: setup AE5_3430_MCBSP3_FSX (0xd8002172): 0x0004 -> 0x0000

Is this correct?

On Thu, Apr 2, 2009 at 11:27 AM, Ernesto Torres <skullmate@gmail.com> wrote:

> thank you, I'll try it and let you know how it went
>
> On Thu, Apr 2, 2009 at 10:56 AM, Jarkko Nikula <jhnikula@gmail.com> wrote:
>
>> On Thu, 2 Apr 2009 13:20:36 +0300
>> Jarkko Nikula <jhnikula@gmail.com> wrote:
>>
>> > > Grrr... cannot find the hack, I'm too keen to delete temporary
>> > > hacks. I was
>> > pretty sure I had
>> > it somewhere.
>> >
>> > Basically it was adding necessary pin multiplexing configuration into
>> > arch/arm/plat-omap/include/mach/mux.h and arch/arm/mach-omap2/mux.c
>> > and then using omap_cfg_reg(...) in omap3beagle.c to change pin
>> > configuration from
>> > GPIOs to McBPS[1 | 3] pins.
>> >
>> Yes, I found it. Hack attached :-)
>>
>> Now I don't have here Beagle to test but hack still applies on top of
>> linux-omap. Then you will need CONFIG_OMAP_MUX=y and following lines
>> into omap3beagle.c or board-omap3beagle.c.
>>
>> omap_cfg_reg(AF6_3430_MCBSP3_DX);
>> omap_cfg_reg(AE6_3430_MCBSP3_DR);
>> omap_cfg_reg(AF5_3430_MCBSP3_CLKX);
>> omap_cfg_reg(AE5_3430_MCBSP3_FSX);
>>
>>
>> Jarkko
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>>
>
>
> --
> ___________
> EhTd
>
>


-- 
___________
EhTd
