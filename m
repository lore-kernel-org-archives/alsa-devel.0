From: Guido Aulisi <guido.aulisi@gmail.com>
Subject: Regression in kernel 3.19-rc5 for usb2 scarlett 18i20
Date: Sun, 25 Jan 2015 12:42:22 +0100
Message-ID: <1422186142.4719.8.camel@yoda.heavyware>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 by alsa0.perex.cz (Postfix) with ESMTP id A072426046F
 for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2015 12:42:26 +0100 (CET)
Received: by mail-wi0-f172.google.com with SMTP id h11so4963138wiw.5
 for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2015 03:42:26 -0800 (PST)
Received: from [192.168.0.2]
 (host47-199-dynamic.52-79-r.retail.telecomitalia.it. [79.52.199.47])
 by mx.google.com with ESMTPSA id gm10sm9433404wib.19.2015.01.25.03.42.24
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Jan 2015 03:42:25 -0800 (PST)
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

Hi,
I noticed a regression in 3.19-rc5 kernel (as shipped by fedora rawhide)
with usb2 focusrite scarlett 18i20.
I get a lot of xruns with jack, even at 1024 frame buffer and 2 periods.
In 3.17.8 it works quite well without xruns at the same settings.

I use a fedora 20 (64bit) laptop with 8GB ram,  I only installed the
rawhide kernel to try the new included scarlett mixer, no other software
components changed.

I can try to do some other test, but compiling the kernel on this laptop
is time consuming.

Thanks
Guido
