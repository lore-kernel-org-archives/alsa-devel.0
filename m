From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.37
Date: Wed, 6 Oct 2010 07:34:01 +0100
Message-ID: <20101006063401.GB17998@sirena.org.uk>
References: <20101005191359.GA23315@opensource.wolfsonmicro.com>
	<s5h4ocz6doz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 34432103957
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 08:34:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h4ocz6doz.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 06, 2010 at 08:24:44AM +0200, Takashi Iwai wrote:

> BTW, looking through the changes, I wonder why only
> snd_soc_4_12_spi_write has the byte swap at copying msg[].  Is it
> intended or a typo?  If this is a typo, we can merge all
> snd_soc_*_spi_write() into a single function.

It's not a byte swap, it's mangling part of the register and value
together.  The others are using whole numbers of bytes.

> And, all snd_soc_x_y_read() and snd_soc_x_y_write() are fairly
> resemble, just data[] setup is different.  They can be merged well, I
> suppose.

They also differ in the type of the cache variable.  You could do
something with macros but it'd not be terribly pleasant.
