From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: DaVinci: Audio: Fix swapping of
	channels at start of stereo playback
Date: Wed, 12 Nov 2008 11:50:02 +0000
Message-ID: <20081112115001.GC8767@sirena.org.uk>
References: <1226465791-14725-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9886B243CD
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 12:50:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1226465791-14725-1-git-send-email-naresh@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: naresh@ti.com
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 12, 2008 at 10:26:31AM +0530, naresh@ti.com wrote:

> Fixes swapping of channels at start of stereo playback.
> 
> Channel swap can be observed while playing left-only or right-only audio data. The channel 
> swap is fixed by handling the XSYNCERR condition.
> 
> Signed-off-by: Naresh Medisetty <naresh@ti.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Do you know what the status is on merging the DMA API that the ASoC
DaVinci driver uses into mainline?
