From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: jack: Push locking for jacks down to
	the jack
Date: Tue, 13 Mar 2012 18:23:27 +0000
Message-ID: <1331663007.4426.0.camel@odin>
References: <1331561306-25183-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from psmtp.com (na3sys009aog134.obsmtp.com [74.125.149.83])
	by alsa0.perex.cz (Postfix) with ESMTP id 242A424400
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 19:23:30 +0100 (CET)
Received: by mail-we0-f169.google.com with SMTP id j55so1093514wer.0
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 11:23:29 -0700 (PDT)
In-Reply-To: <1331561306-25183-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-03-12 at 14:08 +0000, Mark Brown wrote:
> Currently operations on jack reporting take the CODEC mutex both to protect
> the current jack status and also to protect the DAPM run which is triggered
> on status updates. Since the addition of a DAPM-specific lock we no longer
> need to worry about locking DAPM as it has its own finer grained lock so
> create a per jack lock to take care of the jack status.
> 
> This is both cleaner where the jack isn't specifically associated with a
> CODEC and clearer as it's much more obvious what the lock is protecting.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
