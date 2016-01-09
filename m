From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 04/14] ASoC: hdac_hdmi: Add hotplug
 notification and read eld
Date: Sat, 9 Jan 2016 11:09:26 +0530
Message-ID: <20160109053926.GO11778@localhost>
References: <1449677405-7907-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449677781-7997-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449677781-7997-4-git-send-email-subhransu.s.prusty@intel.com>
 <20160108134217.GR6588@sirena.org.uk>
 <20160108135949.GN11778@localhost> <s5hk2nkdvih.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id DDB31260509
 for <alsa-devel@alsa-project.org>; Sat,  9 Jan 2016 06:35:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hk2nkdvih.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 08, 2016 at 02:57:10PM +0100, Takashi Iwai wrote:
> On Fri, 08 Jan 2016 14:59:50 +0100,
> Vinod Koul wrote:
> > 
> > On Fri, Jan 08, 2016 at 01:42:17PM +0000, Mark Brown wrote:
> > > On Wed, Dec 09, 2015 at 09:46:11PM +0530, Subhransu S. Prusty wrote:
> > > 
> > > > This patch uses i915 component framework to register for hotplug
> > > > notification. And once it identifies valid pin sense and valid eld,
> > > 
> > > You say this patch uses the i915 component framework but...
> > > 
> > > > +	if (pin->eld.monitor_present && pin->eld.eld_valid) {
> > > > +		/* TODO: Use i915 cmpnt framework when available */
> > > > +		if (hdac_hdmi_get_eld(&edev->hdac, pin->nid,
> > > 
> > > ...that's a TODO according to the code?
> > 
> > ah sorry, Shubranshu meant use i915 eld presence fwk when available.
> > Takashi was working on it so we will convert this to use shiny new
> > framework a bit later :)
> 
> FYI, the framework has been already merged to for-next branch.

Thanks for update, Yes this is next task for Shubranshu to do this and
multichannel support

-- 
~Vinod
