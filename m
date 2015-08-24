From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Intel SST on a Bay Trail tablet
Date: Mon, 24 Aug 2015 19:56:25 +0530
Message-ID: <20150824142625.GM13546@localhost>
References: <20150824132904.GA665@acervm.homenet.telecomitalia.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F9AE2608ED
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 16:24:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150824132904.GA665@acervm.homenet.telecomitalia.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michele Curti <michele.curti@gmail.com>
Cc: alsa-devel@alsa-project.org, ao2@ao2.it, jarkko.nikula@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 24, 2015 at 03:29:04PM +0200, Michele Curti wrote:
> > On Thu, 25 Jun 2015 22:17:17 +0530 Vinod Koul wrote:
> > 
> > > On Thu, Jun 25, 2015 at 12:21:24PM +0200, Antonio Ospite wrote:
> > > > On Thu, 25 Jun 2015 11:20:46 +0530
> > > > Vinod Koul <vinod.koul at intel.com> wrote:
> > > > 
> > > > > On Wed, Jun 24, 2015 at 03:46:13PM +0530, Vinod Koul wrote:
> > > > > > On Tue, Apr 14, 2015 at 05:06:27PM +0300, Jarkko Nikula wrote:
> > > > [...]
> > > > > > > 
> > > > > > > Which makes me thinking how does those strings describe the SSP port
> > > > > > > setup? E.g. do they reflect what port is actually used or could it
> > > > > > > be possible that those are just driver strings but firmware could
> > > > > > > have been tuned for SSP0? If I looked at earlier right, Teclast has
> > > > > > > the low pin-count Baytrail without SSP2 but I'm not sure about that.
> > > > > > The FW doesnt provide way to changes ports from driver in this, so this
> > > > > > doesnt mean much. If we are sure it is not ssp2, I can provide ssp1 fw for
> > > > > > test
> > > > > I ahve pushed latest BYT version we have as well as added binary for second
> > > > > SSP port. Please give it a try:
> > > > > 
> > > > > https://git.kernel.org/cgit/linux/kernel/git/vkoul/firmware.git/commit/?h=byt&id=28ff420dd33ec299217bad7d526ff3bfd163b551
> > > > > 
> > > > 
> > > > Thanks Vinod, but I see these are in the ELF format, and the mainline
> > > > driver does not support this format, at least the last time I checked it
> > > > didn't.
> > > My bad, updated the patch now with right format
> > > 
> > > https://git.kernel.org/cgit/linux/kernel/git/vkoul/firmware.git/commit/?h=byt
> > >
> > 
> > (Adding Michele to CC)
> > 
> > OK, so Jarkko was right: after a quick test I confirm that with
> > fw_sst_0f28_ssp0.bin I get sound; this is quite an improvement,
> > thanks!
> 
> Damn, completely missed..
> 
> Hi Vinod,
> if it's possible, could you please generate a fw_sst_0f28_ssp1.bin
> also, so I can test my driver (mine was for the Asus X205TA laptop,
> where the codec is on SSP1 port)?

Are you sure you ahve SSP1 port enabled. I have not seen anyone using that
one. Jarkko do you know about this?

I will ask firmware folks for generation (i don't do that) and get back

-- 
~Vinod
