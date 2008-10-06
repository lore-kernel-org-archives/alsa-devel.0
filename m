From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC WM8510 Mic PGA problem
Date: Mon, 6 Oct 2008 11:05:22 +0100
Message-ID: <20081006100522.GB14087@sirena.org.uk>
References: <B9D3C48C98930741A166756A50C44A610F17B555@helx1.corp.vaisala.com>
	<20081003133936.GD26035@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B556@helx1.corp.vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 72629243E0
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Oct 2008 12:05:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B9D3C48C98930741A166756A50C44A610F17B556@helx1.corp.vaisala.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext-jukka.hynninen@vaisala.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 06, 2008 at 10:20:55AM +0300, ext-jukka.hynninen@vaisala.com wrote:

> I'm looking at the amixer settings, commands

> $> amixer sset "Mic PGA" on
> $> arecord -c 1 --rate=48000 --format=S16_LE |aplay &
> $> amixer sget "Mic PGA"
> 
> report that the mixer control state is [off] again. Looking at the
> codec_reg on sysfs verifies that the PGA Mute bit (0x2d:6) is set.

Could you confirm when the state of the control changes - looks like
it's when the recording/playback start?

> > It might help if you were able to provide your machine driver.

> The driver is playpaq_wm8510.c

Ah, right.  I don't suppose I could persuade you to join the efforts
testing Sedji Gaouaou's recent code to unify the AT91 and AVR32 ASoC
platform support?  Geoffrey Wossum did offer to help out with that
already.
