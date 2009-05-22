From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2 take2] SoC: TWL4030 and SDP3430 HS
	ramp	configuration
Date: Fri, 22 May 2009 10:28:07 +0100
Message-ID: <20090522092807.GA20887@rakim.wolfsonmicro.main>
References: <1242976396-7667-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C496210380E
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 11:28:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1242976396-7667-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: sakoman@gmail.com, anuj.aggarwal@ti.com, alsa-devel@alsa-project.org, getarunks@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, May 22, 2009 at 10:13:14AM +0300, Peter Ujfalusi wrote:

> he following series adds support for platform dependent Headset pop removal
> configuration for the twl4030 codec.

> Platform drivers can fill the twl4030_setup_data structure and pass it with
> snd_soc_device->codec_data to the codec driver.

I've applied both.  It'd be really good if you could look into
converting the TWL4030 driver into a regular platform driver, probing
via the normal methods, so it could get this data as regular platform
data.
