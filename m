From: Chakravarthi Pradeep <doubleq7@gmail.com>
Subject: Re: Noise in begnning of alsa application
Date: Wed, 16 Jan 2019 17:26:27 +0530
Message-ID: <CALW20Z3P_qT1ES_a7A9Mtnx_fPGhcqrfZkvZft3PdxdXuQ=trQ@mail.gmail.com>
References: <CALW20Z3_KeN7c7k-zL5T0YbW6Zd2t_OUCUbfa1+8_nY6PTEAYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 19A02266A7C
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2019 12:55:27 +0100 (CET)
Received: by mail-pf1-f180.google.com with SMTP id c123so2986310pfb.0
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2019 03:55:27 -0800 (PST)
In-Reply-To: <CALW20Z3_KeN7c7k-zL5T0YbW6Zd2t_OUCUbfa1+8_nY6PTEAYg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Update from my side, for audio rendering i'm using below application.
I'm sharing reference render application which my own application is
built.

https://github.com/bear24rw/alsa-utils/blob/master/aplay/aplay.c

regards,
Chakravarthi Pradeep K

On Wed, Jan 16, 2019 at 5:07 PM Chakravarthi Pradeep <doubleq7@gmail.com> wrote:
>
> I have ALSA driver for capture device which works fine with VLC. when
> I try to capture and render using own application having some issues.
> When I start play, it has some noise in beginning and audio is
> discontinuous in between. Discontinuous means, some audio frame are
> getting dropped in between. cut cut sound for sine wave. I have tried
> snd_pcm_drop and snd_pcm_drain but no use. Kindly suggest how to
> remove the starting noise in ALSA.
>
> --
> Thanks and Regards
> Chakravarthi Pradeep.K



-- 
Thanks and Regards
Chakravarthi Pradeep.K
Ph: 91 9980434900
