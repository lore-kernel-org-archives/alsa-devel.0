From: Benjamin Valentin <benpicco@googlemail.com>
Subject: No surround sound with ALC892 on B150M Pro4/D3 - fixed
 with hdajackretask
Date: Tue, 18 Oct 2016 00:50:49 +0200
Message-ID: <20161018005049.79d55d0b@nashorn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f67.google.com (mail-lf0-f67.google.com
 [209.85.215.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E0D9266B09
 for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2016 00:50:55 +0200 (CEST)
Received: by mail-lf0-f67.google.com with SMTP id b75so28957399lfg.3
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2016 15:50:55 -0700 (PDT)
Received: from nashorn (p548434E2.dip0.t-ipconnect.de. [84.132.52.226])
 by smtp.googlemail.com with ESMTPSA id uq6sm56849777wjc.37.2016.10.17.15.50.53
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Oct 2016 15:50:53 -0700 (PDT)
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

Hi,

I had a problem with mainboard insofar that it would let me select 5.1
surround output in my sound settings, but sound would only play from
the two front speakers, all other channels remained silent.

Some fiddeling with hdajackretask would generate a firmware where two
pins that were previously used for rear and LFE are now disabled and
two previously disabled pins are now configured as rear and LFE - I
left the other pins to their default setting as much as I could.
The generated firmware is attached below.

I'd like to help that this will work out of the box in the future, is
there any further information I can provide you with?

The board is an Asrock B150M Pro4/D3 [1] with the ALC892 HDA Codec.
alsa-info from before the procedure can be found at [2].

I'm running Linux 4.8/alsa 1.1.2 on Ubuntu 16.10

The generated /lib/firmware/hda-jack-retask.fw is

[codec]
0x10ec0892 0x18498892 0

[pincfg]
0x11 0x411111f0
0x12 0x411111f0
0x14 0x01014010
0x15 0x40f000f0
0x16 0x40f000f0
0x17 0x411111f0
0x18 0x01014011
0x19 0x02a19950
0x1a 0x01014012
0x1b 0x02214120
0x1c 0x411111f0
0x1d 0x4005e601
0x1e 0x01452130
0x1f 0x411111f0

[model]
auto

regards,
Benjamin 

[1] http://www.asrock.com/mb/Intel/B150M%20Pro4D3/?cat=Specifications
[2] http://www.alsa-project.org/db/?f=8e7b0788cde8967048959d50a57b0bb214ddc7fb
