From: Jeff Horn <outforaride@gmail.com>
Subject: Playing a wav file for a tone in an embedded project
Date: Fri, 15 Mar 2019 09:07:33 -0700
Message-ID: <CAM7q1L=T3ivGo1R5VaTgNDSvsVx7GZrXvNLrVU43BBVnX_QcrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84B6BF89673
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2019 17:07:46 +0100 (CET)
Received: by mail-io1-xd43.google.com with SMTP id b9so2014740iot.13
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2019 09:07:45 -0700 (PDT)
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

I am working on an embedded project ( i.MX6 ) and having an issue using a
wav file for a tone in a Qt application. I am upgrading an existing project
from Qt 5.3 with alsa-lib 1.0.8 and a 3.10.17 kernel to Qt 5.11 with
alsa-lib 1.1.6 and a 4.9.123 kernel.

The beep code is pretty simple, it loads a wav file and saves the wav data
in a buffer. Then on each click event in Qt a beep() function is called.
The beep() function calls snd_pcm_prepare() -> snd_pcm_writei() ->
snd_pcm_drain().

With the previous release the entire beep() function takes ~160ms with the
snd_pcm_prepare() close to 0ms. However, with the latest release the beep()
function takes 550ms with 400ms in snd_pcm_prepare().

I tried to trace snd_pcm_prepare() in the kernel and found that the code
path lands in dapm_power_widgets() and this is where a majority of the
prepare call path time is spent.

I don't know why the previous release seems to almost bypass
snd_pcm_prepare() and the newer code base does not.

So, is there a way to load a wav file on startup, save the wav data and
then on each invocation of a beep() function play the data without having
to call prepare each time?

Thanks in advance for any suggestions/help

Cheers,
Jeff
