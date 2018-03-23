From: Andrew Chant <achant@google.com>
Subject: Re: [PATCH 2/2] ALSA: usb-audio: UAC2 jack detection
Date: Fri, 23 Mar 2018 15:24:55 -0700
Message-ID: <CANVWZtHyFz2MZ4aQjRu3WLyB1WY=5JMN5=s_oL1v0ZEyqr2nCQ@mail.gmail.com>
References: <20180322213956.217933-1-achant@google.com>
 <20180322213956.217933-3-achant@google.com>
 <s5hzi2z9qsk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb0-f170.google.com (mail-yb0-f170.google.com
 [209.85.213.170])
 by alsa0.perex.cz (Postfix) with ESMTP id A0EFC266B67
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 23:25:37 +0100 (CET)
Received: by mail-yb0-f170.google.com with SMTP id x72-v6so975664ybe.8
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 15:25:37 -0700 (PDT)
In-Reply-To: <s5hzi2z9qsk.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Benson Leung <bleung@google.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 23, 2018 at 12:47 AM, Takashi Iwai <tiwai@suse.de> wrote:
> Let's follow the other usages, and here iface is set to
> SNDRV_CTL_ELEM_IFACE_CARD.  This was for avoiding such volatile
> controls appearing the mixer application.
Will do - it looks like the "Clock Source Validity" control also needs this.
I'll send a patch for that as well.

>> +     .access = SNDRV_CTL_ELEM_ACCESS_READ,
>
> Actually we should have set SNDRV_CTL_ELEM_ACCESS_VOLATILE, too.
> We forgot it in ctljack.c, too.
Sounds good.

>
> The rest looks good.  But one thing to confirm: the value change
> notification is done in snd_usb_mixer_interrupt()?
>
> Also, is the jack re-detected after suspend/resume?  That is, plug off
> the jack while sleeping, and after the resume, is the jack status
> change recognized and notified?

Yes - the USB audio device causes a remote wakeup, then after a few ms
responds with the interrupt data message indicating the connector control
that changed.  This ends up calling snd_usb_mixer_interrupt().

On codeaurora kernels for Qualcomm SoCs, there's a
patch which enables autosuspend for any USB device with an audio interface.
https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/sound/usb/card.c?h=LA.HB.1.1.5.c1#n663
so suspend/resume paths are well tested when devices are used on Android.

Two new questions:
#1 - I'd like to report the impedance of the load connected to the jack
(generally as an integer).  Is a read-only control element the right way to
do this?

#2 - In our particular case there's a single jack which can detect presence of
a microphone and playback separately.  USB descriptors provide a mechanism to
show that the input and output terminals are linked in this way
(terminal type 4xx along with bAssocTerminal).

Is there a better way of having this reported than two separate mono jack
controls?
