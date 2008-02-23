From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC - Output widgets
Date: Sat, 23 Feb 2008 15:57:59 +0000
Message-ID: <20080223155758.GA7454@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7422C24367
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 16:58:00 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexandre BOUIN <a.bouin@kerlink.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 22, 2008 at 05:39:54PM +0100, Alexandre BOUIN wrote:

> Using ASoC layer, I'd like to perform this example behaviour with my widgets
> : 
>  - 1 output mixer MIXOUT is connected to 2 outputs OUT1 and OUT2
>  - OUT1 and OUT2 can be powered independently
> This seems easy, but atm while one is powered, the other is powered too.

I may be misunderstanding what you're doing here but I suspect that
you need to use snd_soc_dapm_set_endpoint() to mark the outputs that are
not in use as disconnected.  If you do that then then DAPM will not
power up the relevant output path.

You can do this at any point at run time - see sound/soc/pxa/tosa.c for
an example of this.
