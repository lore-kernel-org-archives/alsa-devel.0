From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Audio USB disappears suddenly
Date: Wed, 10 Dec 2014 21:03:10 +0100
Message-ID: <5488A6FE.5080308@ladisch.de>
References: <CAM4quvZC3L_mcQtt3giUjUqVnN1N1A05m=fP379xh61TDi_-mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 319262605E7
 for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2014 21:03:40 +0100 (CET)
In-Reply-To: <CAM4quvZC3L_mcQtt3giUjUqVnN1N1A05m=fP379xh61TDi_-mg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mobidyc <mobidyc@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

mobidyc wrote:
> USB DAC suddenly disappears, from dmesg I can see:
>
> [13083.161157] usb 1-1.3: 1:2: usb_set_interface failed (-110)
> [13083.316344] usb 1-1.3: 1:2: usb_set_interface failed (-71)
> [13083.471927] usb 1-1.3: 1:2: usb_set_interface failed (-71)
> [13083.789810] usb 1-1.3: 1:2: usb_set_interface failed (-71)

These error codes indicate that the device's firmware does not react at
all.  Either the firmware has locked up due to a bug, or the hardware
has shut down for some reason.


Regards,
Clemens
