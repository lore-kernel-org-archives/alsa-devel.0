From: Rick Bronson <rick@efn.org>
Subject: Re: WM8731 using I2S on omap3 McBSP2 issues
Date: Fri, 25 Sep 2009 07:31:47 -0700
Message-ID: <E1MrBpr-000221-BB@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from samwise.efn.org (efn.org [206.192.230.249])
	by alsa0.perex.cz (Postfix) with ESMTP id AF89F10380E
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Sep 2009 16:31:51 +0200 (CEST)
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

Hi Peter,

  I forgot to tell you that if I deliberately misconfigure the
McBXP_CLKS pin so that it's an output, the FSX -> DACLRC/ADCLRC signal
stops.  This should indicate that the CLKOUT signal is actually making
it to the CLKS pin on the OMAP.  Right?

  Rick
