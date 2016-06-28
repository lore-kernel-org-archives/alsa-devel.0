From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [RFC 02/11] ASoC: Add dai_ops to set the stream
	tag.
Date: Tue, 28 Jun 2016 10:51:38 +0530
Message-ID: <20160628052138.GI14022@subhransu-desktop>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
 <1466999284-14782-3-git-send-email-subhransu.s.prusty@intel.com>
 <20160627173009.GF17217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F8A52651E3
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2016 07:25:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160627173009.GF17217@sirena.org.uk>
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

On Mon, Jun 27, 2016 at 06:30:09PM +0100, Mark Brown wrote:
> On Mon, Jun 27, 2016 at 09:17:55AM +0530, Subhransu S. Prusty wrote:
> 
> > Stream tag is unique stream identifier for each HDA stream. It's
> > programmed in both host and codec to identify link the stream is
> > transported.  The platform driver allocates the stream and calls
> > this ops to program the stream tag in the codec dai.
> 
> This seems incredibly HDMI specific...  what are these tags, can we
> represent this as TDM (which seems to be what this is really)?

Hi Mark,

This is HDA specific and the tag is to support use of same DMA channel by
both host and codec.

Regards,
Subhransu

-- 
