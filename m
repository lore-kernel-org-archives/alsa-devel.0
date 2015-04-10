From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: recording problem in beagleboard-mcbsp
Date: Fri, 10 Apr 2015 10:13:31 +0300
Message-ID: <5527781B.10705@ti.com>
References: <CAES_P+8NEcMfDSDVT5d0UHU4mo8d2-3rJg31zf5GRT0HaLVXYw@mail.gmail.com>	<CAES_P+-yk29wzBMhO3uYjr1fnXt8iyskr77QLc=AvwCuX=Najg@mail.gmail.com>	<CAES_P+-ufoqcY++WzvS42tyQLfd2zzuANNp2rPwuUk3x_Tn-jg@mail.gmail.com>	<551C3D19.2050200@ti.com>	<CAES_P+_zc1u=grsF4J3rH+uwamWTOrgQKYmcY-9p6b=W9-PxUA@mail.gmail.com>	<5523A1F3.2000701@ti.com>	<CAES_P+_nr4LvcU-WQ=ZuhNwCSRuUs=xenqKGpupYAgx01fnATg@mail.gmail.com>	<5524FA51.9060606@ti.com>	<CAES_P+8oJ0xDJ-2w02Q0pZmgQyY9tyaRB=+_PqMhTdwuYNRShw@mail.gmail.com>	<55266B38.6030503@ti.com>
 <CAES_P+-5vgq1LxSsUQLua4j06M4U8+ogLgnEK5KJ-4QPJs1vJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id DD0A226592E
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 09:15:07 +0200 (CEST)
In-Reply-To: <CAES_P+-5vgq1LxSsUQLua4j06M4U8+ogLgnEK5KJ-4QPJs1vJQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: noman pouigt <variksla@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 04/10/2015 02:02 AM, noman pouigt wrote:
> On Thu, Apr 9, 2015 at 5:06 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wr=
ote:
>> On 04/09/2015 02:44 AM, noman pouigt wrote:
>>>> First check the /proc/asound/card0/pcm0c/sub0/status while the capture=
 is
>>>> running and look at the hw_ptr if it has moved at all.
>>>
>>> It has not moved at all.
>>
>> So McBSP does not detect start condition on the FS line.
>>
>>>> Enable more interrupts in sound/soc/omap/mcbsp.c:omap_mcbsp_config(), =
like
>>>> RUNDFLEN, ROVFLEN and see if you have overflow in McBSP.
>>>
>>> I did enable the interrupt but all i am getting is below for both
>>> playback and capture
>>> usecase:
>>> omap-mcbsp 48074000.mcbsp: RX Buffer Underflow!
>>
>> This is because you dump the registers and it read the DDR register. The=
 FIFO
>> is empty and you try to read data out.
>>
>>> Remember playback is working in both the slave and master mode (codec s=
lave
>>> and codec master).
>>>>
>>>> If the DMA has not moved it means that McBSP does not received the FS =
which
>>>> would indicate the frame start, thus it will not sample data in, thus =
it will
>>>> not trigger the DMA to read the data out.
>>>
>>> Used scope to check FS and Bit clock and found below (running arecord
>>> with 44100):
>>> bit clock is running at 1.420 MHz and FS at 44100 kHz. Configured MCBsp
>>> in master mode this time.
>>>
>>>>
>>>> Since the capture is working on McBSP2 in McBSP slave (and master also=
) the
>>>> only thing which can be wrong is the way the max98090 is wired up or s=
ome mux
>>>> issue again as it was before for you.
>>>
>>> Below is the mux setting which i did and because of which playback is w=
orking:
>>> MCBsp in master mode
>>> configured mcbsp1_clkx, mcbsp1_fsx, mcbsp1_dx and mcbsp1_dr
>>> +
>>> +       mcbsp1_pins: pinmux_mcbsp1_pins {
>>> +                pinctrl-single,pins =3D <
>>> +                        OMAP3_CORE1_IOPAD(0x2196, PIN_OUTPUT | MUX_MOD=
E0)
>>> +                        OMAP3_CORE1_IOPAD(0x2198, PIN_OUTPUT | MUX_MOD=
E0)
>>> +                        OMAP3_CORE1_IOPAD(0x2190, PIN_OUTPUT | MUX_MOD=
E0)
>>> +                        OMAP3_CORE1_IOPAD(0x2192, PIN_INPUT | MUX_MODE=
0)
>>> +                        OMAP3_CORE1_IOPAD(0x218C, PIN_OUTPUT | MUX_MOD=
E0)
>>> +                >;
>>> +        };
>>>  };
>>>
>>> Even if MCBSP_DR is not connected properly it should record atleast noi=
se.
>>>
>>> I also tried Thomas Niederpr=FCm below advice when running McBsp in sla=
ve mode
>>> shorten the CLKR and CLKX pins and mux the CLKR pin as INPUT in your
>>> dts. Then your
>>> bitclock would enter through CLKR as well as CLKX.
>>> But this also didn't work.
>>>
>>> Found out only below register changes between playback and capture:
>>> In playback
>>> SPCR2: 0x02f5
>>> SPCR1: 0x0030
>>> In capture:
>>> SPCR2: 0x02f0
>>> SPCR1: 0x0031
>>>
>>> There are no difference between any other register. I think mcbsp
>>> registers are fine
>>> but can you confirm if there should be any more differences?
>>> Please advice what might be going wrong?
>>
>> Hrm, McBSP1 is kind of problematic port since it has 6pin config by defa=
ult.
>> It might worth a try to do something like:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/113058=
.html
>> has removed.
> This patch seems pretty old and I am not able to apply it as i am
> using latest kernel.
> kernel: 3.19

It removed functionality, you might want ton hack something similar back for
testing

> =

>> Or to switch to use McBSP3.
> =

> tried this as well but even playback didn't work.
> +       mcbsp3_pins: pinmux_mcbsp3_pins {
> +                pinctrl-single,pins =3D <
> +                        OMAP3_CORE1_IOPAD(0x216C, PIN_OUTPUT | MUX_MODE1)
> +                        OMAP3_CORE1_IOPAD(0x216E, PIN_INPUT | MUX_MODE1)
> +                        OMAP3_CORE1_IOPAD(0x2170, PIN_OUTPUT | MUX_MODE1)
> +                        OMAP3_CORE1_IOPAD(0x2172, PIN_OUTPUT | MUX_MODE0)
> +                >;
> +        };
> =

> attached patch where i replaced the mcbsp1 to mcbsp3 number in machine fi=
le.
> do you think this configuration is  right? I tried both master and slave =
mode
> and both didn't work but i was getting right bit clock and FS clock.

By default codec is master, so try to set the mux accordingly.

> =

>>
>> But for some reason now I can not get the recording working via McBSP1 e=
ither.
>> I remember that it worked not that long time ago...
>>
>> --
>> P=E9ter


-- =

P=E9ter
