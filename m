From: Gabriel Beddingfield <gabrbedd@gmail.com>
Subject: Re: Delay calculations for USB audio?
Date: Fri, 28 Sep 2012 13:01:44 -0500
Message-ID: <CAPbw_hz3O2hWHn9EZArcmRYTidGxVTTnNaXGw4p0GGz1OgNebQ@mail.gmail.com>
References: <5065834E.4010707@canonical.com> <506588A2.4070602@gmail.com>
 <5065907C.8030904@canonical.com> <5065987A.1080703@ladisch.de>
 <5065DE65.5090004@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 53C30264FF0
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2012 20:01:45 +0200 (CEST)
Received: by obblz20 with SMTP id lz20so3160999obb.38
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2012 11:01:44 -0700 (PDT)
In-Reply-To: <5065DE65.5090004@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 28, 2012 at 12:29 PM, David Henningsson
<david.henningsson@canonical.com> wrote:
> Okay, so if I get some time to dig deeper into this, where should I start
> looking? Maybe in the bluetooth controller driver, if that's what's
> interfering?

My guess is that either the bluetooth driver is reserving bandwidth
(and didn't before), or the USB host controller is /enforcing/ the
bandwidth (and didn't before).

-gabriel
