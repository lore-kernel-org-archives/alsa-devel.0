From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v10 08/13] regmap: add SLIMbus support
Date: Thu, 14 Dec 2017 10:47:39 +0530
Message-ID: <20171214051739.GV18649@localhost>
References: <20171211234307.14465-1-srinivas.kandagatla@linaro.org>
 <20171211234307.14465-9-srinivas.kandagatla@linaro.org>
 <20171213092537.GB12631@kroah.com>
 <20171213160611.GO6416@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 88D36266D71
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 06:13:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171213160611.GO6416@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Jonathan Corbet <corbet@lwn.net>, pombredanne@nexb.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, sdharia@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 13, 2017 at 04:06:11PM +0000, Mark Brown wrote:
> > On Mon, Dec 11, 2017 at 11:43:02PM +0000, srinivas.kandagatla@linaro.org wrote:
> 
> > Mark, can I get an Ack for this patch so I can take it through my tree
> > with the other patches in this series?
> 
> I'm actually not seeing a direct dependency here (there's a depends in
> place stopping the regmap code building if the Slimbus core isn't
> enabled) so if you want you can go ahead and apply the main stuff and I
> can apply the regmap change separately, it'll avoid Makefile/Kconfig
> conflicts anyway.

+ Takashi

FWIW, since this is another MIPI Audio specfic bus, would it make sense for
this series to go thru sound/ tree? I have discussed with Takashi and Greg
for soundwire and we are taking sound path.

Would that be okay here too? Either ways I dont mind :)

Thanks
-- 
~Vinod
