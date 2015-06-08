From: Sergey Kiselev <sergey.kiselev@intel.com>
Subject: Re: [PATCH v2] ASoC: wm8731: initialize the hardware
 when loading the codec driver
Date: Mon, 8 Jun 2015 12:34:50 -0700
Message-ID: <20150608123450.8acd0eeae32d852b39cab41e@intel.com>
References: <20150605115527.d7c116e0dfbc751f066d417c@intel.com>
 <20150608180155.GQ14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CBF792612AE
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 21:34:52 +0200 (CEST)
In-Reply-To: <20150608180155.GQ14071@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 8 Jun 2015 19:01:55 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Jun 05, 2015 at 11:55:27AM -0700, Sergey Kiselev wrote:
> > From: Sergey Kiselev <sergey.kiselev@intel.com>
> > 
> > This patch moves the requesting supplies, hardware reset and
> > initialization from wm8731_probe to wm8731_i2c_probe and wm8731_spi_probe.
> 
> This doesn't apply against current code, please check and resend.

Weird. Works for me. I am using
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
for-next branch.

-- 
Sergey
