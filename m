From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Remove byte swap in 4x12
	SPI	write
Date: Wed, 11 May 2011 20:05:27 +0200
Message-ID: <20110511180526.GB21150@opensource.wolfsonmicro.com>
References: <1305114833-7553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4DCAC8E9.2060605@metafoo.de>
	<20110511174836.GA22798@sirena.org.uk>
	<4DCACF32.9090802@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 27FB6103964
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 20:11:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DCACF32.9090802@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mike Frysinger <vapier.adi@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, May 11, 2011 at 11:02:26AM -0700, Lars-Peter Clausen wrote:

> Ok, could you comment again on this[1] then?
> Because what the patch did was switching the codec from 16-bit to 8-bit
> transfers, because of the issues described above.

That's exactly what I'm saying we should do, yes.
