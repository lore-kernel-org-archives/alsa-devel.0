From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/1] ASoC: Intel: Use acpi_dev_present()
Date: Mon, 18 Jan 2016 21:59:10 +0530
Message-ID: <20160118162910.GR11130@localhost>
References: <cover.1452787340.git.lukas@wunner.de>
 <04b22878b2fa0a00bad68e1570502fe64f94fb25.1452787340.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C797261B28
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 17:25:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <04b22878b2fa0a00bad68e1570502fe64f94fb25.1452787340.git.lukas@wunner.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Fang, Yang A" <yang.a.fang@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 14, 2016 at 09:57:20PM +0100, Lukas Wunner wrote:
> Use shiny new acpi_dev_present() and remove all the boilerplate
> to search for a particular ACPI device. No functional change.
> Cf. 2d12b6b381ba ("ACPI / utils: Add acpi_dev_present()").
> 
> v2: Rebase on commit 95f098014815 ("ASoC: Intel: Move apci find
>     machine routines").
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Fang, Yang A <yang.a.fang@intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Looks good to me but would like to test it, so once-rc1 is out, will test
that and come back


-- 
~Vinod
