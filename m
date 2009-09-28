From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM8731 using I2S on omap3 McBSP2 issues
Date: Mon, 28 Sep 2009 17:13:45 +0100
Message-ID: <20090928161345.GD32420@sirena.org.uk>
References: <E1MsIl4-0002uL-5A@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 130CC243EE
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Sep 2009 18:13:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <E1MsIl4-0002uL-5A@amazonia.comcast.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rick Bronson <rick@efn.org>
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 28, 2009 at 09:07:26AM -0700, Rick Bronson wrote:

>   I don't believe it's possible for me to try the master/slave switch.
> Please take a look at http://www.efn.org/~rick/pub/wm8731.jpg Note
> that DACLRC and ADCLRC are connected.  This requires me to run as
> slave, right?  Our bit clock line is buffered so I don't think that
> will be a problem.

Tying the DAC and ADC LRCLKs together should be fine in either master or
slave mode, I'd expect (but I am not a hardware engineer).
