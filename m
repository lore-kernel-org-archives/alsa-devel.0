From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Intel Baytrail Linux Audio
Date: Wed, 8 Jul 2015 10:23:08 +0200
Message-ID: <20150708102308.91b7258f243e354b1365a47e@ao2.it>
References: <8D3F6266AEB6384E807C6FFC6FE195E30B49AE39@BGSMSX101.gar.corp.intel.com>
 <20150703143608.7afb34c985d82982e929484e@ao2.it>
 <20150703130658.GA1689228@phare.normalesup.org>
 <559A90CE.2030105@gmail.com> <20150707031950.GD11002@localhost>
 <559BDB7F.9010105@gmail.com> <20150707170821.GL11002@localhost>
 <559C3F4A.5030307@gmail.com> <20150708033604.GM11002@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp206.alice.it (smtp206.alice.it [82.57.200.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 81691260429
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 10:23:17 +0200 (CEST)
In-Reply-To: <20150708033604.GM11002@localhost>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>, Nicolas George <george@nsup.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, Tyler Yeomans <tyeo098@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 8 Jul 2015 09:06:04 +0530
Vinod Koul <vinod.koul@intel.com> wrote:

> On Tue, Jul 07, 2015 at 05:06:18PM -0400, Tyler Yeomans wrote:
[...]
> > Additionally, the interrupts report as follows... none:
> > $ cat /proc/interrupts | grep sst
> >    7:          0          0          0          0   IO-APIC
> > 28-fasteoi   intel_sst_driver
> So this makes me suspect interrupts, we should have seen something here
>

Tyler, maybe it's trivial but I will spell it out anyway: before any
interrupt gets fired, something needs to be played (e.g. speaker-test).

> Liam, do you know how whats different in BYT devices from interrupts. I
> recall Jarkko saying some issues with the way interrupts are exposed..?
> 

The details are here:
https://bugzilla.kernel.org/show_bug.cgi?id=86581

A summary is below:

Some devices declare interrupts in their DSDT in an order different from
what the mainline linux driver expects, in particular the DSP-host
interrupt is sometimes declared first while the driver expects it at
index 5.

To check that, dump the DSDT table (look up the details), and look for
"Device (LPEA)", then check the order of the "Interrupt" definitions.

Some devices define 0x0000001D as the first one, and this does not work
with the the mainline driver which expects the interrupts sorted
numerically (i.e. 0x0000001D is the sixth one starting from 0x00000018
and after 0x0000001C).

The problem can be fixed in two ways:
  - Override your DSDT with one which reorders the interrupts
    (that's what I did).
  - Apply https://bugzilla.kernel.org/attachment.cgi?id=155341 to the
    driver to use the "right" index as per the original device DSDT.
    NOTE: the file paths changed in recent kernels so you may need to
    apply the change manually.

A final note, you also need to set the right codec controls to get
audio; setting the FE-BE path is necessary to make playback "work" but
it may not be enough to actually get sound, so make sure you run the
full script Vinod provided in
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/094080.html

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
