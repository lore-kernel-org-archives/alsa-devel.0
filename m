From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCHv2] ASoC: Intel: sst-acpi: Request firmware
 before SST platform driver probing
Date: Wed, 19 Feb 2014 13:50:32 +0000
Message-ID: <1392817832.2351.51.camel@loki>
References: <1392798638-20767-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20140219122506.GN2669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 67B862652CD
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 14:50:37 +0100 (CET)
In-Reply-To: <20140219122506.GN2669@sirena.org.uk>
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
Cc: "Koul, Vinod" <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2014-02-19 at 21:25 +0900, Mark Brown wrote:
> On Wed, Feb 19, 2014 at 10:30:38AM +0200, Jarkko Nikula wrote:
> > We originally thought to request SST audio DSP firmware during the SST
> > platform driver initialization. However plain request_firmware doesn't
> > work in driver probe paths if userspace is not ready to handle it. For
> > instance when drivers are built-in.
> 
> The more usual thing to do here is to only request the firmware when the
> device is actually being used (in this case on open).  This also allows
> the firmware to be replaced easily at runtime which is helpful too.  It
> seems like this is still an improvement though so I've applied it.

Fwiw, we need to load the FW at probe time since it will contain the FW
topology for the SST drivers. The next phase for the SST FW is to use
the ASoC firmware loader for DAPM, Kcontrols + DAI links (Vinod is
working on patch for DAI links iirc, I will be back to the fw loader
next week if all goes to plan). The good news is that the ASoC FW loader
can also unload FW so we should be able to re-load FW at runtime too :)

Liam
