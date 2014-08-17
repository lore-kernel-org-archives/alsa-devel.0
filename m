From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Add merrifield machine driver
Date: Sun, 17 Aug 2014 19:50:28 +0530
Message-ID: <30767.2292729423$1408286567@news.gmane.org>
References: <1405599225-31538-1-git-send-email-subhransu.s.prusty@intel.com>
 <20140729195043.GM17528@sirena.org.uk>
 <20140812060601.GA1115@vinod.koul@linux.intel.com>
 <20140812214822.GB17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E09A2650DA
 for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2014 16:42:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140812214822.GB17528@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 12, 2014 at 10:48:22PM +0100, Mark Brown wrote:
> On Tue, Aug 12, 2014 at 11:36:09AM +0530, Subhransu S. Prusty wrote:
> > On Tue, Jul 29, 2014 at 08:50:43PM +0100, Mark Brown wrote:
> > > On Thu, Jul 17, 2014 at 05:43:45PM +0530, Subhransu S. Prusty wrote:
> 
> > > > +	/* Force enable VMID to avoid cold latency constraints */
> > > > +	snd_soc_dapm_force_enable_pin(&card->dapm, "VMID");
> > > > +	snd_soc_dapm_sync(&card->dapm);
> 
> > > This looks like you're open coding a version of wm8994_vmid_mode().
> > > Though that might need some tuning for systems that really have no
> > > single ended outputs.
> 
> > VMID has a larget settling time. Keep it ON here to avoid the delay. Any
> > better way of doing this?
> 
> Look at what wm8994_vmid_mode() does...

If I understand correctly need to move this enabling/disabling of VMID
to wm8994_vmid_mode(). 


-- 
