From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Wed, 8 Jul 2015 09:06:04 +0530
Message-ID: <20150708033604.GM11002@localhost>
References: <8D3F6266AEB6384E807C6FFC6FE195E30B49AE39@BGSMSX101.gar.corp.intel.com>
 <20150703143608.7afb34c985d82982e929484e@ao2.it>
 <20150703130658.GA1689228@phare.normalesup.org>
 <559A90CE.2030105@gmail.com> <20150707031950.GD11002@localhost>
 <559BDB7F.9010105@gmail.com> <20150707170821.GL11002@localhost>
 <559C3F4A.5030307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A92582619D0
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 05:34:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <559C3F4A.5030307@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tyler Yeomans <tyeo098@gmail.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Antonio Ospite <ao2@ao2.it>, Nicolas George <george@nsup.org>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 07, 2015 at 05:06:18PM -0400, Tyler Yeomans wrote:
> Vinod,
> 
> I have attached ... what I think is what you're looking for with
> regards to the dynamic debug output.
Sorry I should have been clearer. The dynamic debug allows you to enbale
debug logs without recompiling

So after boot:
echo -n 'module snd_soc_sst_mfld_platform +p' > /sys/kernel/debug/dynamic_debug/control

this will enable prints, so when you start audio, the firmware would be
downloaded, and please grab the dmesg ouput and send...

> 

> Additionally, the interrupts report as follows... none:
> $ cat /proc/interrupts | grep sst
>    7:          0          0          0          0   IO-APIC
> 28-fasteoi   intel_sst_driver
So this makes me suspect interrupts, we should have seen something here

Liam, do you know how whats different in BYT devices from interrupts. I
recall Jarkko saying some issues with the way interrupts are exposed..?

-- 
~Vinod
> 
> Tyler
> 
> On 07/07/2015 01:08 PM, Vinod Koul wrote:
> >On Tue, Jul 07, 2015 at 10:00:31AM -0400, Tyler Yeomans wrote:
> >>Vinod,
> >>
> >>I am using the ssp0 firmware from:
> >>https://git.kernel.org/cgit/linux/kernel/git/vkoul/firmware.git/tree/intel?h=byt.
> >Hi Tyler,
> >
> >Can you enable logs (dynamic debug should help), I want to see if FW
> >download was success or not
> >
> >Also cat /proc/interrupts to see if we are getting interrupts
> >
> >Thanks
> 
