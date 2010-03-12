From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: PCM_RATE: Check for KNOT and
 CONTINUOUS flags
Date: Fri, 12 Mar 2010 08:26:39 +0000
Message-ID: <1268382399.3755.7.camel@odin>
References: <1268368732-27758-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 797701038F3
	for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2010 09:26:43 +0100 (CET)
Received: by bwz20 with SMTP id 20so1957424bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2010 00:26:43 -0800 (PST)
In-Reply-To: <1268368732-27758-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-03-12 at 13:38 +0900, Jassi Brar wrote:
> For ASoC, if either CPU or CODEC driver has set the flag, the MACHINE driver
> should be given a chance to figure out if the dai, that set the flag, can
> accomodate a rate that it does not explicitly specify but is specified
> by the dai at the other end of the link.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
