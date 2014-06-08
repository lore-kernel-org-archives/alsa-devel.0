From: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Subject: =?utf-8?q?=5BBug=3F=5D_alsa-lib=3A_Plug_fails_to_con?=
 =?utf-8?q?vert_float_mono_to_float_stereo?=
Date: Sun, 08 Jun 2014 23:02:23 +0400
Message-ID: <1402254143.119530615@f78.i.mail.ru>
Reply-To: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f78.i.mail.ru (f78.i.mail.ru [94.100.185.14])
 by alsa0.perex.cz (Postfix) with ESMTP id CDE1C261A0A
 for <alsa-devel@alsa-project.org>; Sun,  8 Jun 2014 21:02:24 +0200 (CEST)
Received: from mail by f78.i.mail.ru with local (envelope-from
 <sergemp@mail.ru>) id 1WtiMK-0006mg-07
 for alsa-devel@alsa-project.org; Sun, 08 Jun 2014 23:02:24 +0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?YWxzYS1kZXZlbA==?= <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Plug fails to convert float mono to float stereo,
which is required when plug is used for float-only slaves
like "jack" or "ladspa".

Steps to reproduce:
#~/.asoundrc
pcm.!default {
  type plug
  slave.pcm { type null }
  slave.channels 2
  slave.format FLOAT_LE
}
# aplay -f FLOAT_LE /dev/zero

A possible workaround is to use two plugs:
pcm.!default {
  type plug
  slave.pcm {
    type plug
    slave.pcm { type null }
    slave.channels 2
    slave.format FLOAT_LE
  }
  slave.format S32_LE
}

But shouldn't "plug" do that automatically?

PS: the workaround makes `aplay -fFLOAT_LE /dev/zero` freeze on Ctrl+C,
but that's a different alsa 1.0.27 regression that I have not tracked yet.

-- 
  Sergey
