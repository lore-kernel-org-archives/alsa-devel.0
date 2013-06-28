From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: C-Media 6632A unsupported (asus xonar u7)
Date: Fri, 28 Jun 2013 09:25:51 +0200
Message-ID: <51CD3A7F.4040906@ladisch.de>
References: <CANOmF+myQN0dyJoogCju4w+ScvrcXBNq1EGk99keM048SE0HoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 89E2B265665
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2013 09:25:54 +0200 (CEST)
In-Reply-To: <CANOmF+myQN0dyJoogCju4w+ScvrcXBNq1EGk99keM048SE0HoQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julius von kohout <juliusvonkohout@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Julius von kohout wrote:
> Hi ive got a new usb soundcard with the brand new C-Media 6632A chip and
> want to help with debugging.

Please show the output of "lsusb -v" for this device.

> cannot get ctl value: req = 0x81, wValue = 0x0, wIndex = 0x1400, type = 3

This sounds like a bug in the device's firmware.


Regards,
Clemens
