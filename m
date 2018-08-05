From: Chakravarthi Pradeep <doubleq7@gmail.com>
Subject: ALSA driver rmmod
Date: Sun, 5 Aug 2018 14:24:19 +0530
Message-ID: <CALW20Z3skyhz1U9BWcHH5F5OStBXGagVtTrzpLABhdc9vUshzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com
 [209.85.220.182])
 by alsa0.perex.cz (Postfix) with ESMTP id C09832676A2
 for <alsa-devel@alsa-project.org>; Sun,  5 Aug 2018 10:54:35 +0200 (CEST)
Received: by mail-qk0-f182.google.com with SMTP id x192-v6so6927490qkb.3
 for <alsa-devel@alsa-project.org>; Sun, 05 Aug 2018 01:54:35 -0700 (PDT)
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

Dear ALSA Team,

I have taken reference alsa driver from
https://alsa-project.org/main/index.php/Minivosc and driver code path
from https://github.com/stadaki/alsa-minivosc-src .

If I, do a rmmod of aforesaid driver using below command

"rmmod snd-minivosc"

Output of the above command is

"rmmod: ERROR: Module snd_minivosc is in use"

Below is output from lsmod | grep snd-minivosc

"snd_minivosc 16384 1

snd_pcm 98304 6
snd_hda_intel,snd_hda_codec,snd_usb_audio,snd_minivosc,snd_hda_core,snd_hda_codec_hdmi

snd 81920 26 snd_hda_intel,snd_hwdep,snd_seq,snd_hda_codec,snd_usb_audio,snd_minivosc,snd_timer,snd_rawmidi,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_usbmidi_lib,snd_seq_device,snd_hda_codec_realtek,snd_pcm"

Is there is any way to remove alsa driver from kernel without restarting PC?
Kindly let me know how to remove alsa driver safely from linux kernel
and then reinsert it.


Thanks and Regards
Chakravarthi Pradeep.K
Ph: 91 9980434900
