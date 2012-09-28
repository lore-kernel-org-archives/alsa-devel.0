From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: Delay calculations for USB audio?
Date: Fri, 28 Sep 2012 06:23:14 -0500
Message-ID: <506588A2.4070602@gmail.com>
References: <5065834E.4010707@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id EF8262616C4
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2012 13:23:29 +0200 (CEST)
Received: by obblz20 with SMTP id lz20so2767257obb.38
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2012 04:23:29 -0700 (PDT)
In-Reply-To: <5065834E.4010707@canonical.com>
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

On 09/28/2012 06:00 AM, David Henningsson wrote:
> (Oh, and btw, if you have an idea of the crackling/distorted USB audio,
> let me know. I'm using a standard Logitech USB Headset, using
> speaker-test -c 2 -D plughw:Headset -t sine -r 48000
> I can make the problem go away using any of these options:
>   * Booting a 3.2 kernel - I've tried 3.5, 3.6-rc7 and 3.2
>   * Choosing the 44100 sample rate instead of the default of 48000
>   * Selecting the outer USB port instead of the inner one. Yes, there
> are two USB ports next to each other, and this only happens on one of
> them. (!))

The last statement sounds like you're sharing a hub with another device 
that has reserved bandwidth.  For example, a USB webcam will often do 
this.  Audio will work for a while and then get pre-empted.

Use 'lsusb -t' to view your USB layout.

-gabriel
