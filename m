From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: samsung dma - Don't indicate
 support for pause/resume.
Date: Thu, 6 Sep 2012 18:56:39 +0800
Message-ID: <20120906105626.GH22330@opensource.wolfsonmicro.com>
References: <1346488699-11027-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1765C2615D4
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 16:22:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1346488699-11027-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, clemens@ladisch.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 01, 2012 at 01:38:19AM -0700, Dylan Reid wrote:
> The pause and resume operations indicate that the stream can be
> un-paused/resumed from the exact location they were paused/suspended.
> This is not true for this driver, the pause and suspend triggers share
> the same code path with stop, they flush all pending DMA transfers.

Applied, thanks.
