From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/1] ALSA: ASoc: DaVinci Delay start of ASP
 to trigger
Date: Mon, 04 Oct 2010 11:19:21 +0100
Message-ID: <1286187561.3148.23.camel@odin>
References: <1286142259-6625-1-git-send-email-martin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D3F0243EF
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 12:19:38 +0200 (CEST)
Received: by wwc33 with SMTP id 33so29610wwc.2
	for <alsa-devel@alsa-project.org>; Mon, 04 Oct 2010 03:19:37 -0700 (PDT)
In-Reply-To: <1286142259-6625-1-git-send-email-martin@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: martin@ti.com
Cc: alsa-devel@alsa-project.org, Troy Kisky <troy.kisky@boundarydevices.com>, davinci-linux-open-source@linux.davincidsp.com, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Sun, 2010-10-03 at 16:44 -0500, martin@ti.com wrote:
> From: Troy Kisky <troy.kisky@boundarydevices.com>
> 
> Since only 4 mainline ASoC codecs support the trigger
> callback, we cannot rely upon them stopping the frame clock
> if they are master and must assume it is running even if the
> sound is paused. Thus we cannot start the ASP until the trigger
> method.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> Signed-off-by: Martin Ambrose <martin@ti.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
