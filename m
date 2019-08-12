From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: asound snd_pcm_start question
Date: Mon, 12 Aug 2019 18:35:51 +0200
Message-ID: <ec17ee5b-e832-7abb-f151-eab3860f7156@ladisch.de>
References: <CADsNRHvYVykXZ7C+DF14NACxFWYukUAe=aPZ_uo+=_YgBiQYSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [IPv6:2a01:4f8:212:88::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 874DFF8015B
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 18:36:14 +0200 (CEST)
Received: from olorin.ladisch.de (x2f7f8ba.dyn.telefonica.de [2.247.248.186])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 06ACE5583C0D
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 18:36:13 +0200 (CEST)
In-Reply-To: <CADsNRHvYVykXZ7C+DF14NACxFWYukUAe=aPZ_uo+=_YgBiQYSg@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Eric Desjardins wrote:
> I call:
> snd_pcm_prepare
> snd_pcm_writei
>
> and it works fine but I would like to delay playback start.

The device starts automatically when start_threshold frames are
available.  To prevent automatic starting, set it to a value that
is larger than the buffer size, i.e., the boundary value.


Regards,
Clemens
