From: Chakravarthi Pradeep <doubleq7@gmail.com>
Subject: Re: Noise in begnning of alsa application
Date: Mon, 21 Jan 2019 23:16:44 +0530
Message-ID: <CALW20Z27AZcDWANkgvu5XQMtpWo6EJWOoMCAUV43QrV72qHSBg@mail.gmail.com>
References: <CALW20Z3_KeN7c7k-zL5T0YbW6Zd2t_OUCUbfa1+8_nY6PTEAYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FD572667E7
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 18:45:45 +0100 (CET)
Received: by mail-pf1-f173.google.com with SMTP id q1so10442067pfi.5
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 09:45:45 -0800 (PST)
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
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

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
> For audio rendering i'm using below application.
> I'm sharing reference render application which my own application is
> built.

> https://github.com/bear24rw/alsa-utils/blob/master/aplay/aplay.c

-- 
Thanks and Regards
Chakravarthi Pradeep.K
