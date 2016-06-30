From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [RFC 02/11] ASoC: Add dai_ops to set the stream
	tag.
Date: Thu, 30 Jun 2016 14:29:07 +0530
Message-ID: <20160630085907.GO14022@subhransu-desktop>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
 <1466999284-14782-3-git-send-email-subhransu.s.prusty@intel.com>
 <20160627173009.GF17217@sirena.org.uk>
 <20160628052138.GI14022@subhransu-desktop>
 <20160628111520.GL17217@sirena.org.uk>
 <20160629040810.GN14022@subhransu-desktop>
 <20160629185023.GQ6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8035026578F
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2016 11:02:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160629185023.GQ6247@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 29, 2016 at 07:50:23PM +0100, Mark Brown wrote:
> On Wed, Jun 29, 2016 at 09:38:11AM +0530, Subhransu S. Prusty wrote:
> > On Tue, Jun 28, 2016 at 12:15:20PM +0100, Mark Brown wrote:
> > > On Tue, Jun 28, 2016 at 10:51:38AM +0530, Subhransu S. Prusty wrote:
> 
> > > > This is HDA specific and the tag is to support use of same DMA channel by
> > > > both host and codec.
> 
> > > What is a "DMA channel"?
> 
> > Ok. I agree this looks like TDM and we should model it like that :)
> 
> > Now, the issue is how? The current TDM API doesn't seem so intutive to
> > invoke for this case. What do you suggest...
> 
> Without knowing what tags and DMA channels are it's hard to make
> suggestions...

Hi Mark,

Sure. Let me explain more.

Each DMA channel can be mapped to a stream in HDA. Each stream is mapped
uniquely with a stream tag. The stream is programmed in both host and
codec. In host the DMA is programmed with this stream tag and based on this
DMA picks data from host buffer and puts it onto the link. Similarly the
codec converter is programmed with the same stream tag and codec receives
packet from the link associated with the stream tag.

Regards,
Subhransu


-- 
