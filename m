From: Chakravarthi Pradeep <doubleq7@gmail.com>
Subject: Noise in begnning of alsa application
Date: Wed, 16 Jan 2019 17:07:43 +0530
Message-ID: <CALW20Z3_KeN7c7k-zL5T0YbW6Zd2t_OUCUbfa1+8_nY6PTEAYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 11308266A7C
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2019 12:36:43 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id z23so2919150plo.0
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2019 03:36:43 -0800 (PST)
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

I have ALSA driver for capture device which works fine with VLC. when
I try to capture and render using own application having some issues.
When I start play, it has some noise in beginning and audio is
discontinuous in between. Discontinuous means, some audio frame are
getting dropped in between. cut cut sound for sine wave. I have tried
snd_pcm_drop and snd_pcm_drain but no use. Kindly suggest how to
remove the starting noise in ALSA.

-- 
Thanks and Regards
Chakravarthi Pradeep.K
