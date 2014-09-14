From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Sun, 14 Sep 2014 19:37:29 +0800
Message-ID: <CAN8cciYj4fo01XZwJ-NhFQDNv6Ua5mqaAEq1zU7PYxHkJyOQ5A@mail.gmail.com>
References: <540C76E0.9050808@gmail.com>
	<54148E72.2050903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f173.google.com (mail-qc0-f173.google.com
 [209.85.216.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 31717264F3F
 for <alsa-devel@alsa-project.org>; Sun, 14 Sep 2014 13:37:31 +0200 (CEST)
Received: by mail-qc0-f173.google.com with SMTP id i8so2527039qcq.4
 for <alsa-devel@alsa-project.org>; Sun, 14 Sep 2014 04:37:30 -0700 (PDT)
In-Reply-To: <54148E72.2050903@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

>
>
>> === On the rewind safeguard ===
>
>
> Result 1: it has been decided that the return value of
snd_pcm_rewindable() is not changed, and the safeguard is returned by a
separate function.

It is unlikely to return any value which is safe, it is the responsiability
of the application to decide how much can be rewind

If pulseaudio assume 20ms process time is require to process two seconds of
audio and sleep for 1980ms, it should not assume cpu have infinite power

what is the purpose of the timestamp ?

Can the timestamp use to predict when will next period update occur if the
timestamp is obtained at previous period update ?

Why snd_pcm_rewind cannot return error when application  just set stop
threshold to buffer size and rewind more than the stop threshold ?

:This would require documentation changes for snd_pcm_rewindable(), though,
as it officially no longer returns "safe count of frames which can be
rewinded". I have difficulty designing a better wording what the function
actually means now.

The word "safe" should be removed
