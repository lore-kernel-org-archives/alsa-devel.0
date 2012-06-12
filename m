From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/3] mfd/ab8500: Move platform-data for
	ab8500-codec into mfd-driver
Date: Tue, 12 Jun 2012 16:21:51 +0200
Message-ID: <CACRpkdb=y2KuDxm4-bu7H=R5gKKdqhwfgzTYCL6YwGrj5_6iyQ@mail.gmail.com>
References: <1339070446-15186-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B88C7245A9
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2012 16:21:52 +0200 (CEST)
Received: by qcse14 with SMTP id e14so2862580qcs.38
	for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2012 07:21:51 -0700 (PDT)
In-Reply-To: <1339070446-15186-1-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 7, 2012 at 2:00 PM, Ola Lilja <ola.o.lilja@stericsson.com> wrote:

> The platform-data used by the Ux500 ASoC-driver is moved from the
> machine-driver context into the codec-driver context. This means
> adding the platform-data for 'ab8500-codec' into the main AB8500
> platform-data.
>
> Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
