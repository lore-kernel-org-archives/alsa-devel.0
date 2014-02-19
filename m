From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Fix sparse warnings for
	firmware loader.
Date: Wed, 19 Feb 2014 11:10:30 +0000
Message-ID: <1392808230.2351.43.camel@loki>
References: <1392807637-4767-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392808000.2351.40.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E78DF2652C5
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 12:10:34 +0100 (CET)
In-Reply-To: <1392808000.2351.40.camel@loki>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2014-02-19 at 11:06 +0000, Liam Girdwood wrote:
> On Wed, 2014-02-19 at 11:00 +0000, Liam Girdwood wrote:
> > Sparse gives us the following warning on sst-firmware.c
> > 
> >   CHECK   sound/soc/intel/sst-firmware.c
> > sound/soc/intel/sst-firmware.c:39:34: warning: incorrect type in argument 1 (different address spaces)
> > sound/soc/intel/sst-firmware.c:39:34:    expected void volatile [noderef] <asn:2>*dst
> > sound/soc/intel/sst-firmware.c:39:34:    got void *
> > sound/soc/intel/sst-firmware.c:417:36: warning: incorrect type in argument 1 (different address spaces)
> > sound/soc/intel/sst-firmware.c:417:36:    expected void *dest
> > sound/soc/intel/sst-firmware.c:417:36:    got void [noderef] <asn:2>*
> > sound/soc/intel/sst-firmware.c:430:5: warning: symbol 'sst_block_module_remove' was not declared. Should it be static?
> > 
> 
> Btw, the last warning appears to be a false positive as
> sst_block_module_remove is exported as GPL symbol.
> 

Ignore me. Sorry for the noise, I shouldn't send patches and be on calls
at the same time ;)

I'll resend fixes for both.

Liam

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
