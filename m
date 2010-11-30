From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ASoC: tpa6130a2: Use one event handler
	for PGA_E
Date: Tue, 30 Nov 2010 14:25:39 +0000
Message-ID: <20101130142539.GK7403@rakim.wolfsonmicro.main>
References: <1291125604-10396-1-git-send-email-peter.ujfalusi@nokia.com>
	<1291125604-10396-4-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3FA0F244AF
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 15:25:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291125604-10396-4-git-send-email-peter.ujfalusi@nokia.com>
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

On Tue, Nov 30, 2010 at 04:00:02PM +0200, Peter Ujfalusi wrote:
> Reduce the amount of duplicated code by using single
> event handler for PGA_E to enable the needed channel.
> Use the w->shift to pass the channel information to
> the handler function.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
