From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: system suspend and live audio streams
Date: Mon, 16 Apr 2012 13:24:27 +0100
Message-ID: <20120416122426.GA6253@sirena.org.uk>
References: <CANOLnON2pL5tF2pDHzZ+UEBhtTG1cUmonv5pvs3SrwdtWxcJUw@mail.gmail.com>
	<4F8B1EF3.9040802@bitmer.com> <4F8BF729.20906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 09FD824385
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 14:24:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4F8BF729.20906@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Grazvydas Ignotas <notasas@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 16, 2012 at 01:40:41PM +0300, Peter Ujfalusi wrote:

> What we need to do is to have proper register store/restore for McBSP to
> support suspend during audio activity. But. Even with that if the McBSP
> is hitting OFF mode we will loose the McBSP FIFO content (invalidated).
> This means we are going to have missing samples. Probably the user will
> not going to notice it, but it is going to happen.

> I'm sure this issue present on other platforms as well. The pm_runtime
> is handled by the core, we should have suspend/resume checked in ASoC
> core, if there's an issue we need to fix it. After that the McBSP
> store/restore need to be implemented.

If the driver is using runtime PM and needs to ensure that a reference
is held outside of audio streaming then it should be taking care of
holding a reference itself.

Tegra is now handling this using the regmap cache infrastructure to make
the device powerdown transparent.
