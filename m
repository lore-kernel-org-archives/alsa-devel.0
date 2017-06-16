From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH v3] ASoC: dapm: Add new widget type
 snd_soc_dapm_dsp_component
Date: Fri, 16 Jun 2017 15:06:38 +0100
Message-ID: <1497621998.2561.32.camel@loki>
References: <1497555964-4862-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20170616110953.waxwojvnrgrnlc26@sirena.org.uk>
 <1497615984.2561.25.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 2681D2669F3
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 16:06:43 +0200 (CEST)
In-Reply-To: <1497615984.2561.25.camel@loki>
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

On Fri, 2017-06-16 at 13:26 +0100, Liam Girdwood wrote:

> 
> Ok, I can redo and use specific types, but there still is a problem of
> how do we configure a pipeline (a collection of widgets, where several
> pipelines can make a path from PCM to DAI). This configuration data is
> not hw/sw params type data, but more DSP scheduling type data. My
> original thought was the pipeline widget, as there is nothing else that
> cleanly fits into the ABI and that the pipeline scheduling data is DAPM
> widget/graph related anyway.
> 
> Another alternative is extending the topology ABI and introduce a
> pipeline object that would be ignore by the core and just used by
> certain drivers and firmwares ?
> 


I think I'm tending towards having a scheduler widget now (instead of a
pipeline widget) and that would be a valid part of the graph and also
discoverable via debugfs etc.

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
