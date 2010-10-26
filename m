From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320dac33: Error handling for
	broken chip
Date: Tue, 26 Oct 2010 11:08:16 -0700
Message-ID: <20101026180815.GC11207@opensource.wolfsonmicro.com>
References: <1288082759-25276-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E2A441037E3
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Oct 2010 20:08:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1288082759-25276-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 26, 2010 at 11:45:59AM +0300, Peter Ujfalusi wrote:

> Correct/Implement handling of broken chip.
> Fail the soc_prope if the communication with the chip
> fails (can not read chip ID).

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
