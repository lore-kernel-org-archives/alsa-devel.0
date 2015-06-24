From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Intel SST on a Bay Trail tablet
Date: Wed, 24 Jun 2015 13:25:16 +0200
Message-ID: <20150624132516.b36a4a264cfdd5481e6bbef4@ao2.it>
References: <20150223183913.fb262011d6300425da7f34be@ao2.it>
 <20150303151621.c6fc3cfa308aed62484b87a0@ao2.it>
 <54F5CB3D.7020100@linux.intel.com>
 <20150304170218.7b397993ce670902800109f1@ao2.it>
 <20150403153414.b8de8df914664d7d7967120c@ao2.it>
 <20150414150236.3e8288307124a43941ab94f7@ao2.it>
 <552D1EE3.6090707@linux.intel.com>
 <20150624101613.GK19530@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp207.alice.it (smtp207.alice.it [82.57.200.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F727260550
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 13:25:24 +0200 (CEST)
In-Reply-To: <20150624101613.GK19530@localhost>
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
Cc: alsa-devel@alsa-project.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Ramesh Babu K V <Ramesh.Babu@intel.com>, Omair Mohammed Abdullah <omair.m.abdullah@intel.com>, Harsha Priya <priya.harsha@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 24 Jun 2015 15:46:13 +0530
Vinod Koul <vinod.koul@intel.com> wrote:

Hi Vinod, thank you for replying.

> On Tue, Apr 14, 2015 at 05:06:27PM +0300, Jarkko Nikula wrote:
> > My 2c below.
> > 
> > On 04/14/2015 04:02 PM, Antonio Ospite wrote:
> > >On Wed, 4 Mar 2015 17:02:18 +0100
> > >Antonio Ospite <ao2@ao2.it> wrote:
> > 
[...]
> > >Vinod, Subhransu, or anyone else, can you share some working alsa state
> > >files for the baytrailcraudio device in linux mainline?

This question still stands. :)

> > Question to Vinod et all too:
> > 
> > I don't find above "ssp2 playback" and "ssp2 Capture" stream names
> > from sound/soc/intel/sst-mfld-platform-pcm.c so I guess it has been
> > evolved a bit from those original Android drivers.
> The upstream code is subset of one in Android but base stuff is still the
> same
> 
> > 
> > Which makes me thinking how does those strings describe the SSP port
> > setup? E.g. do they reflect what port is actually used or could it
> > be possible that those are just driver strings but firmware could
> > have been tuned for SSP0? If I looked at earlier right, Teclast has
> > the low pin-count Baytrail without SSP2 but I'm not sure about that.
> The FW doesnt provide way to changes ports from driver in this, so this
> doesnt mean much. If we are sure it is not ssp2, I can provide ssp1 fw for
> test

Is it possible to figure it out from the Android firmware?
http://ao2.it/tmp/sst-baytrail-on-Teclast-X98-Air-3G/android_firmware/

As said earlier I had also tried to convert the Android firmware to the
structure used in the mainline kernel, but with no success:
http://git.ao2.it/sst_elf_firmware_convert.git/

Or should I look at the board layout to find out what port the codec is
connected to? I don't have an oscilloscope or a logic analyzer for more
accurate investigation (would Intel be interested in sponsoring one,
BTW?)

I will surely test alternative firmwares if you provide them.

Thanks,
   Antonio

P.S. in email messages, putting a blank line between the quoted text and
the reply helps readability; not all MUAs have syntax highlighting.

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
