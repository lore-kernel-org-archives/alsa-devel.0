From: antony k <adkalkan@gmail.com>
Subject: plughw vs default / per-application volume changer
Date: Mon, 6 Aug 2012 14:41:43 +0300
Message-ID: <CAC2-5LccH=QCQ8UKF-o+JtZUFdxRyU_NaEsq7kGW8ekoLXkGOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C059264F9B
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 13:11:58 +0200 (CEST)
Received: by yhnn12 with SMTP id n12so681605yhn.38
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2012 04:41:44 -0700 (PDT)
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

Hello,
I am new to ALSA and I cant figure out 2 things.

a) if and why should I prefer the "plughw:0,0" over the "default" device
name.
I am developing a simple audio player which is based on the latter.
I made this choice because when I was using plughw:0,0 with other audio
programs(flash player,vlc) open in the background I would get the "Device
is busy" error code.
With default, it's fine.

b) can I have an application specific volume changer? So far I have managed
to tweak the master volume of the "default" device which has a global
effect. Im guessing a) and b) are connected.

Thanks for your time
