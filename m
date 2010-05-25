From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/7] ASoC: TWL4030: put the codec to off
	when not active
Date: Tue, 25 May 2010 10:35:59 -0700
Message-ID: <20100525173558.GA22538@opensource.wolfsonmicro.com>
References: <1274787248-18583-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 22640246A2
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 19:35:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1274787248-18583-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Tue, May 25, 2010 at 02:34:01PM +0300, Peter Ujfalusi wrote:

> The following series at the end will let the twl4030 codec to use BIAS_OFF
> instead of BIAS_STANDBY.

All

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but I do agree with Liam's comment about forcing the register values
into the expected state rather than just warning at startup.

> The difference in power consumption is about 0.5mA.

Nice.
