From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [RFC 02/11] ASoC: Add dai_ops to set the stream
	tag.
Date: Fri, 8 Jul 2016 10:57:56 +0530
Message-ID: <20160708052750.GA15209@subhransu-desktop>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
 <1466999284-14782-3-git-send-email-subhransu.s.prusty@intel.com>
 <20160627173009.GF17217@sirena.org.uk>
 <20160628052138.GI14022@subhransu-desktop>
 <20160628111520.GL17217@sirena.org.uk>
 <20160629040810.GN14022@subhransu-desktop>
 <20160629185023.GQ6247@sirena.org.uk>
 <20160630085907.GO14022@subhransu-desktop>
 <20160705125403.GS6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 55C51260851
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2016 07:31:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160705125403.GS6247@sirena.org.uk>
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

On Tue, Jul 05, 2016 at 02:54:03PM +0200, Mark Brown wrote:
> On Thu, Jun 30, 2016 at 02:29:07PM +0530, Subhransu S. Prusty wrote:
> 
> > Each DMA channel can be mapped to a stream in HDA. Each stream is mapped
> > uniquely with a stream tag. The stream is programmed in both host and
> > codec. In host the DMA is programmed with this stream tag and based on this
> > DMA picks data from host buffer and puts it onto the link. Similarly the
> > codec converter is programmed with the same stream tag and codec receives
> > packet from the link associated with the stream tag.
> 
> Are these arbatrary tags?  If so why not just pick tags that look like
> normal TDM timeslots?

If I understand correctly, the tag will be programmed in the tx_mask and
all other arguments will not be used.

Regards,
Subhransu


-- 
