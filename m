From: Tom Rinehart <tom.rinehart@gmail.com>
Subject: Driver for Maxim MAX9744 Stereo Amplifier
Date: Thu, 28 Jun 2018 23:46:19 -0600
Message-ID: <2CA9F072-2E9F-483F-8E3A-4C08B1BA0C24@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
 [209.85.223.172])
 by alsa0.perex.cz (Postfix) with ESMTP id CA302266E76
 for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2018 07:46:22 +0200 (CEST)
Received: by mail-io0-f172.google.com with SMTP id l19-v6so7416062ioj.5
 for <alsa-devel@alsa-project.org>; Thu, 28 Jun 2018 22:46:22 -0700 (PDT)
Received: from ?IPv6:2601:681:4701:d390:1cbf:c566:76e2:29a?
 ([2601:681:4701:d390:1cbf:c566:76e2:29a])
 by smtp.gmail.com with ESMTPSA id d136-v6sm313970itd.22.2018.06.28.22.46.20
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 Jun 2018 22:46:20 -0700 (PDT)
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

I am trying to develop a driver the the Maxim MAX9744 20W Class D Stereo Amplifier.  (see https://www.maximintegrated.com/en/products/analog/audio/MAX9744.html <https://www.maximintegrated.com/en/products/analog/audio/MAX9744.html>).  It is very similar to the MAX9768 10W Class D Mono amplifier which has a linux driver. (see https://www.maximintegrated.com/en/products/analog/audio/MAX9768.html <https://www.maximintegrated.com/en/products/analog/audio/MAX9768.html>)  From a control perspective, both look to be the same from their data sheets.  Volume is controlled through i2c, and it has mute and shutdown controlled through gpio.  The MAX9744 has a volume control that changes both channels together.  When I try to use the MAX9768 driver it shows up as a mono amplifier in alsamixer.  What do
  I need to change in the driver to have it recognize stereo input and output but with the volume control tied together (not independent for each channel)?  It seems like I should be able to modify t
 he MAX9768 driver to work with the MAX9744.

I have an Adafruit board with the MAX9744 amplifier on it so it is easy to test: https://www.adafruit.com/product/1752 <https://www.adafruit.com/product/1752>.  
