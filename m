From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 2/2] ASoC: mxs-saif: Remove platform data
Date: Tue, 13 Nov 2012 10:25:06 -0200
Message-ID: <CAOMZO5DCjg+SxDDxUD1cxbYyu5QdohmoXQs4XtfgbFfoW59ePQ@mail.gmail.com>
References: <1351792632-30649-1-git-send-email-fabio.estevam@freescale.com>
 <1351792632-30649-2-git-send-email-fabio.estevam@freescale.com>
 <20121102150312.GC4413@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CA49260309
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 13:25:07 +0100 (CET)
Received: by mail-ob0-f179.google.com with SMTP id eq6so3234054obc.38
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 04:25:06 -0800 (PST)
In-Reply-To: <20121102150312.GC4413@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, dong.aisheng@linaro.org, DWinner@tc-helicon.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Fri, Nov 2, 2012 at 1:03 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Nov 01, 2012 at 03:57:12PM -0200, Fabio Estevam wrote:
>> All MXS users have been converted to device tree and the board files have been
>> removed.
>>
>> No need to keep platform data in the driver.
>
> This doesn't apply against v3.7-rc3 (or against my fix/mxs branch) -
> please check what's going on.

fix/mxs branch misses commit 730963f81 (ASoC: mxs-saif: Use devm_clk_get()).

This patch applies cleanly against your for-next and also against linux-next.

Thanks,

Fabio Estevam
