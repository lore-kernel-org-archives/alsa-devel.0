From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v4 3/6] core: add compress parameter
 definations
Date: Thu, 22 Dec 2011 13:46:30 +0530
Message-ID: <1324541790.1641.10129.camel@vkoul-udesk3>
References: <1323070791-12620-1-git-send-email-vinod.koul@linux.intel.com>
	<1323766980-9350-4-git-send-email-vinod.koul@linux.intel.com>
	<s5hy5u5njnc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 1555324450
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 09:16:36 +0100 (CET)
In-Reply-To: <s5hy5u5njnc.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-12-22 at 08:35 +0100, Takashi Iwai wrote:
> At Tue, 13 Dec 2011 14:32:57 +0530,
> Vinod Koul wrote:
> > 
> > The patch adds the various definations used to define the encoder
> > and decoder parameters
> > 
> > Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
> > Signed-off-by: Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com>
> > Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
> > ---
> >  include/sound/snd_compress_params.h |  395
> +++++++++++++++++++++++++++++++++++
> 
> I wonder why snd_ prefix is added to this header file.
> It's no big issue, but it looks redundant :)
> 
Well that was first file to be coded and somehow snd_ was added to this
and not to others.
Will drop it :)

-- 
~Vinod
