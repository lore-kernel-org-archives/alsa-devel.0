From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: wm8974 and sam9g45 atmel
Date: Fri, 10 Jun 2011 11:31:18 +0100
Message-ID: <20110610103118.GA26441@sirena.org.uk>
References: <4DF0E2B4.7040401@ecsproject.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 29A2E103826
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 12:31:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DF0E2B4.7040401@ecsproject.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michele Da Rold <michele.darold@ecsproject.com>
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 09, 2011 at 05:11:48PM +0200, Michele Da Rold wrote:
> Hello everybody, I'm starting a new development with a Atmel SAM9G45 and 
> a WM8974.

Please always CC maintainers on mails - traffic on the mailing list is
easily lost.

> I'm using kernel 2.6.33.2

This kernel is *very* old - I would strongly recommend updating to a
more current kernel if you're looking for support.

> Putting some dedug messagge the driver not call the function 
> "set_bias_level", and call the mute function with mute=0.
> Testing the MCLK signal I not see any clock on pin because I never call 
> clk_enable!!

Have you routed audio from the DAI to an output using the ALSA controls?
If you haven't connected an output path up then the kernel won't power
anything on.
