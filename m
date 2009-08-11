From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: DaVinci: pcm,
 fix underruns by using sram
Date: Tue, 11 Aug 2009 10:59:52 +0100
Message-ID: <20090811095952.GA7494@rakim.wolfsonmicro.main>
References: <1249602935-1267-1-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-2-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-3-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-4-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-5-git-send-email-troy.kisky@boundarydevices.com>
	<4A7B8C02.6020902@boundarydevices.com>
	<20090808091708.GG4519@sirena.org.uk>
	<4A80BC13.2040808@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7CCD24B43
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Aug 2009 11:59:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A80BC13.2040808@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 10, 2009 at 05:32:19PM -0700, Troy Kisky wrote:

> On question I had concerns davinci_pcm_hardware. It is currently for both playback
> and capture. Since allocate_sram contains "davinci_pcm_hardware.period_bytes_max = size;,"
> should I change davinci_pcm_hardware to playback_pcm_hardware, capture_pcm_hardware?

I guess you'll need to, yes.
