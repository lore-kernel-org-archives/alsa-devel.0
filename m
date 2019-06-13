From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 0/3] ASoC: SOF: fix suspend ordering with
 runtime idle
Date: Thu, 13 Jun 2019 17:18:36 +0300 (EEST)
Message-ID: <alpine.DEB.2.21.1906131706170.4409@eliteleevi>
References: <20190612094452.1060-1-kai.vehmanen@linux.intel.com>
 <ba5e42ab-7f1e-01b9-835d-52a1e42a0fe0@linux.intel.com>
 <s5hef3yn8s2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 165A8F80791
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 16:17:42 +0200 (CEST)
In-Reply-To: <s5hef3yn8s2.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, 12 Jun 2019, Takashi Iwai wrote:

> On Wed, 12 Jun 2019 16:46:24 +0200,
> Pierre-Louis Bossart wrote:
> > Looks good to me
> > Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> All look good.  I already replied to the first one, but feel free to
> take my ack for the rest, too:
> 
>   Reviewed-by: Takashi Iwai <tiwai@suse.de>

thanks for the reviews!

Mark, one patch in this series conflicts with a patch in Pierre's series 
sent yesterday:
  ASoC: SOF: Intel: hda: release link DMA for paused streams during suspend  
  -> in series "[PATCH 00/15] ASoC: SOF: Intel: HDaudio fixes and improvements"

We thought the runtime idle would take more time in review, so didn't send 
them in the same series, but now that the reviews seem positive, we have 
a potential conflict. You can drop the conflicting patch from my series, 
or I can rebase on top of Pierre's series and send V2 later.

Br, Kai
