From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: Fix the incorrect
	referencing of I2SCON register
Date: Fri, 10 Jun 2011 11:11:33 +0530
Message-ID: <BANLkTinPmAH5tTV737r2q2VNa-kSqNAWig@mail.gmail.com>
References: <1307669814-9375-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 94DE724492
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 07:41:33 +0200 (CEST)
Received: by bwz10 with SMTP id 10so2109859bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 09 Jun 2011 22:41:33 -0700 (PDT)
In-Reply-To: <1307669814-9375-1-git-send-email-sbkim73@samsung.com>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 10, 2011 at 7:06 AM, Sangbeom Kim <sbkim73@samsung.com> wrote:
> If DMA active status should be checked, I2SCON register should be referenced.
> In this patch, Fix the incorrect referencing of I2SCON register.
>
> Reported-by : Lakkyung Jung <lakkyung.jung@samsung.com>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
