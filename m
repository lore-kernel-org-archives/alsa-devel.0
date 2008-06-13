From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale MPC8610HPCD
	fabric driver to support multiple codecs
Date: Fri, 13 Jun 2008 11:26:57 -0400
Message-ID: <9e4733910806130826l55342b78mae243e7715c61e83@mail.gmail.com>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>
	<9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>
	<9e4733910806122016q4e10b56atc2fb9c91e129d6cb@mail.gmail.com>
	<9e4733910806122036g5b8d86f6wed526f29377a065d@mail.gmail.com>
	<48526566.8080400@freescale.com>
	<20080613150427.GA32377@rakim.wolfsonmicro.main>
	<9e4733910806130810y24e6a04bh12eed5a26d0a79c4@mail.gmail.com>
	<48528E81.2050901@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 400531037FD
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 17:26:59 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so3641607rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2008 08:26:57 -0700 (PDT)
In-Reply-To: <48528E81.2050901@freescale.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/13/08, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
>
>  > My system works like you describe. We have an external clock
>  > generator. It needs to be set up in the fabric code.
>
>
> But can the clock frequency change during runtime?  The current ASoC interface
>  can handle that.

Our i2s hardware is capable of changing the clock frequency at
runtime. I haven't tried doing it in software yet. The main reason for
changing is to adjust to sources that are multiples of 44.1 vs 48K.
Intel HDA has a much better scheme for handling that via a fixed clock
and skipping slots. I suspect I'll have to do some work on alsa to
make this work.

Get Freescale to put an HDA interface into the SOC chips so that I can
used HDA codecs. The only reason we are using an external clock chip
is because the MPC5200 generates a 192K audio clock that has a 0.7%
error in it. If the MPC5200 had a fractional-N divider instead of an
integer one on the audio clock we wouldn't need the external chip.
There's no way to fix the MPC5200 clock error without breaking the USB
clock.

>  > Isn't the parameter needed for codecs like AC97 where they supply the
>  > clock back to the CPU? Timur's device tree is the one with a codec
>  > clock rate. Are there other parameters the system might need to set
>  > into a codec?
>
> The direction of the clock.  That's why I have "i2s-slave" in the SSI nodes.

There should be a way for the ssi driver to extract the parameters
from the device tree and then feed them into the codec in an arch
independent manner. The codecs need to stay arch independent. I
haven't tried doing this yet in the code since I haven't needed setup
parameters.

>
>
>  --
>  Timur Tabi
>  Linux kernel developer at Freescale
>


-- 
Jon Smirl
jonsmirl@gmail.com
