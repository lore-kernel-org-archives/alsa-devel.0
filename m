From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 2/4] mmp: support ssp in pxa168
Date: Tue, 16 Mar 2010 19:49:06 +0800
Message-ID: <f17812d71003160449h74ba2d24mfb5b9bd2485b4f38@mail.gmail.com>
References: <771cded01003100514r70f0f53eydda7b916f92bef64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id E16942414F
	for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2010 12:49:27 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 4so1000777qwk.56
	for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2010 04:49:26 -0700 (PDT)
In-Reply-To: <771cded01003100514r70f0f53eydda7b916f92bef64@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 10, 2010 at 9:14 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From 75fe4b02234f6476e72827508f11f1035d7aaf68 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 10 Mar 2010 06:32:43 -0500
> Subject: [PATCH] [ARM] mmp: support ssp in pxa168
>
> Support ssp in pxa168. The basic function of SSP is same as pxa, but clock
> source and IRQ is changed.
>

Haojian,

Could you please help rebase this against my 'ssp_cleanup' branch?
