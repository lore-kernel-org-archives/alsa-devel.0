From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: No sound from Mac Pro headphone port
Date: Sat, 20 Jun 2015 07:07:26 +0800
Message-ID: <CAN8ccib=vJ4knVUtMQUahOEF8+u=f_14x7JV5mpxguy8O-eKtQ@mail.gmail.com>
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
 <CAN8ccia-MdiK0nGaiCgrJb9f+Ud2uuPUPx=+WBJ7AgLBOjhKMw@mail.gmail.com>
 <55844837.1080004@todddailey.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f181.google.com (mail-ob0-f181.google.com
 [209.85.214.181])
 by alsa0.perex.cz (Postfix) with ESMTP id E223C260647
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 01:07:26 +0200 (CEST)
Received: by obpn3 with SMTP id n3so507934obp.0
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 16:07:26 -0700 (PDT)
In-Reply-To: <55844837.1080004@todddailey.ca>
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
> I will need more instruction on how to accomplish step #3.
>
>
> "3) clear misc bit 8 of pin default of line out"
>
> Thus far, moving both HP and Mic to "Front" gives no improvement.
>
>

Many unconnected pin complex have been changed to line out jack

Seem bug of hdajackretask if it allow you to change pin comple which pincap
only support IN to line out jack

Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x00000100: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x0, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
