From: Ian Minett <ian_minett@creativelabs.com>
Subject: Re: sound/pci/hda/patch_ca0132.c: potential null
	dereference 'dma_engine'
Date: Wed, 26 Sep 2012 19:34:37 -0700
Message-ID: <OFB81A0D1D.D43D59BD-ON88257A86.0007DC57-88257A86.000E2820@cli.creative.com>
References: <20120921102242.GA11865@localhost> <s5hmx0jppj9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-outbound2.cli.creative.com
 (smtp-outbound2.cli.creative.com [124.246.64.232])
 by alsa0.perex.cz (Postfix) with ESMTP id F1D6D262632
 for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2012 04:35:16 +0200 (CEST)
In-Reply-To: <s5hmx0jppj9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org






> FYI, there are new smatch warnings show up in
> + sound/pci/hda/patch_ca0132.c:2056 dspxfr_image() error: potential null dereference 'dma_engine'.
(kzalloc returns null)
> + sound/pci/hda/patch_ca0132.c:2056 dspxfr_image() error: we previously assumed 'dma_engine' could
be null (see line 1963)

Thank you for catching these warnings, and to Takashi for patching them!
It's greatly appreciated.

- Ian
