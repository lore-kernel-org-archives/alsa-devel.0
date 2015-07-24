From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Fri, 24 Jul 2015 22:54:33 +0200
Message-ID: <20150724205433.GA478@asus>
References: <CALnZUeg3=AB0vXS-TaOG=qe0W2f2r4wFVQKnqKxM=6mD0O-YcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AE6C260632
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 22:54:39 +0200 (CEST)
Received: by wibxm9 with SMTP id xm9so42585294wib.1
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 13:54:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALnZUeg3=AB0vXS-TaOG=qe0W2f2r4wFVQKnqKxM=6mD0O-YcA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marco Bodega <bo.the.lynx@gmail.com>
Cc: alsa-devel@alsa-project.org, bjorse@gmail.com, Takashi Iwai <tiwai@suse.de>, juergen.bausa@online.de, Luka Karinja <luka.karinja@gmail.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, "Nikula, Jarkko" <jarkko.nikula@intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 22, 2015 at 10:05:36PM +0200, Marco Bodega wrote:
> Hi all,
> 
> I own an Asus x205ta too and I really want to help to make this audio
> card works.
> I'm using linux next with Michele Curti's patch (as of 23 june)
>

Great!  Good to know that you are working on this driver.  I did no
progress since then because I stopped working on it..

> 
> but it's bounded to sst1 as i see from disassembling acpi data:
> cat dsdt.dsl:
> [...]
>  Device (SSP1)
>  {
>
...
> 
> however the fw is tied to work with SSP0.
> What can i do?
> 

SSP2
http://permalink.gmane.org/gmane.linux.alsa.devel/140328
future versions of the firmware should support SSP1

> 
> 
> Is everything that I've done correct?
> I see in these output logs many of the errors and bugs that the other
> users found.

> [    7.145429] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 0 doesn't have DAPM widget!!!
> [    7.145461] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 1 doesn't have DAPM widget!!!
> [    7.145488] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 2 doesn't have DAPM widget!!!
> [    7.145517] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 3 doesn't have DAPM widget!!!
> [    7.145540] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
> [    7.145565] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
> [    7.145592] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
> [    7.145621] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!

Yep, Vinod will check these
http://permalink.gmane.org/gmane.linux.alsa.devel/140564

Regards,
Michele
