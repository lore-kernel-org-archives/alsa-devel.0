From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 1/7] ASoC: hda - add ASoC HDA codec
 match function
Date: Tue, 2 Jun 2015 17:55:55 +0530
Message-ID: <20150602122555.GN3140@localhost>
References: <20150526194316.GY21577@sirena.org.uk>
 <s5hfv6ieero.wl-tiwai@suse.de>
 <20150527183406.GM21577@sirena.org.uk>
 <s5hpp5lde48.wl-tiwai@suse.de>
 <20150528195359.GG21577@sirena.org.uk>
 <s5hk2vsasjz.wl-tiwai@suse.de> <20150529081544.GC3140@localhost>
 <20150529173503.GQ21577@sirena.org.uk>
 <20150601050504.GH3140@localhost>
 <20150602103843.GF14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3796B265057
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 14:24:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150602103843.GF14071@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 02, 2015 at 11:38:43AM +0100, Mark Brown wrote:
> On Mon, Jun 01, 2015 at 10:35:04AM +0530, Vinod Koul wrote:
> > On Fri, May 29, 2015 at 06:35:03PM +0100, Mark Brown wrote:
> > > On Fri, May 29, 2015 at 01:45:44PM +0530, Vinod Koul wrote:
> 
> > > > well userspace parsing is only for the pin mapping and changes which
> > > > users want to do on their systems. For basic things the default graph
> > > > will be read by existing HDA parser and codec driver will create
> > > > widgets based on that. The generic HDA codec library should do most and
> > > > the HDA ASoC codecs should do device specfic work (like existing
> > > > patch_xxx)
> 
> > > So we *are* planning to continue to use the existing CODEC support but
> > > with some different interfacing on top of it?
> 
> > Nope. Existing codecs wont be reused here.
> 
> > We are doing new ASoC HDA codec drivers which use common hdac parsing logic.
> > Since some codecs need own methods we can't write a single HDA generic
> > codec, and had to do with generic codec parser and then specfic driver
> > (HDMI, ALC to start with) on top.
> 
> But I thought we already had a generic CODEC parser?  Are you saying
> you're going to write a new one?
No I meant we are going to use shiny new HDAC codec parser and build ASoC
HDA codecs which use this new parser.

-- 
~Vinod
