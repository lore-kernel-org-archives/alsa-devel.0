From: Daniel Viksporre <daniel.viksporre@gmail.com>
Subject: Rawmidi
Date: Sun, 27 Dec 2015 07:29:20 +0100
Message-ID: <CAL_NL1DGv74+62K9A_82osf6ywc9pPVPZhrZd+BsGs7tCnAxqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f53.google.com (mail-vk0-f53.google.com
 [209.85.213.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 53812260635
 for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2015 07:29:22 +0100 (CET)
Received: by mail-vk0-f53.google.com with SMTP id a123so9497518vkh.1
 for <alsa-devel@alsa-project.org>; Sat, 26 Dec 2015 22:29:22 -0800 (PST)
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

I cant compile example programs that use rawmidi.

When I look on my harddrive, I have many rawmidi.h files, but since
2015 they are all 0 bytes. Can that be the reason I cant compile. But
why is those files 0 bytes from the repository Im using?

I get the following error messages...


test.c:(.text+0x507): undefined reference to `snd_rawmidi_open'
test.c:(.text+0x5d8): undefined reference to `snd_rawmidi_open'
test.c:(.text+0x75e): undefined reference to `snd_rawmidi_read'
test.c:(.text+0x846): undefined reference to `snd_rawmidi_write'
test.c:(.text+0x867): undefined reference to `snd_rawmidi_write'
test.c:(.text+0x888): undefined reference to `snd_rawmidi_write'
test.c:(.text+0x894): undefined reference to `snd_rawmidi_drain'
test.c:(.text+0x8c1): undefined reference to `snd_rawmidi_write'
test.c:(.text+0x8e2): undefined reference to `snd_rawmidi_write'
test.c:(.text+0x903): undefined reference to `snd_rawmidi_write'
test.c:(.text+0x90f): undefined reference to `snd_rawmidi_drain'
test.c:(.text+0xa71): undefined reference to `snd_rawmidi_read'
test.c:(.text+0xae0): undefined reference to `snd_rawmidi_write'
test.c:(.text+0xaec): undefined reference to `snd_rawmidi_drain'
test.c:(.text+0xb8f): undefined reference to `snd_rawmidi_drain'
test.c:(.text+0xb9b): undefined reference to `snd_rawmidi_close'
test.c:(.text+0xbaf): undefined reference to `snd_rawmidi_drain'
test.c:(.text+0xbbb): undefined reference to `snd_rawmidi_close'
