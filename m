From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core: Use dedicated substream ptr
	for ASoC rtd.
Date: Mon, 09 Jul 2012 11:19:43 +0100
Message-ID: <1341829183.30148.1.camel@odin>
References: <1341827730-29842-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog119.obsmtp.com (na3sys009aog119.obsmtp.com
	[74.125.149.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C24424417
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jul 2012 12:19:48 +0200 (CEST)
Received: by wgbgn7 with SMTP id gn7so11486765wgb.9
	for <alsa-devel@alsa-project.org>; Mon, 09 Jul 2012 03:19:45 -0700 (PDT)
In-Reply-To: <1341827730-29842-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-07-09 at 10:55 +0100, Liam Girdwood wrote:
> The ALSA substream private data should really be used by individual
> drivers and
> not really by the subsystem to store subsystem data. Create a
> dedicated
> rtd pointer in the PCM substream for ASoC operations.
> 
> The component driver were converted using this sed :-
> 
> sed -i 's/substream->private_data/substream->rtd/'  $(git ls-files
> sound/soc)
> 
> Signed-off-by: Liam Girdwood <lrg@ti.com>
> --- 

Cancel this one, I've left something from another patch in it.

Liam 
