From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH - oss plugin update revised 1/2] oss: Add
 support of 32-bit and other formats
Date: Sun, 30 Jun 2013 09:13:17 +0800
Message-ID: <CAN8cciZ_FXDDJn-yLba0kDfKno-pZhhxhGVfjoXkHDEH7TxOTQ@mail.gmail.com>
References: <51cf8030.0867b40a.36ac.ffffad56@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f171.google.com (mail-ie0-f171.google.com
 [209.85.223.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 0730F261B14
 for <alsa-devel@alsa-project.org>; Sun, 30 Jun 2013 03:13:18 +0200 (CEST)
Received: by mail-ie0-f171.google.com with SMTP id qd12so6717951ieb.2
 for <alsa-devel@alsa-project.org>; Sat, 29 Jun 2013 18:13:18 -0700 (PDT)
In-Reply-To: <51cf8030.0867b40a.36ac.ffffad56@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alex.d.wiggins@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> Added support of 32-bit and other audio formats via 3 changes:
>
>  - Additional audio format definitions
>    at the top of the file (if required);
>
>  - Additional audio formats in oss_hw_params
>    (to allow as input to pass to OSS);
>
>  - Additional audio formats in oss_hw_constraint
>    (to allow to report to ALSA).
>
> Signed-off-by: Alex Wiggins <alex.d.wiggins@gmail.com>
>

Do you mean that this patch allow  OSS 4.0 enumlation if period size other
than power 2 is supported ?
