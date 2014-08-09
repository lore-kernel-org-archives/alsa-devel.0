From: Orm Finnendahl <orm.finnendahl@selma.hfmdk-frankfurt.de>
Subject: Re: can't insmod patched snd-usb-audio
Date: Sat, 9 Aug 2014 14:46:30 +0200
Message-ID: <20140809124630.GB7938@x1-orm>
References: <20140809114001.GA7938@x1-orm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.selma.hfmdk-frankfurt.de (selma.hfmdk-frankfurt.de
 [178.63.26.132])
 by alsa0.perex.cz (Postfix) with ESMTP id E23FE2610C5
 for <alsa-devel@alsa-project.org>; Sat,  9 Aug 2014 14:46:31 +0200 (CEST)
Received: from X1-orm (dslb-088-074-106-134.088.074.pools.vodafone-ip.de
 [88.74.106.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by mail.selma.hfmdk-frankfurt.de (Postfix) with ESMTPSA id 9148C3380330
 for <alsa-devel@alsa-project.org>; Sat,  9 Aug 2014 14:46:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140809114001.GA7938@x1-orm>
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

Got it working. An additional "make modules_prepare" seemed to do the
trick. sorry for the noise...

--
Orm

Am Samstag, den 09. August 2014 um 13:40:01 Uhr (+0200) schrieb Orm Finnendahl:
> Hi,
> 
>  hope it's ok to post it here as it's not (yet) official alsa: After
> having no issues with Tobias Hoffmann's scarlett alsa mixer patch on
> my older kernels, trying to insmod the patched kernel modules on my
> most current kernel (the patch and documentation obtained with
> "git clone http://github.com/trrichard/alsa-driver_scarlett.git")
> fails with the following message:
> 
> root@x1-orm:/usr/src/linux-source-3.14# insmod sound/usb/snd-usbmidi-lib.ko 
> insmod: ERROR: could not insert module sound/usb/snd-usbmidi-lib.ko: Unknown symbol in module
> 
> root@x1-orm:/usr/src/linux-source-3.14# insmod sound/usb/snd-usb-audio.ko 
> insmod: ERROR: could not insert module sound/usb/snd-usb-audio.ko: Unknown symbol in module
> 
> I'm on debian testing with 3.14-2-amd64 kernel and followed all the
> instructions in the scarlett kernel patch README (I tried three times
> each with a fresh kernel source tree from scratch to be sure). The
> patch has worked for me on older kernels without any problems.
> 
> Does anybody know how to deal with this? Let me know if you need
> further information.
> 
> Yours,
> Orm
