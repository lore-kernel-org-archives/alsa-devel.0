From: Madura Anushanga <madura.x86@gmail.com>
Subject: ALC1150 can't playback SND_PCM_FORMAT_FLOAT without
	dmix
Date: Sun, 4 May 2014 12:57:10 +0530
Message-ID: <CAJ70YRB7F+9XemQFQo1J3MaM_b4GfexvdVE7VG2OYPiVXDXt7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f177.google.com (mail-vc0-f177.google.com
 [209.85.220.177])
 by alsa0.perex.cz (Postfix) with ESMTP id AD9422619FF
 for <alsa-devel@alsa-project.org>; Sun,  4 May 2014 09:27:31 +0200 (CEST)
Received: by mail-vc0-f177.google.com with SMTP id if11so7173841vcb.36
 for <alsa-devel@alsa-project.org>; Sun, 04 May 2014 00:27:30 -0700 (PDT)
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

MSI z87-GD65 GAMING motherboard's ALC1150 plays SND_PCM_FORMAT_FLOAT with
noise[1] other non float formats work well. As soon as I changed
/etc/asound.conf from

pcm.!default{
   type hw
   card 1
}

to

pcm.dmixed {
        type asym
        playback.pcm {
                type dmix
                ipc_key 5678293
                ipc_perm 0660
                ipc_gid audio

                slave {
                        channels 2 # make 6 or 5.1 channel
                        pcm {
                                format S16_LE # S32_LE
                                rate 48000 # can also be 44100
                                type hw
                                card 1 # your card
                                device 0 # your device
                                subdevice 0 #important?
                        }

                        period_size 1024
                        buffer_size 8192
                }

                bindings {
                        0 0
                        1 1
# Uncomment below if using 6 channel
#                       2 2
#                       3 3
#                       4 4
#                       5 5
                }
        }
        capture.pcm "hw:0"
}

pcm.!default {
        type plug
        slave.pcm "dmixed"
}

SND_PCM_FORMAT_FLOAT plays without a problem.

1. https://github.com/manushanga/vrok/blob/master/outs/alsa.cpp

            - Madura A.
