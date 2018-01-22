From: Happy <happy.musicmaker@gmail.com>
Subject: Where do amidi MIDI port names come from ?
Date: Mon, 22 Jan 2018 22:48:52 +0800
Message-ID: <1516632532.3556.14.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f43.google.com (mail-pg0-f43.google.com [74.125.83.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A22426738D
 for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2018 15:48:57 +0100 (CET)
Received: by mail-pg0-f43.google.com with SMTP id z17so7255465pgc.4
 for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2018 06:48:57 -0800 (PST)
Received: from H3U1 ([175.182.114.92])
 by smtp.googlemail.com with ESMTPSA id k10sm25474077pgq.89.2018.01.22.06.48.54
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 Jan 2018 06:48:55 -0800 (PST)
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


Does someone know where (USB) MIDI port names in Linux come from ? 

For example a MIDISport 4x4 shows "Midiman" at lsusb (the same for each
one if there is more than one device. This comes from the idVendor,
idProduct in the device descriptor)

But "MIDISPORT 4x4 Anniv MIDI 1 to 4" by amidi -l for the device.
Thus wonder where amidi (ALSA) gets the product/portname from.

There are other examples where the SUB device ID is not known by
Linux but the port name does have the vendor/product name

Microsoft argues that some MIDI devices do not report a name
But since Linux does not have a driver for each device
I highly doubt so.  (have not come across one)

Microsoft chose to use the name from the device driver in their
UWP MIDI implementation which has apparantly been not a good idea
It has resulted in multiple duplicate device/port names for
different devices.
