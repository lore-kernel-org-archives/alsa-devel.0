From: Fabio Estevam <festevam@gmail.com>
Subject: Re: iMX6UL EVK with kernel 4.6
Date: Sun, 1 May 2016 15:47:19 -0300
Message-ID: <CAOMZO5BM-EM0s5zWUmbRMkzV11Az9D+KLmQJ7dgv_RvKX9mihg@mail.gmail.com>
References: <50f27095-3304-03fa-7209-3f05baccb346@jikos.cz>
 <CAOMZO5BU2--_CV8FUsvkkesKGLW9NcnDPNvxC7UnK5vWwgDqVQ@mail.gmail.com>
 <CAOMZO5BGDnECdRFU6XFws9poNyF-yGJbv=io43mQgcqO4L-fbw@mail.gmail.com>
 <0721dbbe-a122-6be3-743f-669672b2c83f@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
 [209.85.223.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B0D12604DF
 for <alsa-devel@alsa-project.org>; Sun,  1 May 2016 20:47:20 +0200 (CEST)
Received: by mail-io0-f181.google.com with SMTP id f89so151068866ioi.0
 for <alsa-devel@alsa-project.org>; Sun, 01 May 2016 11:47:20 -0700 (PDT)
In-Reply-To: <0721dbbe-a122-6be3-743f-669672b2c83f@jikos.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <brain@jikos.cz>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org

On Sun, May 1, 2016 at 3:43 PM, Petr Kulhavy <brain@jikos.cz> wrote:

> Hi Fabio,
>
> and did that work for you?
> In my DTS file I made a few more changes, see below.

No, as explained in my earlier e-mail the system hangs after running aplay.

However, the same hang happens with NXP kernel.

Have you tried setting bit20 of GPR1 register?

Which NXP kernel did you use that provides audio functionality on mx6ul-evk?
