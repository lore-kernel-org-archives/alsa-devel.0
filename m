From: Rick Bronson <rick@efn.org>
Subject: Re: WM8731 using I2S on omap3 McBSP2 issues
Date: Mon, 28 Sep 2009 14:15:10 -0700
Message-ID: <E1MsNYs-00066Y-NL@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from samwise.efn.org (efn.org [206.192.230.249])
	by alsa0.perex.cz (Postfix) with ESMTP id DC1F110384C
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Sep 2009 23:15:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Peter,

  I'm getting a XUNDFLSTAT (indicates a real underflow condition) and
XEMPTYEOF (Transmit buffer empty at end of frame) in
MCBSPLP_IRQSTATUS_REG.  Does this tell you anything?

  Rick
