From: Harman Kalra <harman4linux@gmail.com>
Subject: Selecting Audio formats
Date: Thu, 19 Jul 2012 19:51:19 +0530
Message-ID: <CAA4JwzUwL=nkwcpJa62i9nLW8MOZ3mcj696-53V3R-wbdkbnnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 by alsa0.perex.cz (Postfix) with ESMTP id B212B2652CD
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2012 16:21:17 +0200 (CEST)
Received: by lban1 with SMTP id n1so3365067lba.38
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2012 07:21:19 -0700 (PDT)
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

Hello Everybody

I am a newbie to Linux Sound Programming, so few of my queries may sound
foolish, but kindly address them.

*I want to capture a video on my beagle board Xm rev C (TI DM3730). *So as
per as the audio capturing is concerned, I am very much confused about the
audio formats, like which format should I choose to get a better sound
quality in the least possible memory requirement.

Since so many PCM formats such as S8, U8, S16_LE, U16_LE, A-law, u-law-,
IMA_ADPCM, MPEG, GSM, etc are there so which format should I opt for.

Also

   1.  What is difference between signed and unsigned PCM format, how does
   it can affect the sound quality.
   2. If I go for MPEG format, does it mean that audio compression would
   handled at my audio port level and my DSP processor would not come into
   picture.
   3. In reference to my above query i.e. 2, if audio compression is
   handled at audio port level, so at the time of audio/video sync up, how
   would be my processor be able to time sync both audio and video, since
   audio is not being compressed by the DSP.
   4. If I opt for A-law or u-law, what could be benefits/disadvantages of
   using these formats. Would the audio sample be in compressed form in this
   case, if yes, how would audio/video sync up will happen in this case.


If possible kindly provide me a link where I can find differences between
these various formats, pros and cons of each of them.

Thanks & Regards
Harman
