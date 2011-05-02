From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: JZ4740: Fix i2s shutdown
Date: Mon, 02 May 2011 19:33:44 +0100
Message-ID: <1304361224.3263.18.camel@odin>
References: <1304195300-5483-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 637A41037F3
	for <alsa-devel@alsa-project.org>;
	Mon,  2 May 2011 20:33:49 +0200 (CEST)
Received: by wwi18 with SMTP id 18so2505300wwi.2
	for <alsa-devel@alsa-project.org>; Mon, 02 May 2011 11:33:48 -0700 (PDT)
In-Reply-To: <1304195300-5483-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2011-04-30 at 22:28 +0200, Lars-Peter Clausen wrote:
> The i2s shutdown callback has the check whether it should be disabled reversed.
> Currently it is disabled if another stream is still active, but kept enabled if
> the last stream is closed. This patch fixes it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>
