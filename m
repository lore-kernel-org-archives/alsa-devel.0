From: =?UTF-8?Q?jean=2Dno=C3=ABl_chardron?= <rondrach@gmail.com>
Subject: how to ask you to write a new ALSA driver
Date: Thu, 21 May 2015 12:28:00 +0200
Message-ID: <CABi1v2YRv3g1VU0OCJVZ3+zdKyAotyMn7dSmuQ-E+ug7uMboOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f171.google.com (mail-ob0-f171.google.com
 [209.85.214.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BF472606D1
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 12:28:02 +0200 (CEST)
Received: by obfe9 with SMTP id e9so57002694obf.1
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 03:28:01 -0700 (PDT)
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

hello,

Last week I got a Komplet Audio 6 from Native intruments.
The driver exist in ALSA driver for this king of interface audio
(snd-usb-audio) (thanks for the team who write this) but for the model
where Id Vendor is 0x17cc and Id product is 0x1000.

The KA6 that I got has not the same ID product (0x1001) therefore I don't
have any device capture even with the driver snd-usb-audio.

The challenge is to write the modification for this new model.
Who could do that ?
If necessary I could send log, compile kernel source and so on.
thanks,
Jean-noel
