From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: TWL4030: Capture route runtime DAPM
	ordering fix
Date: Tue, 3 Aug 2010 15:19:41 +0100
Message-ID: <20100803141941.GE25306@rakim.wolfsonmicro.main>
References: <1280826061-24099-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 69B80244BF
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 16:19:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1280826061-24099-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 03, 2010 at 12:01:01PM +0300, Peter Ujfalusi wrote:
> Fix the ordering problem in DAPM domain, when the user
> changes between digital and analog sources during active
> capture (or loopback) scenario.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
