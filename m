From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Date: Sat, 12 Jul 2008 00:26:04 -0600
Message-ID: <20080712062604.GC23213@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
	<9e4733910807061056m7b0dbf1fr578cbfcda31586ea@mail.gmail.com>
	<20080707105905.GA19240@rakim.wolfsonmicro.main>
	<9e4733910807070623u4c17b319p48e96a3022f3459b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by alsa0.perex.cz (Postfix) with ESMTP id ED717249F4
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Jul 2008 08:26:08 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so6067458wfg.23
	for <alsa-devel@alsa-project.org>; Fri, 11 Jul 2008 23:26:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9e4733910807070623u4c17b319p48e96a3022f3459b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, timur@freescale.com, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 07, 2008 at 09:23:24AM -0400, Jon Smirl wrote:
> On 7/7/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> > On Sun, Jul 06, 2008 at 01:56:48PM -0400, Jon Smirl wrote:
> >
> >  > The driver is assuming a capture stream exists. My codec is output only.
> >
> >
> > While the driver declares a capture stream the core doesn't require that
> >  both capture and playback be available - it will cope with a capture
> >  only or a playback only DAI (this is fairly common due to DAC only and
> >  ADC only parts).  Unless there's some other issue specific to this
> >  driver?
> 
> Yes, it GPFs allocating a a DMA buffer on the null capture stream pointer.

Where does it GPF?  When dereferencing pcm->streams[x].substream in
psc_i2s_pcm_new?
