From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: TWL4030: Capture route DAPM event fix
Date: Tue, 27 Jul 2010 11:44:32 +0100
Message-ID: <1280227472.3085.30.camel@odin>
References: <1280127555-8042-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C7DF24405
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 12:44:37 +0200 (CEST)
Received: by wwb18 with SMTP id 18so456985wwb.20
	for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2010 03:44:36 -0700 (PDT)
In-Reply-To: <1280127555-8042-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@Nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-07-26 at 09:59 +0300, Peter Ujfalusi wrote:
> There is no need to handle POST_PMU, POST_PMD event with
> the Capture Route widget.
> It is enough to handle POST_REG event, since that will come
> when the user changes the routing, and we will switch the needed
> bits in the registers.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
