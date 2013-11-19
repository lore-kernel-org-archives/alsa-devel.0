From: Simone Camporeale <simone.camporeale@gmail.com>
Subject: Re: [PATCH] Maya44+ Support in ALSA
Date: Tue, 19 Nov 2013 12:42:16 +0100
Message-ID: <CAK+n=GVA7YqYiECvDo6E4Ls6K6hQv=w78XQA9gsoo75iSFDQsA@mail.gmail.com>
References: <CAK+n=GUBR=bt_YLg0Gzg9xax93H0cgvO12Nwz7r=YmULnfqpSQ@mail.gmail.com>
 <5287B3A9.2050008@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f47.google.com (mail-pb0-f47.google.com
 [209.85.160.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 058B7261700
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 12:42:17 +0100 (CET)
Received: by mail-pb0-f47.google.com with SMTP id um1so1763901pbc.20
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 03:42:17 -0800 (PST)
In-Reply-To: <5287B3A9.2050008@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clements,
this is lsub output

[simone@ubuntu: ~]$ lsusb
Bus 007 Device 002: ID 046d:c03e Logitech, Inc. Premium Optical Wheel Mouse
Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 008 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 006 Device 002: ID 2573:0008
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 005 Device 002: ID 0a5c:5800 Broadcom Corp.
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

Best Regards,
Simone


On Sat, Nov 16, 2013 at 7:04 PM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Simone Camporeale wrote:
> > I found some problems on Maya44+ USB support in linux.
> > Only 2 of 4 channels work and they are mixed .
> > To fix this problem i found on google a patch for Reloop device. I
> chanaged
> > VID and PID for MAYA44+ and now it works .
>
> What is the output of "lsusb -v" for this device?
>
>
> Regards,
> Clemens
>



-- 
Dott. Simone Camporeale
