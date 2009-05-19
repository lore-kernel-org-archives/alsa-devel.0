From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Fix Analog capture path
	for AUXR
Date: Tue, 19 May 2009 09:50:06 +0100
Message-ID: <20090519085006.GA24884@rakim.wolfsonmicro.main>
References: <1242719463-17508-1-git-send-email-peter.ujfalusi@nokia.com>
	<1242719463-17508-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 35FBC24683
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 10:50:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1242719463-17508-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, anuj.aggarwal@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 19, 2009 at 10:51:03AM +0300, Peter Ujfalusi wrote:
> AUXR is selected by bit 2 and not by bit 1 in the ANAMICR register.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Applied, thanks.
