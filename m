From: Fabio Estevam <festevam@gmail.com>
Subject: Re: SAIF configuration on imx28
Date: Tue, 21 Aug 2012 08:56:05 -0300
Message-ID: <CAOMZO5C9ezzU7S0M-AN0f8gk7SBWs3WNbA6cG2S+7BF8j+dVxA@mail.gmail.com>
References: <CAACwSTK-fzSy+HG+u5H0aNU_wfSa7gvAsH2fVMdczssnYtpJXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 97005265B9C
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 13:56:05 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so10477585obb.38
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 04:56:06 -0700 (PDT)
In-Reply-To: <CAACwSTK-fzSy+HG+u5H0aNU_wfSa7gvAsH2fVMdczssnYtpJXw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: George Stefan <stefan.george87@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <b29396@freescale.com>, Lauri Hintsala <lauri.hintsala@bluegiga.com>
List-Id: alsa-devel@alsa-project.org

Hi George,

On Tue, Aug 21, 2012 at 8:24 AM, George Stefan
<stefan.george87@gmail.com> wrote:

> My problem is, although i am receiving dma irqs when i record ( arecord -f
> S16_LE -r 8000 -c 1 <file>.wav), when i play the resulting file its just
> silence.
>
> [ 5295.890000] dump @ mxs_saif_trigger
> [ 5295.890000] scr 101  , 107
> [ 5295.890000] stat 80010041    , 80010071
> [ 5295.890000] data 0   , ffffffff
> [ 5295.890000] version 1010000  , 1010000
> This  is a dump for arecord!
>
> Do you have any ideeas?

Can you please to record as:
arecord -D hw:0,1 -d 5 -f S16_LE -r 44100 -c 2 1.wav

,as suggested here: http://www.spinics.net/lists/arm-kernel/msg186015.html

Regards,

Fabio Estevam
