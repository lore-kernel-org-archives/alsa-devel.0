From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Fwd: Issue on Linux 4.12-rc7 on iMX6 based board
Date: Thu, 29 Jun 2017 11:30:41 -0300
Message-ID: <CAOMZO5CnuSim+vXB7eTBDV_PFrNf9Hgpj6AJea9hnELjaVdsTg@mail.gmail.com>
References: <7ab79167-fa6c-4aea-0545-48d0522d5d77@eurekelettronica.it>
 <d7d15b1d-ac7f-4b45-b7e6-e4cdc0d5cc65@eurekelettronica.it>
 <CAOMZO5C1HSN2m4P34GQq2+SKB+kmm9WUjr37T_Q_W6LwCQQQFQ@mail.gmail.com>
 <2cb47b9c-d631-6fe0-8e5c-3f1d2604ab0d@eurekelettronica.it>
 <CAOMZO5CYw-eoOuaP6Tb3c51va9ua7gvg2mTz+kX7fYtQdhsK+w@mail.gmail.com>
 <c19fa7f1-17f3-1bd0-81a2-a916fac8c1ab@eurekelettronica.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CB68626739E
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 16:30:44 +0200 (CEST)
Received: by mail-qk0-f193.google.com with SMTP id p21so11834792qke.0
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 07:30:43 -0700 (PDT)
In-Reply-To: <c19fa7f1-17f3-1bd0-81a2-a916fac8c1ab@eurekelettronica.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gianluca <gianlucarenzi@eurekelettronica.it>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 29, 2017 at 11:24 AM, gianluca
<gianlucarenzi@eurekelettronica.it> wrote:

> So, are they good?

If your hardware really uses these pins, then yes :-)


> My only concern is the value after the MSYS_CLK (GPIO_0_CCM_CLK01). It is
> 0x030b0. Is this correct for output clock signal?

Most of the boards use 0x130b0. You should really check with a scope
and see if the MCLK is getting to the codec.
I suppose it is as the driver can read its ID register correctly.

> I am missing the regmap. Should I configure kernel with additional CONFIG_ ?

mount -t debugfs none /sys/kernel/debug

>
> I started from the imxv6_imxv7_defconfig, then modified to have the correct
> drivers module as built-in or dynamic.

imx_v6_v7_defconfig should give you working audio.

You should check in this scope if your getting SSI clock/data when
playing audio.
