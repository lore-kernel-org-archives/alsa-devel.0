From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [PATCH 1/4] ALSA: usb: stream: refactor audio
 interface parsing
Date: Mon, 23 Apr 2018 22:48:49 +0300
Message-ID: <CAB=otbQK3P5W-GCxncu-J2mCVuQYZuEBmOW=QJOKVF7RNUPGNQ@mail.gmail.com>
References: <1523658266-2259-1-git-send-email-ruslan.bilovol@gmail.com>
 <1523658266-2259-2-git-send-email-ruslan.bilovol@gmail.com>
 <s5hbmefzfja.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f194.google.com (mail-ot0-f194.google.com
 [74.125.82.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 76274267659
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 21:48:50 +0200 (CEST)
Received: by mail-ot0-f194.google.com with SMTP id i5-v6so18637282oth.1
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 12:48:50 -0700 (PDT)
In-Reply-To: <s5hbmefzfja.wl-tiwai@suse.de>
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
Cc: Jorge <jorge.sanjuan@codethink.co.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 19, 2018 at 12:55 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sat, 14 Apr 2018 00:24:23 +0200,
> Ruslan Bilovol wrote:
>>
>> Offload snd_usb_parse_audio_interface() function which
>> became quite long after adding UAC3 spec support.
>>
>> Move class-specific parts to separate functions
>> which now produce audioformat structure that is
>> ready to be fed to snd_usb_add_audio_stream().
>>
>> This also broke Blue Microphones workaround (which
>> relies on audioformat decoded from previous altsetting)
>> into two parts: prepare quirk flag analyzing previous
>> altsetting then use it with current altsetting.
>>
>> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
>
> Could you try to split this patch to two parts: one is a simple
> refactoring to move the code to snd_usb_get_audioformat_uac12(), and
> another to add snd_usb_get_audioformat_uac3().
>
> In this way, we can see a problem more clearly if it's in the
> refactoring part.
>

Sure, will do in in next patchset

Thanks,
Ruslan
