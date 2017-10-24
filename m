From: =?UTF-8?B?QWxiaW4gU3RpZ8O2?= <albin.stigo@gmail.com>
Subject: ASoC: writing basic custom codecs?
Date: Tue, 24 Oct 2017 12:55:51 +0200
Message-ID: <CAMc++1U5_dOs23h-dgtBHa==1b=AVUoh2DhXLtOFRN9GE-1fkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f177.google.com (mail-ua0-f177.google.com
 [209.85.217.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ED61266DD4
 for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2017 12:55:52 +0200 (CEST)
Received: by mail-ua0-f177.google.com with SMTP id s41so15095455uab.10
 for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2017 03:55:52 -0700 (PDT)
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

I have implemented a custom i2s codec on an FPGA. Because of how the
FPGA is clocked I'm getting samples at 39ksps, which to my surprise
worked great after some simple kernel patching (the codec is bit &
frame master).

For experimentation I used the snd-soc-dummy coded defined in
soc-utils.c. Now I'm trying to write a very simple codec to "lock" the
rate to 39000:

https://github.com/ast/vfzfpga-codec

The driver loads just fine but I just get "not registered" when I try
to use the codec. I feel I'm missing something very obvious here. I've
been through the documentation and tried to read the sources but I'm a
bit stuck.. What am I missing?


--Albin
