From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Embedded I2S / 192khz
Date: Thu, 8 May 2008 15:08:57 +0100
Message-ID: <20080508140856.GC23041@sirena.org.uk>
References: <76366b180805080650p615851afi272602115ca1660a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AFE38246C6
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 16:08:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <76366b180805080650p615851afi272602115ca1660a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 08, 2008 at 09:50:32AM -0400, Andrew Paprocki wrote:

> Is anyone aware of a Linux/ALSA capable chip that can drive 192khz
> I2S? I poked through the ASoC code and could only see 96khz
> capability.

The PowerPC code in sound/soc/fsl (as of 2.6.25) supports up to 192kHz,
though it appears to require the codec to clock the bus.  The SuperH and
Alchemy code in:

   git://opensource.wolfsonmicro.com/linux-2.6-asoc

says they support up to 192kHz too.  PXA3xx should support this too when
it's done.
