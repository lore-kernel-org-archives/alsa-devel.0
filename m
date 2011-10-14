From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v2 2/9] ASoC: da7210: Add support for line
 input and mic
Date: Fri, 14 Oct 2011 18:06:11 +0530
Message-ID: <1318595771.12107.542.camel@matrix>
References: <1318514644.12107.472.camel@matrix>
	<20111013161959.GI5193@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id 057B9103836
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 14:26:52 +0200 (CEST)
In-Reply-To: <20111013161959.GI5193@opensource.wolfsonmicro.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>, David@alsa-project.org, Chen <david.chen@diasemi.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-10-13 at 17:19 +0100, Mark Brown wrote:
> On Thu, Oct 13, 2011 at 07:34:04PM +0530, Ashish Chavan wrote:
> >  	} else {
> > -		/* Volume 7 */
> > -		snd_soc_update_bits(codec, DA7210_MIC_L, 0x7, 0x7);
> > -		snd_soc_update_bits(codec, DA7210_MIC_R, 0x7, 0x7);
> > -
> > -		/* Enable Mic */
> > -		snd_soc_update_bits(codec, DA7210_INMIX_L, 0x1F, 0x1);
> > -		snd_soc_update_bits(codec, DA7210_INMIX_R, 0x1F, 0x1);
> > +		/* Enable Mic,AUX1 and AUX2 */
> > +		snd_soc_update_bits(codec, DA7210_INMIX_L, 0x1F, 0xD);
> > +		snd_soc_update_bits(codec, DA7210_INMIX_R, 0x1F, 0xD);
> 
> So, I did mention that the DAPM patch should come first when I reviewed
> your previous series...
> 

Posted the series after rearranging the sequence and removing already
merged patch.

Thanks for your time.
