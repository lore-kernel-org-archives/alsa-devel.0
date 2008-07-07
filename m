From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Date: Mon, 7 Jul 2008 09:23:24 -0400
Message-ID: <9e4733910807070623u4c17b319p48e96a3022f3459b@mail.gmail.com>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
	<9e4733910807061056m7b0dbf1fr578cbfcda31586ea@mail.gmail.com>
	<20080707105905.GA19240@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 06D43245C3
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 15:23:25 +0200 (CEST)
Received: by el-out-1112.google.com with SMTP id o28so133060ele.2
	for <alsa-devel@alsa-project.org>; Mon, 07 Jul 2008 06:23:24 -0700 (PDT)
In-Reply-To: <20080707105905.GA19240@rakim.wolfsonmicro.main>
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
To: Grant Likely <grant.likely@secretlab.ca>, liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

On 7/7/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Jul 06, 2008 at 01:56:48PM -0400, Jon Smirl wrote:
>
>  > The driver is assuming a capture stream exists. My codec is output only.
>
>
> While the driver declares a capture stream the core doesn't require that
>  both capture and playback be available - it will cope with a capture
>  only or a playback only DAI (this is fairly common due to DAC only and
>  ADC only parts).  Unless there's some other issue specific to this
>  driver?

Yes, it GPFs allocating a a DMA buffer on the null capture stream pointer.

>
>  > I'm using external clocking, but the driver should support using the
>  > mpc5200 for clocking. That's a little complicated since you have to
>  > compute the divisors. For example the Phytec pcm030 board has a
>  > 33.3333Mhz xtal and runs at 400Mhz.
>
>
> This is desirable, though it shouldn't be an obstacle for merging if the
>  driver only supports running in slave mode.
>
>
>  > In order to reduce options, can the psc-i2s driver always try to use
>  > mpc5200 clocking, then let the codec or fabric driver override it?
>
>
> The clocking should always be under the control of the machine driver
>  with the codec and platform drivers exporting the required dividers and
>  PLLs/FLLs.  Neither the platform driver nor the codec driver are really
>  in a position to know how a given board is wired up and what
>  interdependencies or external requirements there are.
>


-- 
Jon Smirl
jonsmirl@gmail.com
