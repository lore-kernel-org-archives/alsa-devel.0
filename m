From: Puneet Sharma <punitsharma1181@gmail.com>
Subject: USB audio2.0 status interrupt endpoint
Date: Tue, 1 Mar 2016 16:36:27 +0530
Message-ID: <CAJha+Ve6wYyYMxU5FTpjDpih41OLmTWHX2UfOZZRAksJN6u8TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 496FB2617E0
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 12:06:29 +0100 (CET)
Received: by mail-oi0-f46.google.com with SMTP id d205so43504905oia.0
 for <alsa-devel@alsa-project.org>; Tue, 01 Mar 2016 03:06:29 -0800 (PST)
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

Hello all,

I am using the uac2 kernel driver(drivers/usb/gadget/f_uac2.c) having
kernel version 3.10.31 for an embedded board.

The board is presented as a USB device to a Linux PC having USB host
controller in it.

I have added an interrupt endpoint in the uac2 kernel driver to support the
status interrupt endpoint request as per usb audio 2.0 specification.

For the interrupt transfer to happen, I prepared the interrupt packet
structure as per audio 2.0 specification and queued the endpoint to
transfer it to the host driver.
The interrupt structure is prepared as follows:
bInfo : 0 (Interface request)
bAttribute : 0x1 (CUR request)
wValue : 0x200 (VOLUME feature unit control selector)
wIndex : 0x700 (FEATURE UNIT ID)

As per my understanding, when the above interrupt endpoint is transferred
to host in response to Interrupt IN request, the host should send me a GET
CUR volume class-specific request to further qualify the cause of interrupt.

However, I am not getting any class-specific request from host in response
to the status interrupt transferred to host.

My query is do i need to implement a mixer interface in the uac2 kernel
driver to get the request or i am doing something wrong in the process.

I am stuck onto this and cannot proceed further.

Thanks
Puneet
