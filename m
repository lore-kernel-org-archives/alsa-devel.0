From: Greg <alsa-devel@sweet.com>
Subject: Tascam US-16x08 0644:8047
Date: Wed, 8 Jul 2015 22:22:44 -0700
Message-ID: <20150709052244.GZ2628@sweet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from do1.sweet.com (do1.sweet.com [107.170.237.248])
 by alsa0.perex.cz (Postfix) with ESMTP id 517E3265D21
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 07:22:45 +0200 (CEST)
Content-Disposition: inline
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

Greetings,

I am fairly new to USB dev (in linux in particular, but also in general), but I
would very much like to try to get support for the above device working in
snd-usb-audio.

- Is this an appropriate place to discuss snd-usb-audio?
- Are there any recommended reading pointers for the quirk table?
   - or any highly recommended USB reading material that I might not have found?

I patched parse_audio_format_rates_v2(), get_sample_rate_v2(), and
set_sample_rate_v2(), and through some sort of beginner luck was able to get
aplay audio out of the first two channels. That was incomplete hackery though
(eg fixed sample rate), and I would like to learn how to properly add quirk
support. There have been other reports that this device worked OOTB, but I
fail to see how!

I've also been examining the traffic to the device with wireshark and a
win7 vm, but the learning curve for USB is a bit steep, so I am digesting. (:

If anyone can provide suggestions on lsusb output alone, here's what I have:
http://pastebin.com/pA9MLQet

cheers,
Greg
