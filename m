From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ASoC: Add support for 19.2 MHz MCLK in
 TLV320AIC3X
Date: Tue, 15 Apr 2008 09:41:39 +0300
Message-ID: <20080415094139.0838e508.jarkko.nikula@nokia.com>
References: <1207902735-6660-1-git-send-email-jarkko.nikula@nokia.com>
	<20080414135046.GA25508@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 03A41246AB
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 08:41:34 +0200 (CEST)
In-Reply-To: <20080414135046.GA25508@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 14 Apr 2008 14:50:46 +0100
"ext Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Apr 11, 2008 at 11:32:15AM +0300, Jarkko Nikula wrote:
> > Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> 
> Thanks - I've added this to the ASoC tree and upstream queue.
> 
> Rather than maintaining this table it might be worth looking at adding
> code to allow the driver to calculate a suitable configuration at run
> time.  The WM8753 and WM9713 drivers do this for the PLL
> configuration, for example.
>
Agree, I was also thinking this some time ago but went for simple
solution first since OMAP's seems to be happy with either 12 or 19.2
MHz :-)


Jarkko
