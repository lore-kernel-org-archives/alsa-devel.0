From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] Maya44+ Support in ALSA
Date: Sat, 16 Nov 2013 19:04:25 +0100
Message-ID: <5287B3A9.2050008@ladisch.de>
References: <CAK+n=GUBR=bt_YLg0Gzg9xax93H0cgvO12Nwz7r=YmULnfqpSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B05AE2608EE
 for <alsa-devel@alsa-project.org>; Sat, 16 Nov 2013 19:05:06 +0100 (CET)
In-Reply-To: <CAK+n=GUBR=bt_YLg0Gzg9xax93H0cgvO12Nwz7r=YmULnfqpSQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Simone Camporeale <simone.camporeale@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Simone Camporeale wrote:
> I found some problems on Maya44+ USB support in linux.
> Only 2 of 4 channels work and they are mixed .
> To fix this problem i found on google a patch for Reloop device. I chanaged
> VID and PID for MAYA44+ and now it works .

What is the output of "lsusb -v" for this device?


Regards,
Clemens
