From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Mon, 28 Jan 2013 13:36:28 +0100
Message-ID: <510670CC.2090904@ivitera.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id A62B2265293
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 13:36:34 +0100 (CET)
In-Reply-To: <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonas Petersen <jnsptrsn1@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 27.1.2013 16:49, Jonas Petersen wrote:
> in ap192_ak4114_init() of revo.c I see this:
> 
> ----
>     static const unsigned char ak4114_init_vals[] = {
>         AK4114_RST | AK4114_PWN | AK4114_OCKS0 | AK4114_OCKS1,
>         AK4114_DIF_I24I2S,
>         AK4114_TX1E,
>         AK4114_EFH_1024 | AK4114_DIT | AK4114_IPS(1),
>         0,
>         0
>     };
>     static const unsigned char ak4114_init_txcsb[] = {
>         0x41, 0x02, 0x2c, 0x00, 0x00
>     };
> ----
> 
> Something wrong here maybe?

These values look correct.

> 
> I noticed that the ak4114_init_vals array has 6 values but in
> ap192_ak4114_init() 7 values get written to ak4114.regmap.

Right, looks like a bug in snd_ak4114_create. Nevertheless the 7th reg
RCS0 is read-only, writing anything bogus should not affect the operation.

What does the ak4114 regs dump in /proc/asound... dir of your
audiophile192 look like? The snd_ak4114_proc_regs_read method reads real
values from the regs.

> 
> @Pavel, btw. I also have an ESI Juli@. Spdif capture with this one does not
> work at all (as compared to "kind of working" with the Audiophile 192).

Interesting. I am pretty sure I tested the SPDIF input of Juli quite
extensively. It even reported the incoming samplerate correctly. How did
you test it? Please list amixer contents and ak4114 regs here. Thanks.

Pavel.
