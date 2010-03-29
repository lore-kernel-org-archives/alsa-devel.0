From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: bug in spi and i2c dual buses codecs
Date: Mon, 29 Mar 2010 10:49:38 +0100
Message-ID: <20100329094938.GB29441@rakim.wolfsonmicro.main>
References: <3c17e3571003282324t2b0cf67aj93dc3c4d1e6c8ae5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 63B5410381D
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Mar 2010 11:49:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3c17e3571003282324t2b0cf67aj93dc3c4d1e6c8ae5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 29, 2010 at 02:24:28PM +0800, Barry Song wrote:

> In fact, if any bus is compiled as module and code is built-in, link error
> will be reported.

Yes, this is expected behaviour.  It's not been a practical problem -
the combination of audio built in and one of the buses modular is far
from common.
