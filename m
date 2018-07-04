From: =?UTF-8?B?UmFwaGHDq2wgRGluZ8Op?= <raphael.dinge@ohmforce.com>
Subject: Re: Can't detect "XRUNs"
Date: Wed, 4 Jul 2018 12:38:57 +0200
Message-ID: <CAL-i0qFbukDczTtgnkbfpE=Giu6piv6dvcMi-D=QtnYy69Q5FQ@mail.gmail.com>
References: <CAL-i0qF80jHGH_7Cwxik3HO86Ng3PZH18fxf0vABk4cMUY5OdQ@mail.gmail.com>
 <s5hwoubwar6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
 [209.85.218.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 98CEE267214
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 12:38:58 +0200 (CEST)
Received: by mail-oi0-f42.google.com with SMTP id c6-v6so9882774oiy.0
 for <alsa-devel@alsa-project.org>; Wed, 04 Jul 2018 03:38:58 -0700 (PDT)
In-Reply-To: <s5hwoubwar6.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

>> Am I missing something completely?
>
> The recent kernel puts the xrun debug messages in trace buffer instead
> of the kernel messages.  Try to enable the tracing in
> /sys/kernel/debug/tracing/events/snd_pcm/xrun/enable, and watch the
> trace buffer (/sys/kernel/debug/tracing/trace).

Thanks for your very quick reply, I'll try this now.

Raphael
