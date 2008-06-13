From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale MPC8610HPCD
	fabric driver to support multiple codecs
Date: Fri, 13 Jun 2008 11:10:26 -0400
Message-ID: <9e4733910806130810y24e6a04bh12eed5a26d0a79c4@mail.gmail.com>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>
	<9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>
	<9e4733910806122016q4e10b56atc2fb9c91e129d6cb@mail.gmail.com>
	<9e4733910806122036g5b8d86f6wed526f29377a065d@mail.gmail.com>
	<48526566.8080400@freescale.com>
	<20080613150427.GA32377@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 87640103803
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 17:10:27 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so3635431rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2008 08:10:26 -0700 (PDT)
In-Reply-To: <20080613150427.GA32377@rakim.wolfsonmicro.main>
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
To: Timur Tabi <timur@freescale.com>, Jon Smirl <jonsmirl@gmail.com>, alsa-devel@alsa-project.org, lg@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 6/13/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Jun 13, 2008 at 07:17:42AM -0500, Timur Tabi wrote:
>  > Jon Smirl wrote:
>  >> On 6/12/08, Jon Smirl <jonsmirl@gmail.com> wrote:
>
>
> >> Instead the codec should make a module parameter for the clock rate.
>
>  > Ugh.  I'm not really crazy about parameters.
>
>
> Yes, that doesn't seem too clever.
>
>  Besides, the codec drivers need to treat all the clocking configuration
>  as dynamic - for example, it's a fairly common pattern for systems that
>  derive the audio clocks from a PLL or similar source to reconfigure the
>  master clock rate depending on the sample rates currently in use,
>  disabling it when not required.

My system works like you describe. We have an external clock
generator. It needs to be set up in the fabric code.

Isn't the parameter needed for codecs like AC97 where they supply the
clock back to the CPU? Timur's device tree is the one with a codec
clock rate. Are there other parameters the system might need to set
into a codec?


>


-- 
Jon Smirl
jonsmirl@gmail.com
