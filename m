From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [PATCH V2] ASoC: SAMSUNG: Add WM8994 PCM
	Machine driver
Date: Sun, 26 Jun 2011 12:02:46 +0100
Message-ID: <20110626110245.GB16568@opensource.wolfsonmicro.com>
References: <1308558570-26593-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AD68524757
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Jun 2011 13:02:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1308558570-26593-1-git-send-email-sbkim73@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, jassisinghbrar@gmail.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2011 at 05:29:29PM +0900, Sangbeom Kim wrote:
> This patch add WM8994 PCM machine driver to support PCM audio
> on SMDKV310, SMDKC210 boards.
> Playback and Capture supports 8kHz sampling rates.
> and It is tested on SMDKV310, SMDKC210.

Applied, thanks.  We could do a bit of work to optimize the power usage
here but no need to do so right now.
