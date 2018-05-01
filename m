From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 1/4] ASoC: fsl_ssi: Switch to SPDX
	identifier
Date: Mon, 30 Apr 2018 21:06:58 -0500
Message-ID: <83529f99-dfa0-25d3-fa2c-fd69a74c3ead@tabi.org>
References: <1525132518-27663-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id D523626762F
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 04:07:01 +0200 (CEST)
In-Reply-To: <1525132518-27663-1-git-send-email-festevam@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 4/30/18 6:55 PM, Fabio Estevam wrote:
> +// SPDX-License-Identifier: GPL-2.0
> +//

I thought only the SPDX header is supposed to use // and the rest of the 
comment should still be /* */.

> - * Copyright 2007-2008 Freescale Semiconductor, Inc.

I don't think you're supposed to remove copyright statements.
