From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Thu, 25 Jun 2015 09:39:14 +0200
Message-ID: <20150625073914.GA3833@dellaz>
References: <20150529131753.GA339@asus> <1433156768.2642.21.camel@loki>
 <20150608084951.GA7512@dellaz>
 <loom.20150613T153708-781@post.gmane.org>
 <20150615164623.GA693@asus> <1434387868.2434.50.camel@loki>
 <20150623090932.GA6856@dellaz> <20150624102157.GL19530@localhost>
 <20150624182120.GA481@asus> <20150625032407.GQ19530@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id C0D01260415
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 09:39:22 +0200 (CEST)
Received: by wgqq4 with SMTP id q4so54986300wgq.1
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 00:39:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150625032407.GQ19530@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Luka Karinja <luka.karinja@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Nikula, Jarkko" <jarkko.nikula@intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 25, 2015 at 08:54:07AM +0530, Vinod Koul wrote:
> On Wed, Jun 24, 2015 at 08:21:20PM +0200, Michele Curti wrote:
> > > > There are a lot of errors about missing backend dai:
> > > > [    7.195570]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
> > > So in this driver we use DPCM, which means that you have to route Front End
> > > to a BackEnd and then only you can open a device. Without linking to BE it
> > > will fail
> > >
> > 
> > Yes, when Liam wrote about that I started to try to understand how to find the
> > right audio route/path, but I think it will take a while eheh :p
> > 
> > 
> > Thanks!  So for now I tried to blindy launch these commands (apart for the 
> > "Speaker L" and "Speaker R" controls, not present in the rt5645 codec) and 
> > I got about a minute freeze at every boot and some new errors:
> > 
> > [    2.700127] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 0 doesn't have DAPM widget!!!
> > [    2.700177] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 1 doesn't have DAPM widget!!!
> > [    2.700226] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 2 doesn't have DAPM widget!!!
> > [    2.700276] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 3 doesn't have DAPM widget!!!
> > [    2.700321] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
> > [    2.700368] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
> > [    2.700417] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
> > [    2.700468] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!
> this is unexpected, I will check on this
> 
> > ...
> > [    7.970937] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
> > [    7.970964] intel_sst_acpi 80860F28:00: fw returned err -16
> Yes this is a problem, which FW are you using
> 
> I am expecting you should be on
> http://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/commit/intel?id=d562a3b636325e969d4fdf60ec5e418a510f3510

Yes, I confirm it's the firmware I'm using, I did a diff to be sure :)

Thanks,
Michele

> 
> > ...
> > [   53.538117]  Baytrail Audio Port: sst: error code = -22
> > [   53.541909] bytx205_rt5645 bytx205_rt5645: BUG: pcmC0D0p:0, pos = -22, buffer size = 203830, period size = 1199
> This is impact of FW timeout
> 
> -- 
> ~Vinod
