From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 2/2] ASoC: add compress stream support
Date: Mon, 6 Aug 2012 13:59:40 +0100
Message-ID: <20120806125940.GH16861@opensource.wolfsonmicro.com>
References: <1343716900-23491-1-git-send-email-vinod.koul@linux.intel.com>
 <1343716900-23491-3-git-send-email-vinod.koul@linux.intel.com>
 <1344231121.1726.14448.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F17E62652D9
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 14:29:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1344231121.1726.14448.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, namartax.kohli@intel.com, lrg@ti.com, ramesh.babu@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 06, 2012 at 11:02:01AM +0530, Vinod Koul wrote:
> On Tue, 2012-07-31 at 12:11 +0530, Vinod Koul wrote:

> > -snd-soc-core-objs += soc-pcm.o soc-io.o
> > +snd-soc-core-objs += soc-pcm.o soc-compress.o soc-io.o 

> I am planning to add a symbol, SND_SOC_COMPRESS_OFFLOAD and compile this
> file and other changes under this flag.
> This will select SND_COMPRESS_OFFLOAD and users should select this
> symbol when using compressed offload...

> Let me know if its fine and will send patch for this.

To be honest given the code for compressed stuff is so small in
comparison with the size of ASoC that I'm not sure it's worth bothering,
we should probably just enable it unconditionally with ASoC. 
