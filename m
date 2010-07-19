From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH - alsa-lib 2/3] tlv: Handle 'holes'
	in	SND_CTL_TLVT_DB_RANGE array
Date: Mon, 19 Jul 2010 17:24:17 +0100
Message-ID: <20100719162416.GD7002@sirena.org.uk>
References: <1279523646-4987-1-git-send-email-peter.ujfalusi@nokia.com>
	<1279523646-4987-3-git-send-email-peter.ujfalusi@nokia.com>
	<s5heiezfp1c.wl%tiwai@suse.de>
	<20100719160109.GC7002@sirena.org.uk>
	<s5h630bfo3x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 06E12244D5
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 18:24:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h630bfo3x.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 19, 2010 at 06:11:30PM +0200, Takashi Iwai wrote:

> Well, one remaining question is how to handle if the hardware has
> really no value in a certain range (a hole).  Fixing in alsa-lib is a
> sort of workaround, but it doesn't sound right, especially if the
> range info can be provided correctly in the source.

I guess it depends on what you're thinking of for an inexact match - if
we're doing inexact matches within the range we're already saying that
we're not giving 100% accuracy (and remember that some hardware has very
coarse control).  It seems wrong that we'd fail to match with a slighy
inaccuracy when the requested value happens to be just outside the range
but accept any old accuracy level from coarse grained steps.

> If kernel changes would become too messy, then yes, we can reconsider
> fixing this only in alsa-lib, though.

Personally I'd rather the kernel just provided a mapping between control
values and dB scales and then the application layer can decide what it
thinks an appropriate match is.  Decisions about how accurate a match is
needed seem very policy like and therefore userspaceish and it seems
wrong to be coding the data tables in the kernel in a way that works
around the particular match algorithm in the application layer.
