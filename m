From: =?UTF-8?B?TWFydMOtbiBNYXJ0w61uZXogUml2ZXJh?= <mrtnz.rvr@gmail.com>
Subject: Master volume not controlling applications' volume.
Date: Tue, 20 Aug 2019 20:50:35 -0700
Message-ID: <CAJnWPcZ9C8WY4ihRSBBkOJD7fHLGhfEEmBRhMLimKG+R+h8O2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78F10F800BF
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2019 05:50:48 +0200 (CEST)
Received: by mail-oi1-x232.google.com with SMTP id k22so552886oiw.11
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2019 20:50:47 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Changing the master volume in pavucontrol (or alsamixer) does not have any
effect. The only way to change the volume is to go into the playback tab
and change it for each application. The volume only changes when I set the
master volume to 0 or when I increase it over 100%. In between there aren't
any changes.

Running arch on a Lenovo X1 Carbon if that's of any use. I am using the
arch default configuration files.

I posted somewhere else and was told to email this list as it could be a
kernel bug.

kernel: 5.2.9-arch1-1-ARCH
pactl info output:

Server String: /run/user/1000/pulse/native
Library Protocol Version: 32
Server Protocol Version: 32
Is Local: yes
Client Index: 13
Tile Size: 65472
User Name: martinmr
Host Name: martinmr-laptop
Server Name: pulseaudio
Server Version: 12.2
Default Sample Specification: s16le 2ch 44100Hz
Default Channel Map: front-left,front-right
Default Sink: alsa_output.pci-0000_00_1f.3.analog-stereo
Default Source: alsa_output.pci-0000_00_1f.3.analog-stereo.monitor
Cookie: 1afa:f937

Let me know if the output from some other command is needed.
Best,

Martin
