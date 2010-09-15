From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: Unifying sound/pci/hda/patch_*hdmi.c
Date: Wed, 15 Sep 2010 23:01:40 +0800
Message-ID: <20100915150140.GA11634@localhost>
References: <s5hsk1b12qw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id D846A24480
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Sep 2010 17:01:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hsk1b12qw.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, wni@nvidia.com
List-Id: alsa-devel@alsa-project.org

Takashi,

Since the driver will also be supporting DisplayPort audio,
would you add "DisplayPort" too in the following chunk?

        +config SND_HDA_CODEC_HDMI
==>     +       bool "Build HDMI HD-audio codec support"
                select SND_DYNAMIC_MINORS
                default y
                help
        -         Say Y here to include INTEL HDMI HD-audio codec support in
        -         snd-hda-intel driver, such as Eaglelake integrated HDMI.
==>     +         Say Y here to include HDMI HD-audio codec support in
        +         snd-hda-intel driver.  This includes all AMD/ATI, Intel and
==>     +         Nvidia HDMI codecs.
                 

Thanks,
Fengguang
