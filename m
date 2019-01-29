From: Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH 1/1] seq: arecordmidi: Add num-events option
Date: Tue, 29 Jan 2019 15:42:30 -0800
Message-ID: <CACeCKadEU4i5d82pMwnU1y_f9_Rw+cgG7PROjP5a2B_dzj0qHw@mail.gmail.com>
References: <5c4fb010.1c69fb81.94ca0.01ae@mx.google.com>
 <f0c4b673-52a2-fc1d-c9d8-4e4b42f999f1@sakamocchi.jp>
 <CACeCKacREMJDGWNJrdydu3+P1EZ81AyaY0sPfBhuiT11nnvV5A@mail.gmail.com>
 <20190129084502.GA9419@workstation>
 <ef5b180f-e1da-7ec9-9e2b-0b5b4b86ac14@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F79E2674B9
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 00:42:43 +0100 (CET)
Received: by mail-qk1-f193.google.com with SMTP id g125so12657936qke.4
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 15:42:42 -0800 (PST)
In-Reply-To: <ef5b180f-e1da-7ec9-9e2b-0b5b4b86ac14@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Interesting. Thanks for pointing that out, Clemens.

In any case, I've sent both versions (atoi v/s strtol), so whichever one is
preferred can be used (would be slightly inclined towards atoi, since it's
used elsewhere in the file, and because of Clemens' comment; additionally,
there is less code duplication with the atoi version).

Best regards,

On Tue, Jan 29, 2019 at 8:19 AM Clemens Ladisch <clemens@ladisch.de> wrote:

> Takashi Sakamoto wrote:
> > When parsing string with non-numeric characters, the behaviour of
> > atoi() is undefined still in C11.
>
> A completely non-numeric string is specified to return zero.
>
> The behaviour is undefined only if the value cannot be represented, i.e.,
> if it overflows.
>
>
> Regards,
> Clemens
>
