From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/3] ASoC: cs4270: fix Master Capture
	Switch polarity
Date: Mon, 27 Apr 2009 08:53:49 -0500
Message-ID: <ed82fe3e0904270653g7324fdd6o23daab01da406628@mail.gmail.com>
References: <1240578026-1987-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 762CA103819
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 15:53:51 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1838125qwk.56
	for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2009 06:53:50 -0700 (PDT)
In-Reply-To: <1240578026-1987-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 24, 2009 at 8:00 AM, Daniel Mack <daniel@caiaq.de> wrote:
> The control modifies the MUTE register, hence the polarity must be
> inverted.
>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Mark Brown <broonie@sirena.org.uk>
> Cc: Timur Tabi <timur@freescale.com>

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
