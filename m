From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC PCM formats
Date: Mon, 9 Jun 2008 10:17:43 +0100
Message-ID: <20080609091742.GA17278@sirena.org.uk>
References: <9e4733910806061700r6650ded8j7c7680e4774d327d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BA3E24912
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jun 2008 11:17:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910806061700r6650ded8j7c7680e4774d327d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 06, 2008 at 08:00:04PM -0400, Jon Smirl wrote:

> Why is the AC97 format set to S16 in all of the drivers? The link is
> 20b and my codec takes 20b, how do I get 20b data to the device? I
> tried using SNDRV_PCM_FORMAT_S20_3BE but all I get is static.

The format that is set needs to correspond to what your AC97 controller
needs as input.  The setting for the codec just needs to match one of
the supported ones for the controller - the specific memory layout of
the data should not be important, the controller ought to reformat the
data into whatever is appropriate for the bus.

This isn't entirely ideal but in practice works well since most
controllers need samples in pretty much the form they're outputing and
so the sample size in RAM usually needs to correspond to the sample size
that appears on the bus.

As Clemens said, try S32.
