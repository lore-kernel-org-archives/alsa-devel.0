From: Ramon Marco Navarro <ramonmaruko@gmail.com>
Subject: Focusrite 6i6 invalid PCM device "front"
Date: Fri, 08 May 2015 06:32:50 +0000
Message-ID: <CAHeSwUnn4UZpNNko9ibPvr2Ci9rmHLOozUcKqmv_B=0QOpsVXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D46726048D
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 08:33:13 +0200 (CEST)
Received: by pdbqa5 with SMTP id qa5so66751185pdb.1
 for <alsa-devel@alsa-project.org>; Thu, 07 May 2015 23:33:11 -0700 (PDT)
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

# Background
I can't seem to use any of the PCM device list defined automatically for my
[Focusrite 6i6 device][1]. I tested this using `speaker-test`.

# Tests:

## `speaker-test` output comparing between using [`sysdefault`][2] and
[`front:USB`][3].

The `sysdefault` device emits sound for all of the formats, except for
FLOAT_LE 44100Hz and 48000Hz. While front:USB doesn't emit anything at all.

[1]:
http://www.alsa-project.org/db/?f=b1c10accc89cd34dfdeb0d61b087a3cf413ea1a0
[2]:
https://gist.githubusercontent.com/ramonmaruko/deb1918efa27eb860aa1/raw/f7af5e4fb73668e2067eb377a5422d81e576e5db/speaker-test-sysdefault.log
[3]:
https://gist.githubusercontent.com/ramonmaruko/1377846e39a7a6acd72f/raw/4d6e0260934d846a5bf7a62a617009bb233be87e/speaker-test-front-usb.log
