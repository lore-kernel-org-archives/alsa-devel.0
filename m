From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC sst: Add mid platform driver
Date: Mon, 3 Jan 2011 15:28:17 +0000
Message-ID: <20110103152817.GB6783@opensource.wolfsonmicro.com>
References: <1293707573-8340-1-git-send-email-vinod.koul@intel.com>
	<20110102134134.GD4935@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630104C10F2BDF@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 875A3103836
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 16:27:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630104C10F2BDF@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "Harsha,
	Priya" <priya.harsha@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 03, 2011 at 11:03:16AM +0530, Koul, Vinod wrote:

> > > +	return stream->stream_info.buffer_ptr;

> > I suspect you need to return bytes_to_frames() of this...

> No as the DSP FW returns the frame value for the pointer

In that case your buffer_ptr name is not at all clear - it's not a
pointer, it's a frame index.
