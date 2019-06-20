From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] ASoC: Intel: Skylake: Switch to modern
 UUID API
Date: Thu, 20 Jun 2019 18:09:07 +0300
Message-ID: <20190620150907.GG9224@smile.fi.intel.com>
References: <20190619150213.87691-1-andriy.shevchenko@linux.intel.com>
 <a987bd54-5364-f046-a928-44a97ed0307f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D295BF80C15
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2019 17:09:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <a987bd54-5364-f046-a928-44a97ed0307f@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 19, 2019 at 05:46:34PM +0200, Pierre-Louis Bossart wrote:
> On 6/19/19 5:02 PM, Andy Shevchenko wrote:
> > Switch the driver to use modern UUID API, i.e. guid_t type and
> > accompanying functions, such as guid_equal().
> > 
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Looks good to me - couple of nit-picks below on unrelated indentation
> changes.
> 
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks for review!

> >   	char mod_name[64]; /* guid str = 32 chars + 4 hyphens */
> > -	uuid_le *uuid_mod;
> > -	uuid_mod = (uuid_le *)guid;
> >   	snprintf(mod_name, sizeof(mod_name), "%s%pUL%s",
> > -				"intel/dsp_fw_", uuid_mod, ".bin");
> > +					     "intel/dsp_fw_", guid, ".bin");
> 
> indentation looks off, not sure if this is a diff effect.

Ah, this can be modified to the below (by a separate patch, since Mark applied
this one already):

	snprintf(mod_name, sizeof(mod_name), "intel/dsp_fw_%pUL.bin", guid);

What do you think?

P.S. And it will take only one line.

-- 
With Best Regards,
Andy Shevchenko
