From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/3] ASoC: Blackfin: add
	multi-channel	supporting in Blackfin ASoC driver and AD1980
	codec driver
Date: Tue, 21 Oct 2008 10:49:16 +0100
Message-ID: <20081021094915.GG10841@sirena.org.uk>
References: <s5hhc762sp1.wl%tiwai@suse.de>
	<0F1B54C89D5F954D8535DB252AF412FA02E662F8@chinexm1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B8F31103807
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 12:01:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA02E662F8@chinexm1.ad.analog.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Cai, Cliff" <Cliff.Cai@analog.com>
Cc: Takashi Iwai <tiwai@suse.de>, Bryan Wu <cooloney@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 21, 2008 at 05:48:56PM +0800, Cai, Cliff wrote:
> >From: Takashi Iwai [mailto:tiwai@suse.de] 

> >But, CONFIG_SND_MULTICHAN_SUPPORT would change any buffer 
> >allocation behavior?  I don't find it...

> It will change the ac97 frame size defined in bf5xx-ac97.h,the frame
> size the basic unit of the DMA buffer 

So this is purely a restriction in the driver, rather than a property of
the hardware - is there any reason why you can't change the size of
buffer that you allocate at runtime?
