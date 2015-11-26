From: Fabio Estevam <festevam@gmail.com>
Subject: Re: mx28: bad unlock balance detected
Date: Thu, 26 Nov 2015 18:45:10 -0200
Message-ID: <CAOMZO5D_ZANC30EJYpmpSenZwyx7-M=HC2nFoya_YBD1CS84+Q@mail.gmail.com>
References: <CAOMZO5B+j5s69JeeYPnpwn2e_doCA+ARzBSGAcGoJGEJ3=u3BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com
 [209.85.223.182])
 by alsa0.perex.cz (Postfix) with ESMTP id EA82C26058A
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 21:45:11 +0100 (CET)
Received: by ioir85 with SMTP id r85so96974918ioi.1
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 12:45:10 -0800 (PST)
In-Reply-To: <CAOMZO5B+j5s69JeeYPnpwn2e_doCA+ARzBSGAcGoJGEJ3=u3BA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, Olof Johansson <olof@lixom.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 26, 2015 at 2:18 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi,
>
> Running linux-next 20151126 on a mx28evk leads to the following bug:
>
> sgtl5000 0-000a: sgtl5000 revision 0x11
> sgtl5000 0-000a: Using internal LDO instead of VDDD
>
> =====================================
> [ BUG: bad unlock balance detected! ]
> 4.4.0-rc2-next-20151126-00001-g44eb6b2 #156 Not tainted
> -------------------------------------
> kworker/u2:0/6 is trying to release lock (&rdev->mutex) at:
> [<c02e7858>] regulator_get_voltage+0x30/0x44
> but there are no more locks to release!

This warning started appearing in linux-next 20151123 according to these logs:
http://arm-soc.lixom.net/bootlogs/next/next-20151123/wandboard-arm-imx_v6_v7_defconfig.html

Haven't run git bisect yet.
