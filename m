From: anish singh <anish198519851985@gmail.com>
Subject: Re: compressed audio support (maruthi srinivas)
Date: Mon, 2 Dec 2013 15:24:51 -0800
Message-ID: <CAK7N6vrkSZALp2z5wpve1Cw6GWzWX=u060yEq8iukK1Oeqe1-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f180.google.com (mail-we0-f180.google.com
 [74.125.82.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FA3A265074
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 00:24:52 +0100 (CET)
Received: by mail-we0-f180.google.com with SMTP id t61so7009188wes.39
 for <alsa-devel@alsa-project.org>; Mon, 02 Dec 2013 15:24:51 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: maruthi.srinivas.b@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Hi,
>
> I saw that compressed audio framework being used
> with Asoc (alsa soc).
> Can the framework be used with other than Asoc ?
> I mean with ALSA pci based cards.

Never worked on this so don't know.
> I see the implementation in the following files. which one
> is to be used ?
> Does tinycompress in userspace can be used with either
> approaches ?
This will not be relevant after you see below answer.
>
>http://lxr.free-electrons.com/source/sound/core/compress_offload.c
>http://lxr.free-electrons.com/source/sound/soc/soc-compress.c

Both are compress framework driver files.
compress_offload.c file is the one which interacts with userspace
by using ioctl's, registers the compressed device with alsa
framework(/dev/compress* gets created because of that),  calls
the corresponding functions such as trigger, pointer update, copy
and others when userspace pauses, plays and stops the playback
or recording.

soc_compress.c file is the file which interacts with compress_offload.c
file to create a 'dev' node for compress driver.Basically when you
register your compress driver with compress framework,alsa core
will come to know that your dai support compress operations and
it will create the dev node by using soc_compress.c file.The functions
in this file gets called by compress_offload.c functions and who
inturn gets called by the userspace.

userspace->compress_offload.c->soc_compress.c->your_compress_driver.
