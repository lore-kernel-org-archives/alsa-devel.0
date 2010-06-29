From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [RFC 10/15] ASoC: multi-component - RMI Alchemy
 AU1x Platform
Date: Tue, 29 Jun 2010 14:30:15 +0200
Message-ID: <20100629123015.GA20441@wormhole>
References: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
	<1277639534-5104-11-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil48.netpark.at
	[217.175.205.176])
	by alsa0.perex.cz (Postfix) with ESMTP id B939C24610
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jun 2010 14:30:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1277639534-5104-11-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Liam,

On Sun, Jun 27, 2010 at 12:52:09PM +0100, Liam Girdwood wrote:
> Update the RMI Alchemy platform and machines to new multi-component model.
> 
> This patch changes the machine drivers for multi-component as follows :-
> 
>  o Removed socdev
>  o Each DAI link entry now contains platform and codec fields.
>  o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.
> 
> This patch also changes the DAI and platform DAM drivers as follows :-
> 
>  o Each platform DAI and platform DMA driver is a kernel device and can
>    have platform data.
>  o DAI and Platform DMA drivers have private data accessors.

Forgive the probably stupid question, but does that mean I can have
2 or more independent ASoC devices?  (A board I have has independent
AC97 and I2S systems).

Thank you,
        Manuel Lauss
