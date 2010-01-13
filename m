From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA DMIX support without MMAP ?
Date: Wed, 13 Jan 2010 11:27:28 +0000
Message-ID: <20100113112727.GA23853@sirena.org.uk>
References: <22118431.247131263375996658.JavaMail.weblogic@epml17>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3620B103849
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 12:27:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <22118431.247131263375996658.JavaMail.weblogic@epml17>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ANISH KUMAR <anish.singh@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 13, 2010 at 09:46:36AM +0000, ANISH KUMAR wrote:

> Problem is when i am trying to use dmix plugin i am not getting any sound (logs shown below).Is it because i don't have mmap mode support on my device???

mmap is supported by the Samsung drivers.

> If yes then can't dmix work without mmap mode???   Logs shown below:
> 
> Entered s3c24xx_pcm_hw_params,
> Entered s3c24xx_pcm_hw_params, line 330
> Entered s3c24xx_pcm_mmap
> Entered s3c24xx_pcm_prepare
> Entered s3c24xx_pcm_enqueue
> Entered s3c24xx_pcm_trigger
> Entered s3c24xx_pcm_pointer
> Entered s3c24xx_pcm_pointer res_value[0]
> snd_pcm_update_hw_ptr_pos xun: [0]occured XRUN!

This looks like the dmix data rates are getting out of sync with what
the hardware is doing.  Enabling CONFIG_SND_PCM_XRUN_DEBUG will produce
more diagnostic information from the driver side.
