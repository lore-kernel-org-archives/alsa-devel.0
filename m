From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: Intel SST on a Bay Trail tablet
Date: Tue, 14 Apr 2015 17:06:27 +0300
Message-ID: <552D1EE3.6090707@linux.intel.com>
References: <20150223183913.fb262011d6300425da7f34be@ao2.it>	<20150303151621.c6fc3cfa308aed62484b87a0@ao2.it>	<54F5CB3D.7020100@linux.intel.com>	<20150304170218.7b397993ce670902800109f1@ao2.it>	<20150403153414.b8de8df914664d7d7967120c@ao2.it>
 <20150414150236.3e8288307124a43941ab94f7@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C512F2605D4
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 16:07:37 +0200 (CEST)
In-Reply-To: <20150414150236.3e8288307124a43941ab94f7@ao2.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Antonio Ospite <ao2@ao2.it>, alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Ramesh Babu K V <Ramesh.Babu@intel.com>, Omair Mohammed Abdullah <omair.m.abdullah@intel.com>, Harsha Priya <priya.harsha@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

My 2c below.

On 04/14/2015 04:02 PM, Antonio Ospite wrote:
> On Wed, 4 Mar 2015 17:02:18 +0100
> Antonio Ospite <ao2@ao2.it> wrote:

> I realized than I needed to set up the path between the FrontEnd DAI
> and the BackEnd one, and in fact the error below goes away and I can
> _start_ some playback after switching on these controls:
> 	codec_out1 mix 0 pcm0_in Switch
> 	media0_out mix 0 media1_in Switch
> which AFAICS constitute the playback path.
>
> However there is still no sound, and the playback stalls, and the
> interrupt count suddenly stops for the intel_sst_driver IRQ
> (in /proc/interrupts).
>
What comes to my mind did you change .acpi_ipc_irq_index = 5 to 0 zero 
in sound/soc/intel/sst/sst_acpi.c: byt_rvp_res_info structure?

According to Teclast's DSDT table the DSP-host interrupt is at first 
interrupt resource index.

> By looking at /sys/kernel/debug under Android it looks like the
> codec is connected to SSP2, and not SSP0 as we imagined before:
> /sys/kernel/debug/asoc/baytrailaudio/sst-platform/dapm/ssp2 playback
> /sys/kernel/debug/asoc/baytrailaudio/sst-platform/dapm/ssp2 Capture
>
> So now I'd like to make sure the mixer settings are OK before looking
> elsewhere again.
>
> Vinod, Subhransu, or anyone else, can you share some working alsa state
> files for the baytrailcraudio device in linux mainline?
>
Question to Vinod et all too:

I don't find above "ssp2 playback" and "ssp2 Capture" stream names from 
sound/soc/intel/sst-mfld-platform-pcm.c so I guess it has been evolved a 
bit from those original Android drivers.

Which makes me thinking how does those strings describe the SSP port 
setup? E.g. do they reflect what port is actually used or could it be 
possible that those are just driver strings but firmware could have been 
tuned for SSP0? If I looked at earlier right, Teclast has the low 
pin-count Baytrail without SSP2 but I'm not sure about that.

> JFTR I am running a 64bit kernel, is this OK on BayTrail?
> I guess it is, but I just wanted to mention this to be sure.
>
Generally yes. I've used both 32- and 64-bit kernels when developing the 
sound/soc/intel/sst-baytrail-* but I haven't tested 
sound/soc/intel/sst/. Vinod, I guess that should be 64-bit safe too?

-- 
Jarkko
