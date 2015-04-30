From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Simple Mixer help
Date: Thu, 30 Apr 2015 16:39:01 +0200
Message-ID: <55423E85.3000406@ladisch.de>
References: <CAPaK8bb7mvNjf-EwEciBQth68hRWvXEE5cwAqUdRBk5QcXRqYw@mail.gmail.com>
 <CAPaK8baiMvLVkn5=Q8RkR-v0TjAugaYBZR9+=tnbtCv2xa84KA@mail.gmail.com>
 <s5hvbgedjs0.wl-tiwai@suse.de>
 <CAPaK8baHETB0trSEug0Qv7ZiA7M7tUcCrK6YiDiDdQC-LeD8_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 91F61261B02
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 16:39:05 +0200 (CEST)
Received: from [10.1.2.65] (unknown [94.101.37.4])
 by dehamd003.servertools24.de (Postfix) with ESMTPSA id E8523F8074
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 16:39:03 +0200 (CEST)
In-Reply-To: <CAPaK8baHETB0trSEug0Qv7ZiA7M7tUcCrK6YiDiDdQC-LeD8_g@mail.gmail.com>
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

Bram Bos wrote:
>      const char *card = "hw2"; // just for this example, don't hard-code this!

"hw2" is not the same as "hw:2".

>      const char *selem_name = "PCM"; // for some reason Master didn't work, but PCM does...

This must be the name of a mixer element implemented by the card.
(Some USB devices don't have any.)


Regards,
Clemens
