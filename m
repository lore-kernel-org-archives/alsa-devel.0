From: Adam Goode <adam@spicenitz.org>
Subject: Scarlett 18i8 hardware out of sync with AlsaMixer
Date: Tue, 26 May 2015 21:39:22 -0400
Message-ID: <CADN=WdobTC9qdHjKD3PyPW99f2pX-j82vVzZ32zp4ed-C0Gbgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
 [209.85.218.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C40B265474
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 03:39:44 +0200 (CEST)
Received: by oiww2 with SMTP id w2so91906727oiw.0
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 18:39:43 -0700 (PDT)
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

Linux 4.0.2-300.fc22.x86_64

Hi,

I have the Scarlett 18i8 USB device that is supported by the new
scarlett_mixer.c code. I am happy to say that the mixer code works in
most cases. But under some conditions, I cannot get any sound out of
the device until I go and toggle the "Matrix 01 Input" and "Matrix 02
Input" enums up and then down (from PCM 1 and PCM 2). This appears to
me to be some kind of cache invalidation bug, where the device is out
of sync with kernel mixer state.

I will take a look at the code myself at some point, but not for a
while. But I am happy to try patches if anyone comes up with anything
in the mean time.



Thanks,

Adam
