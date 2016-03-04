From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Fri, 4 Mar 2016 12:07:17 +0100
Message-ID: <20160304110717.GA2791@acervm>
References: <loom.20150613T153708-781@post.gmane.org>
 <20150615164623.GA693@asus> <1434387868.2434.50.camel@loki>
 <20150623090932.GA6856@dellaz> <20150624102157.GL19530@localhost>
 <20150624182120.GA481@asus> <20150625032407.GQ19530@localhost>
 <20160303111110.GA13202@acervm> <20160303112745.GJ11154@localhost>
 <56D86467.9030703@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id B1CF8260673
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 12:07:21 +0100 (CET)
Received: by mail-wm0-f51.google.com with SMTP id p65so15479077wmp.1
 for <alsa-devel@alsa-project.org>; Fri, 04 Mar 2016 03:07:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56D86467.9030703@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Luka Karinja <luka.karinja@gmail.com>, Vinod Koul <vinod.koul@intel.com>, ao2@ao2.it, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "Nikula, Jarkko" <jarkko.nikula@intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 03, 2016 at 10:20:55AM -0600, Pierre-Louis Bossart wrote:
> On 3/3/16 5:27 AM, Vinod Koul wrote:
> >On Thu, Mar 03, 2016 at 12:11:10PM +0100, Michele Curti wrote:
> >>Hi Vinod,
> >>
> >>On Thu, Jun 25, 2015 at 08:54:07AM +0530, Vinod Koul wrote:
> >>>>[    2.700468] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!
> >>>this is unexpected, I will check on this
> >>>
> >>>>...
> >>>>[    7.970937] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
> >>>>[    7.970964] intel_sst_acpi 80860F28:00: fw returned err -16
> >>>Yes this is a problem, which FW are you using
> >
> >Have you tried the recent kernels, Pierre did a bunch of update and got many
> >things working.
> >
> >As for timeout, that simply means we have send a message to DSP which failed
> >to get a response. Perhpas the message had some bad element of FW had a
> >bug/crashed...
> 
> The firmware timeout is due to a change in the BIOS for BYT-CR devices that
> impacts the IPC interrupt number, I have a set of patches that fix this on
> Asus T100TAF but I still can't get any sound out.
>

Do you mean the .acpi_ipc_irq_index from 5 to 0?
If so, I also carry that fix in my patches.

Thanks,
Michele

On Thu, Mar 03, 2016 at 12:11:10PM +0100, Michele Curti wrote:
> 2. platform driver (patch 0002 at [1])
> 
> Used the sst-mfld-platform one (under sound/soc/intel/atom/sst), changing
> the .acpi_ipc_irq_index from 5 to 0 because the DSP interrupt order in
> the ACPI DSDT table of this laptop is different from the "normal" (see
> line 3745 of dsdt.dsl at [2]).
> 
> $ cat /proc/interrupts | grep sst
>             CPU0       CPU1       CPU2       CPU3       
>    1:         24          0          0          0   IO-APIC   29-fasteoi   intel_sst_driver
> 
> ...
> 
> [1] https://github.com/michelecurti/x205ta/tree/master/sound-patches
> [2] https://github.com/michelecurti/x205ta/tree/master/acpi-tables
> 
