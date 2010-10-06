From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.37
Date: Wed, 6 Oct 2010 08:19:33 -0700
Message-ID: <20101006151932.GB2803@opensource.wolfsonmicro.com>
References: <s5h4ocz6doz.wl%tiwai@suse.de>
	<20101006063401.GB17998@sirena.org.uk>
	<s5hzkur4x0g.wl%tiwai@suse.de>
	<20101006073104.GC17998@sirena.org.uk>
	<1286357140.9697.17.camel@dplaptop> <s5hpqvnla7s.wl%tiwai@suse.de>
	<1286372404.9697.22.camel@dplaptop> <s5hiq1fl9i8.wl%tiwai@suse.de>
	<1286374422.9697.28.camel@dplaptop> <s5h8w2bl7ql.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3C34244D2
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 17:19:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h8w2bl7ql.wl%tiwai@suse.de>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Barry Song <Barry.Song@analog.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 06, 2010 at 04:24:18PM +0200, Takashi Iwai wrote:

> Yeah, I don't say it's buggy.  But it's wrong from a programming POV.
> The proper endianess handling seems missing in the current code...

I'll need to have a proper look and think but endianness handling for
SPI is somewhat amusing - SPI is natually big endinan so controllers on
little endian architectures do a byte swap to send, but only when they
run in word oriented mode.  If the word size is 8 bits they don't need
to.
