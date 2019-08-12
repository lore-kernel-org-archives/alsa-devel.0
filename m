From: Eric Desjardins <desjare@gmail.com>
Subject: asound snd_pcm_start question
Date: Mon, 12 Aug 2019 12:22:30 -0400
Message-ID: <CADsNRHvYVykXZ7C+DF14NACxFWYukUAe=aPZ_uo+=_YgBiQYSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E80B8F800F6
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 18:23:41 +0200 (CEST)
Received: by mail-lj1-x231.google.com with SMTP id x18so2398507ljh.1
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 09:23:41 -0700 (PDT)
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

Hi,

This is a simple question. I call:
snd_pcm_prepare
snd_pcm_writei

and it works fine but I would like to delay playback start. There is
snd_pcm_start for that. There is a method that is deprecated to specify a
start mode but I was wondering what was the correct new way to do that?

Thanks,
Eric
