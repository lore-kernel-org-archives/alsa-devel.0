From: Alexey Eromenko <al4321@gmail.com>
Subject: Donation of ARM CubieTruck to anyone interested in
	developing
Date: Fri, 30 May 2014 20:17:26 +0200
Message-ID: <CAOJ6w=FZUePRjOoT=avoUa5jCmrcC20Ki38Z5eFjOYAEmYEqww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f174.google.com (mail-vc0-f174.google.com
 [209.85.220.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 67B7A26109F
 for <alsa-devel@alsa-project.org>; Fri, 30 May 2014 20:17:50 +0200 (CEST)
Received: by mail-vc0-f174.google.com with SMTP id ik5so2322755vcb.19
 for <alsa-devel@alsa-project.org>; Fri, 30 May 2014 11:17:48 -0700 (PDT)
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

Hello,

My name is Alexey, and I'm interested in having ARM CubieTruck
hardware well supported by desktop (KDE) use.

CubieTruck is an ARM mini-PC aka "Liliputer", based on AllWinner A20
SoC + 2 GB RAM + 8 GB flash + VGA (!) port + SATA + Ethernet + WiFi,
making it good enough for a real Debian desktop.

CubieTruck
http://cubietruck.com/collections/frontpage/products/cubietruck-cubieboard3-cortex-a7-dual-core-2gb-ram-8gb-flash-with-wifi-bt

My goal: It should have a working 2D, HD Video and 3D graphics as well
as audio and networking.

Some open-source drivers exist:
*2D - xf86-video-fbturbo - link: https://github.com/ssvb/xf86-video-fbturbo
*Hardware Video Decoder - "CedarX" link:
http://linux-sunxi.org/Reverse_Engineering/Cedar_Status (should play
H.264 and WebM/VP8 Full HD 1080p video)
*3D - open-source Lima or closed-source Mali drivers.

WiFi + Bluetooth - status unknown. (WiFi firmware is probably closed source)

If you can - please help stabilize those experimental drivers,
especially sound driver is semi-broken.

I can donate one ARM CubieTruck sample to interested people. You'll
need a proof of past patches to any open-source project or community
involvement.

--
-Alexey Eromenko "Technologov". Open-source community member. Israel.
