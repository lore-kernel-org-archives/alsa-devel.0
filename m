From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5] ASoC: tpa6130a2: Add stereo DAPM path
Date: Tue, 30 Nov 2010 14:26:17 +0000
Message-ID: <20101130142617.GL7403@rakim.wolfsonmicro.main>
References: <1291125604-10396-1-git-send-email-peter.ujfalusi@nokia.com>
	<1291125604-10396-5-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2C26E103990
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 15:26:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291125604-10396-5-git-send-email-peter.ujfalusi@nokia.com>
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

On Tue, Nov 30, 2010 at 04:00:03PM +0200, Peter Ujfalusi wrote:
> New DAPM widgets, and paths to enable both channels at the
> same time (for stereo output).
> With this path the switch time difference can be avoided
> between left and right channels.
> The original DAPM paths can be still used, if only one of
> TPA's output has been connected to a speaker, but for most of
> the cases, switching to the stereo path is better.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
