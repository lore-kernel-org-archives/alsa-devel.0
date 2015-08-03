From: Joe Perches <joe@perches.com>
Subject: Re: [TRIVIAL PATCH] ASoC: atmel_ssc_dai: Correct misuse of
 0x%<decimal>
Date: Mon, 03 Aug 2015 10:05:46 -0700
Message-ID: <1438621546.30149.42.camel@perches.com>
References: <1438546949.29569.2.camel@perches.com>
	 <20150803161527.GZ20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150803161527.GZ20873@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-08-03 at 17:15 +0100, Mark Brown wrote:
> On Sun, Aug 02, 2015 at 01:22:29PM -0700, Joe Perches wrote:
> > Correct misuse of 0x%d in logging message.
> 
> This doesn't apply, please chekc and resend.

Odd, the diff applies against the latest next-20150803 here.

OK, I see what the problem is now.

I updated evolution to 3.16 and that's not a good version.
It substitutes spaces for tabs when sending text.

I'll sort it out and resend later today or you can fix it
in the meantime.
