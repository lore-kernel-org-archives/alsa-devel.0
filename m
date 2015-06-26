From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Intel SST on a Bay Trail tablet
Date: Fri, 26 Jun 2015 15:05:28 +0200
Message-ID: <20150626150528.f9fdee3942f7e975d23dd701@ao2.it>
References: <20150223183913.fb262011d6300425da7f34be@ao2.it>
 <20150303151621.c6fc3cfa308aed62484b87a0@ao2.it>
 <54F5CB3D.7020100@linux.intel.com>
 <20150304170218.7b397993ce670902800109f1@ao2.it>
 <20150403153414.b8de8df914664d7d7967120c@ao2.it>
 <20150414150236.3e8288307124a43941ab94f7@ao2.it>
 <552D1EE3.6090707@linux.intel.com>
 <20150624101613.GK19530@localhost>
 <20150625055046.GT19530@localhost>
 <20150625122125.72a1d72b4d3aa886d68fa3eb@ao2.it>
 <20150625164717.GU19530@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp208.alice.it (smtp208.alice.it [82.57.200.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BD02264F53
 for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2015 15:05:49 +0200 (CEST)
In-Reply-To: <20150625164717.GU19530@localhost>
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
Cc: Michele Curti <michele.curti@gmail.com>, alsa-devel@alsa-project.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Ramesh Babu K V <Ramesh.Babu@intel.com>, Omair Mohammed Abdullah <omair.m.abdullah@intel.com>, Harsha Priya <priya.harsha@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 25 Jun 2015 22:17:17 +0530
Vinod Koul <vinod.koul@intel.com> wrote:

> On Thu, Jun 25, 2015 at 12:21:24PM +0200, Antonio Ospite wrote:
> > On Thu, 25 Jun 2015 11:20:46 +0530
> > Vinod Koul <vinod.koul@intel.com> wrote:
> > 
> > > On Wed, Jun 24, 2015 at 03:46:13PM +0530, Vinod Koul wrote:
> > > > On Tue, Apr 14, 2015 at 05:06:27PM +0300, Jarkko Nikula wrote:
> > [...]
> > > > > 
> > > > > Which makes me thinking how does those strings describe the SSP port
> > > > > setup? E.g. do they reflect what port is actually used or could it
> > > > > be possible that those are just driver strings but firmware could
> > > > > have been tuned for SSP0? If I looked at earlier right, Teclast has
> > > > > the low pin-count Baytrail without SSP2 but I'm not sure about that.
> > > > The FW doesnt provide way to changes ports from driver in this, so this
> > > > doesnt mean much. If we are sure it is not ssp2, I can provide ssp1 fw for
> > > > test
> > > I ahve pushed latest BYT version we have as well as added binary for second
> > > SSP port. Please give it a try:
> > > 
> > > https://git.kernel.org/cgit/linux/kernel/git/vkoul/firmware.git/commit/?h=byt&id=28ff420dd33ec299217bad7d526ff3bfd163b551
> > > 
> > 
> > Thanks Vinod, but I see these are in the ELF format, and the mainline
> > driver does not support this format, at least the last time I checked it
> > didn't.
> My bad, updated the patch now with right format
> 
> https://git.kernel.org/cgit/linux/kernel/git/vkoul/firmware.git/commit/?h=byt
>

(Adding Michele to CC)

OK, so Jarkko was right: after a quick test I confirm that with
fw_sst_0f28_ssp0.bin I get sound; this is quite an improvement,
thanks!

I am going to update the report on bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=86581

I used the amixer commands which Vinod provided in the other thread,
in particular, the playback path is this one:

> amixer -c0 sset 'codec_out0 mix 0 pcm0_in' on
> amixer -c0 sset 'media0_out mix 0 media1_in' on

The sound is a bit distorted tho, I can alleviate this effect by
lowering the values of these controls:
  - codec_out0 Gain0
  - media1_in Gain0
  - pcm0_in Gain0

but the distortions do not go completely away, and they are not present
in Android even at the highest volume.

I will perform more tests (capture, headphones) when 4.2-rc1 is out
and report back the results.

JFTR, I made sure to use the DPCM driver by preventing the other one
from being loaded:

diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index 42f293f..66ee705 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -266,7 +266,6 @@ static struct sst_acpi_desc sst_acpi_baytrail_desc = {
 static struct acpi_device_id sst_acpi_match[] = {
        { "INT33C8", (unsigned long)&sst_acpi_haswell_desc },
        { "INT3438", (unsigned long)&sst_acpi_broadwell_desc },
-       { "80860F28", (unsigned long)&sst_acpi_baytrail_desc },
        { }
 };
 MODULE_DEVICE_TABLE(acpi, sst_acpi_match);

Would it be worth providing a SSP0 variant of
fw_sst_0f28.bin-48kHz_i2s_master too? Or is the intel/atom/sst/sst_acpi.c
going to completely replace intel/common/sst-acpi.c?

Thanks a lot,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
