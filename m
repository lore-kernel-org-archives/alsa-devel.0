From: "Nicolas Kalkhof" <nkalkhof@web.de>
Subject: No sound from Headphone Jack over Lenovo Docking
 Station with T440p Laptop
Date: Thu, 19 Dec 2013 11:05:30 +0100 (CET)
Message-ID: <trinity-ed805987-a2af-445d-8c84-171681bd6482-1387447530146@3capp-webde-bs34>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 87C88261AA5
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 11:05:30 +0100 (CET)
Received: from 3capp-webde-bs34.server.lan ([172.19.170.34]) by
 mriweb.server.lan (mriweb003) with ESMTP (Nemesis) id
 0MKHlJ-1Vu8Ro1HS2-001mck for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013
 11:05:30 +0100
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

   Hello, I have a Lenovo ThinkPad T440p laptop connected to an Ultra
   Docking Station. Sound works fine over Laptop Speakers and the 3,5mm
   Headphone Jack. However that is not the case when I connect the T440p
   to the Docking station Type 40A10065EU and use the Headphone Jack at
   the Dock. I've tried loading the alsa module with the "model=thinkpad"
   or "model=lenovo-dock"  without success. My Distro is Gentoo and the
   Kernel is 3.13-rc4.

   alsa.conf:
   # ALSA portion
   alias char-major-116 snd
   # OSS/Free portion
   alias char-major-14 soundcore
   ##
   ## IMPORTANT:
   ## You need to customise this section for your specific sound card(s)
   ## and then run `update-modules' command.
   ## Read alsa-driver's INSTALL file in /usr/share/doc for more info.
   ##
   ##  ALSA portion
   ## alias snd-card-0 snd-interwave
   ## alias snd-card-1 snd-ens1371
   ##  OSS/Free portion
   ## alias sound-slot-0 snd-card-0
   ## alias sound-slot-1 snd-card-1
   ##
   # OSS/Free portion - card #1
   alias sound-service-0-0 snd-mixer-oss
   alias sound-service-0-1 snd-seq-oss
   alias sound-service-0-3 snd-pcm-oss
   alias sound-service-0-8 snd-seq-oss
   alias sound-service-0-12 snd-pcm-oss
   ##  OSS/Free portion - card #2
   ## alias sound-service-1-0 snd-mixer-oss
   ## alias sound-service-1-3 snd-pcm-oss
   ## alias sound-service-1-12 snd-pcm-oss
   alias /dev/mixer snd-mixer-oss
   alias /dev/dsp snd-pcm-oss
   alias /dev/midi snd-seq-oss
   # Set this to the correct number of cards.
   options snd cards_limit=1
   #options snd-hda-intel model=thinkpad
   options snd-hda-intel model=thinkpad enable=1 index=0
   options snd-hda-intel model=hdmi enable=1 index=-2

   lspci -vv and dmesg goes here: [1]http://pastebin.ca/2510939

   Any Help?

References

   1. http://pastebin.ca/2510939
