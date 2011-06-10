From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: Add ADAU1701 codec driver
Date: Fri, 10 Jun 2011 19:07:55 +0100
Message-ID: <20110610180755.GR26436@opensource.wolfsonmicro.com>
References: <1307726331-28618-1-git-send-email-lars@metafoo.de>
	<20110610172734.GI26441@sirena.org.uk>
	<BANLkTimN0-a++2Nd13rHGSwkVPDxU8GBhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 018D0103D27
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 20:07:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTimN0-a++2Nd13rHGSwkVPDxU8GBhQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 10, 2011 at 01:44:00PM -0400, Mike Frysinger wrote:
> On Fri, Jun 10, 2011 at 13:27, Mark Brown wrote:

> > Also someone should remonstrate with the hardware designers.

> if there's things we can take back, i can forward them along.  the
> last conversation i had with them sounded like they have no problem
> accepting feedback.

I was referring to the fact that different registers have different
sizes which does rather complicate the code.
