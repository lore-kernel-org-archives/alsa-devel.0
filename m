From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Do not read registers
 prior to turning on the supplies
Date: Fri, 31 May 2013 12:36:43 -0300
Message-ID: <CAOMZO5Ab1gfTr4Fi3jXAXtR2LEdBcT6nyNRgm3djpBeRnaz-qg@mail.gmail.com>
References: <1369749858-21579-1-git-send-email-fabio.estevam@freescale.com>
 <201305310036.11681.marex@denx.de>
 <86D15885F63D1143A519F161FB828EAF265F56@039-SN2MPN1-013.039d.mgd.msft.net>
 <201305311732.24103.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f181.google.com (mail-ve0-f181.google.com
 [209.85.128.181])
 by alsa0.perex.cz (Postfix) with ESMTP id B8B7E261281
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 17:36:44 +0200 (CEST)
Received: by mail-ve0-f181.google.com with SMTP id db10so1256148veb.12
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 08:36:43 -0700 (PDT)
In-Reply-To: <201305311732.24103.marex@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: Estevam Fabio-R49496 <r49496@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 31, 2013 at 12:32 PM, Marek Vasut <marex@denx.de> wrote:

> There was no problem without these patches though. With your patches, I see NAK
> happening on the I2C lines upon first 2-byte write.

Yes, but prior to these patches there were no register writes in sgtl5000.

These addditional writes does work and solve the reset issues on
mx6qsabrelite/mx51evk.

It is only on mx28evk that we have this timeout issue.

I think we need to turn on the SAIF clock (that connects to the
sgtl5000 MCLK) prior to doing the I2C writes.

Regards,

Fabio Estevam
