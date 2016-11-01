From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 01/14] dma: sun6i-dma: Add burst case of 4
Date: Tue, 1 Nov 2016 22:55:13 +0800
Message-ID: <CAGb2v65yR9NOff+VDA0cBj3UenGpdYUfnYfesnmzP8AN4uw4Tw@mail.gmail.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <3a2404510b5f8b16ae3bb193982d70f158700b2b.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004124011.d7f5754a082d5f17d5185fc4@free.fr> <20161004165553.GS5228@lukather>
 <20161023183107.5b75b6aad62853378713299f@free.fr> <20161027175154.v4kuhyvm3r5n6tdo@lukather>
 <CAGb2v67SSZF6XL-HXv83nuwTKpJc53h8gsrb2r2V98LNZBzqEA@mail.gmail.com> <1477922460.2837.5.camel@intel.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBB3GZ4LAAKGQELXGO5PY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1477922460.2837.5.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: "Koul, Vinod" <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "wens-jdAy2FN1RRM@public.gmane.org" <wens-jdAy2FN1RRM@public.gmane.org>, "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org" <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "moinejf-GANU6spQydw@public.gmane.org" <moinejf-GANU6spQydw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tiwai-IBi9RG/b67k@public.gmane.org" <tiwai-IBi9RG/b67k@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel@li
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 1, 2016 at 9:46 PM, Koul, Vinod <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> On Sun, 2016-10-30 at 10:06 +0800, Chen-Yu Tsai wrote:
>> Looking at the dmaengine API, I believe we got it wrong.
>>
>> max_burst in dma_slave_config denotes the largest amount of data
>> a single transfer should be, as described in dmaengine.h:
>
> Not a single transfer but smallest transaction within a transfer of a
> block. So dmaengines transfer data in bursts from source to destination,
> this parameter decides the size of that bursts

Right.

>
>>
>>  * @src_maxburst: the maximum number of words (note: words, as in
>>  * units of the src_addr_width member, not bytes) that can be sent
>>  * in one burst to the device. Typically something like half the
>>  * FIFO depth on I/O peripherals so you don't overflow it. This
>>  * may or may not be applicable on memory sources.
>>  * @dst_maxburst: same as src_maxburst but for destination target
>>  * mutatis mutandis.
>>
>> The DMA engine driver should be free to select whatever burst size
>> that doesn't exceed this. So for max_burst = 4, the driver can select
>> burst = 4 for controllers that do support it, or burst = 1 for those
>> that don't, and do more bursts.
>
> Nope, the client configures these parameters and dmaengine driver
> validates and programs

Shouldn't we just name it "burst_size" then if it's meant to be what
the client specifically asks for?

My understanding is that the client configures its own parameters,
such as the trigger level for the DRQ, like raise DRQ when level < 1/4
FIFO depth, request maxburst = 1/4 or 1/2 FIFO depth, so as not to
overrun the FIFO. When the DRQ is raised, the DMA engine will do a
burst, and after the burst the DRQ would be low again, so the DMA
engine will wait. So the DMA engine driver should be free to
program the actual burst size to something less than maxburst, shouldn't
it?

>>
>> This also means we can increase max_burst for the audio codec, as
>> the FIFO is 64 samples deep for stereo, or 128 samples for mono.
>
> Beware that higher bursts means chance of underrun of FIFO. This value
> is selected with consideration of power and performance required. Lazy
> allocation would be half of FIFO size..

You mean underrun if its the source right? So the client setting maxburst
should take the DRQ trigger level into account for this.


Regards
ChenYu
