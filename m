From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: stable-rc build: 9 warnings 0 failures (stable-rc/v3.18.75-20-g4ffe554)
Date: Tue, 17 Oct 2017 14:46:53 +0200
Message-ID: <CAK8P3a3jKcZhU4Ly0Fd4nLeZm4re0FLKdKK6=Ht4ZPsh6JDm2A@mail.gmail.com>
References: <59e5d9f0.4465630a.ed9cc.22c2@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <59e5d9f0.4465630a.ed9cc.22c2@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh <gregkh@linuxfoundation.org>
Cc: Olof Johansson <olof@lixom.net>, Kernel Build Reports Mailman List <kernel-build-reports@lists.linaro.org>, Olof's autobuilder <build@lixom.net>, Takashi Iwai <tiwai@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 17, 2017 at 12:22 PM, Olof's autobuilder <build@lixom.net> wrote:
> Warnings:
>
>       9 sound/usb/mixer.c:2161:27: warning: passing argument 1 of 'snd_usb_mixer_disconnect' from incompatible pointer type [-Wincompatible-pointer-types]

This broke after backporting 124751d5e63c ("ALSA: usb-audio: Kill stray
URB at exiting") into linux-3.18.

The interface was changed in commit a6cece9d8199 ("ALSA: usb-audio:
Pass direct struct pointer instead of list_head"), which was merged in
linux-3.19.

I don't immediately see how this can be fixed. Backporting a6cece9d8199
would probably work.

     Arnd
