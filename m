From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Testing/Debugging alc668 with ASUS N750JK
Date: Fri, 1 Aug 2014 18:04:00 +0800
Message-ID: <CAN8cciZfJftpbFmrREXgQ9F=tjV6MQ_72NLznjKv0g=L2vGeTQ@mail.gmail.com>
References: <cover.1406259578.git.nicoleotsuka@gmail.com>
 <f4ff79269a1680f9ce128e0e98fea926d3a41834.1406259578.git.nicoleotsuka@gmail.com>
 <53D1DC0B.1000905@gmail.com>
 <63638.86.107.254.57.1406266836.squirrel@boosthardware.com>
 <CAN8cciboNrRRFBQjX66qud7KoTCqsDHxvFAws9-ywasjemtYbQ@mail.gmail.com>
 <59187.86.107.254.57.1406362728.squirrel@boosthardware.com>
 <CAN8cciax7RreogV0otMdLt0y-dOTrZD3D_ih0doAC9F_XkJ1ew@mail.gmail.com>
 <57315.86.107.254.57.1406609183.squirrel@boosthardware.com>
 <CAN8ccia3mi9G2oyaYyvJx14xu6F8dLhNZ6r0dpraO1F8qeLjBg@mail.gmail.com>
 <55293.86.107.254.57.1406791952.squirrel@boosthardware.com>
 <CAN8cciZ_KT9HG3K3xW-X-PFvWya1zW46JXccq-jd5v6uaeTjOA@mail.gmail.com>
 <59490.86.107.254.57.1406831144.squirrel@boosthardware.com>
 <CAN8cciYrj25NfmjD86ndzJd5r=D0bMNHE55JuEKichznAkAUHA@mail.gmail.com>
 <61402.86.107.254.57.1406884028.squirrel@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f42.google.com (mail-qa0-f42.google.com
 [209.85.216.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 29AEB264F3D
 for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2014 12:04:02 +0200 (CEST)
Received: by mail-qa0-f42.google.com with SMTP id j15so3704375qaq.29
 for <alsa-devel@alsa-project.org>; Fri, 01 Aug 2014 03:04:01 -0700 (PDT)
In-Reply-To: <61402.86.107.254.57.1406884028.squirrel@boosthardware.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> alsa-info:
>
> retask and apply
> http://boosthardware.com/alsa-info1.txt
>
> store and reboot
> http://boosthardware.com/alsa-info2.txt
>
>

Any reason to use asus-mode4 and hda-jack-retask at the same time ?

Try model=auto when you use patch=,hda-jack-retask.fw

Your alsa-info missing many important info , need all info from alsactl,
amixer, sysfs about the driver init pins and user init pins, allay/arecord
-l

No information about which Jack have been retasked
