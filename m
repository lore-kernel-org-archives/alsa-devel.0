From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: No sound from Mac Pro headphone port
Date: Fri, 19 Jun 2015 21:12:41 +0800
Message-ID: <CAN8ccia-MdiK0nGaiCgrJb9f+Ud2uuPUPx=+WBJ7AgLBOjhKMw@mail.gmail.com>
References: <554CC0EC.5000506@todddailey.ca>
 <CAN8cciYJdMeKyYL1mqUkN3bKmEhwqHN1-pZzCvBDazBPKdH7vw@mail.gmail.com>
 <554CCCAF.6000608@todddailey.ca>
 <CAN8cciaSiJBr4RKP6Rj3JurnrPEGufBsnLEACdvrhRLcRfPkcg@mail.gmail.com>
 <5555460D.3060907@todddailey.ca>
 <CAN8cciaEdt3zM_V7M4_8YVBHrs+GQsfs1jV32owfsR_2oO52AA@mail.gmail.com>
 <CAN8cciaepxbsuprm+EFr4jE24so1-WMnNDOfdQQPaM9AsK2hNQ@mail.gmail.com>
 <55819224.5090105@todddailey.ca>
 <CAN8cciZesh=oO765REcCo=ce8vO63ASthWGFROM5p06Ms+nx1g@mail.gmail.com>
 <55840D29.6010702@todddailey.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f47.google.com (mail-oi0-f47.google.com
 [209.85.218.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 94114260564
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 15:12:42 +0200 (CEST)
Received: by oiyy130 with SMTP id y130so62390590oiy.0
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 06:12:41 -0700 (PDT)
In-Reply-To: <55840D29.6010702@todddailey.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Todd Dailey <todd@todddailey.ca>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> As I have time to work on this ...
>
> ALSA info headphone unplugged:
>
> http://www.alsa-project.org/db/?f=df059dc59473b812033be118a26a553767879f41
>
> Headphone plugged:
>
> http://www.alsa-project.org/db/?f=b91b9b46a1abe043b9dfc3bc4802b203e6a6c2e5
>

You did not retask correctly

1) change hp from ext rear to ext front
2) change Mic from ext rear to ext front

The driver don't create channel mode when there is only two jacks at ext
rear

3) clear misc bit 8 of pin default of line out

You should use save as boot default instead of dynamic reconfig and reboot
