From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: tlv320aic3x: Complete the
 soc-cache conversion
Date: Tue, 14 Sep 2010 13:55:10 +0100
Message-ID: <20100914125510.GA21715@rakim.wolfsonmicro.main>
References: <1284465289-4865-1-git-send-email-jhnikula@gmail.com>
	<1284465289-4865-3-git-send-email-jhnikula@gmail.com>
	<20100914120458.GE27029@rakim.wolfsonmicro.main>
	<20100914151445.2fe7fd54.jhnikula@gmail.com>
	<20100914122139.GF27029@rakim.wolfsonmicro.main>
	<20100914154525.77e86440.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0332C24474
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Sep 2010 14:55:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100914154525.77e86440.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 14, 2010 at 03:45:25PM +0300, Jarkko Nikula wrote:

> But is it marking register as volatile due 1-2 bits causing more
> problems if we don't cache rest of the r/w bits?

Depends on what else is there - ultimately if the chip has read support
then the register cache is just a performance improvement.
