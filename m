From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC V2: disable automatic volume
	control in the	CS4270 sound driver
Date: Fri, 8 Aug 2008 11:54:38 +0100
Message-ID: <20080808105436.GA10867@rakim.wolfsonmicro.main>
References: <1218126153-26095-1-git-send-email-timur@freescale.com>
	<1218126153-26095-2-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CADA724AD0
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Aug 2008 12:54:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1218126153-26095-2-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 07, 2008 at 11:22:32AM -0500, Timur Tabi wrote:
> Disable the automatic volume control feature of the CS4270 audio codec.  This
> feature, which is enabled by default, causes volume change commands to be
> delayed.  Sometimes the volume change happens after playback is started.

All applied, thanks.

Should this also be done for current mainline?
