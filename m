From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.37
Date: Wed, 06 Oct 2010 10:25:40 +0100
Message-ID: <1286357140.9697.17.camel@dplaptop>
References: <20101005191359.GA23315@opensource.wolfsonmicro.com>
	<s5h4ocz6doz.wl%tiwai@suse.de> <20101006063401.GB17998@sirena.org.uk>
	<s5hzkur4x0g.wl%tiwai@suse.de> <20101006073104.GC17998@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8ECFD24462
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 11:25:43 +0200 (CEST)
In-Reply-To: <20101006073104.GC17998@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam@alsa-project.org, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-10-06 at 08:31 +0100, Mark Brown wrote:
On Wed, Oct 06, 2010 at 09:10:23AM +0200, Takashi Iwai wrote:
> 
> > If the above difference is intentional, it should be commented
> > somewhere.
> 
> Meh, yes.  Dimitris, please fix or add a comment as appropriate.
> 

In snd_soc_7_9_spi_write we prepare the tx buffer to be register
followed by data packed into 16 bits.  In snd_soc_4_12_spi_write the tx
buffer is swapped.  I'd expect this to be consistent between the two
transfers.

Thanks,
Dimitrios
