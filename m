From: Lars Peterson <peterson@cs.uwp.edu>
Subject: ALSA (snd-via82xx) + 2.4 kernel + VAIO laptops w/VIA VT82C686
Date: 02 Nov 2003 17:56:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1067817384.31747.223.camel@mango.larspeterson.homeip.net>
Reply-To: peterson@cs.uwp.edu
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
To: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Warren Togami <warren@togami.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I struggled with getting ALSA sound to work on my Sony VAIO PCG-FXA49
until I googled this workaround:
http://lists.freshrpms.net/pipermail/rpm-list/2002-November/002250.html

My laptop hard locks upon trying to load the snd-via82xx module UNLESS
the OSS via82cxx_audio module has already been loaded & unloaded.

Warren suggested that I report this to those responsible for maintaining
the 2.4 and ALSA, since he claims the problem appears to have gone away
in post 2.5.47-ac4 kernels.

Environment:
Gentoo Linux 1.4
Kernel 2.4.22-ck2
Alsa-{drivers,utils,lib,tools}-0.9.8

Hardware:
1.2 GHz AMD Athlon 4
512MB SDRAM
VIA KT133/KM133 Chipset

Please cc responses to me as I'm not subscribed to either list.

Lars Peterson
