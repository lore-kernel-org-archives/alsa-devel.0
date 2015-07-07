From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Tue, 7 Jul 2015 22:38:21 +0530
Message-ID: <20150707170821.GL11002@localhost>
References: <8D3F6266AEB6384E807C6FFC6FE195E30B49AE39@BGSMSX101.gar.corp.intel.com>
 <20150703143608.7afb34c985d82982e929484e@ao2.it>
 <20150703130658.GA1689228@phare.normalesup.org>
 <559A90CE.2030105@gmail.com> <20150707031950.GD11002@localhost>
 <559BDB7F.9010105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id F2DB32619F7
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 19:07:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <559BDB7F.9010105@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tyler Yeomans <tyeo098@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Antonio Ospite <ao2@ao2.it>, Nicolas George <george@nsup.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 07, 2015 at 10:00:31AM -0400, Tyler Yeomans wrote:
> Vinod,
> 
> I am using the ssp0 firmware from:
> https://git.kernel.org/cgit/linux/kernel/git/vkoul/firmware.git/tree/intel?h=byt.

Hi Tyler,

Can you enable logs (dynamic debug should help), I want to see if FW
download was success or not

Also cat /proc/interrupts to see if we are getting interrupts

Thanks
-- 
~Vinod

> 
> Thanks-
> 
> Tyler
> 
> On 07/06/2015 11:19 PM, Vinod Koul wrote:
> >On Mon, Jul 06, 2015 at 10:29:34AM -0400, Tyler Yeomans wrote:
> >>Hello all,
> >>
> >>Apparently I'm in the same boat as Nicolas is.
> >>I've attached my dmesg output.
> >>Everything seems to be generating but I am not able to get any sound
> >>output.
> >>Between the 37 second mark and the 617 second mark I had routed the
> >>FE to BE via the commands:
> >>
> >>amixer -c0 sset 'codec_out0 mix 0 pcm0_in' on
> >>amixer -c0 sset 'media0_out mix 0 media1_in' on
> >ok that seems fine
> >>Although it appears that did not work:
> >>[  719.834922] intel_sst_acpi 80860F28:00: Wait timed-out
> >>condition:0x0, msg_id:0x1 fw_state 0x3
> >>[  719.834932] intel_sst_acpi 80860F28:00: fw returned err -16
> >I don't think so, since you were able to start the card, that part worked :)
> >
> >The error is coming from FW here and seems unresponsive.
> >
> >Which firmware are you using?
> >
> >Second suspicion is for interrupts, if they are not mapped well we might see
> >these.
> >
> >Jarkko I remember that some board have to be configured properly for
> >interrupts, can you explaian the subtleties involved here
> >
> >--
> >~Vinod

-- 
