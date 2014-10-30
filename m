From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Selecting correct input device port.
Date: Thu, 30 Oct 2014 13:08:28 +0800
Message-ID: <CAN8ccib=GTO-=OdkDW2ObK6L5o1sdmrfKBk91F1vW2msz-L1ug@mail.gmail.com>
References: <544F1B26.2070502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f178.google.com (mail-qc0-f178.google.com
 [209.85.216.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 35670260575
 for <Alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 06:08:29 +0100 (CET)
Received: by mail-qc0-f178.google.com with SMTP id b13so3955915qcw.23
 for <Alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 22:08:28 -0700 (PDT)
In-Reply-To: <544F1B26.2070502@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: dE <de.techno@gmail.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> As I learn't in this mailng list, a device can typically handle only one
stream at a time unless it supports hardware mixing which's exposed via
subdevices in ALSA
>
> What does subdevice mean for input device? Do they mark physical ports
for input? If not how do I record from a specific input port? Is it
automatically selected by the card?
>
> And what's 'input source' in ALSA mixer?

'Input source' usually found in those desktop using hda codec with two or
more ADC since hda support multistreaming

Most sound card only support one analog capture device with 'Capture
Source' control

Most notebook with hda codec have auto mic enabled by default, the capture
source is determined by jack detection
