From: Carlo Caione <carlo@endlessm.com>
Subject: Re: ASoC: rt5640,
 rt5651 jack-detect and BYT SST suspend/resume patches / status
 update
Date: Wed, 14 Feb 2018 09:59:18 +0000
Message-ID: <CAL9uMOGAMz9MT6rz2-RnwtJyKnpORGcTgJ0JNBVQzyqzaOkAjg@mail.gmail.com>
References: <98d557fa-0c5d-0955-0987-0b5dc6764282@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f44.google.com (mail-vk0-f44.google.com
 [209.85.213.44])
 by alsa0.perex.cz (Postfix) with ESMTP id CEF862677B9
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 10:59:20 +0100 (CET)
Received: by mail-vk0-f44.google.com with SMTP id d125so75345vkf.4
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 01:59:20 -0800 (PST)
In-Reply-To: <98d557fa-0c5d-0955-0987-0b5dc6764282@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 11, 2018 at 12:00 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi Pierre-Louis, Carlo, et al,

Hey Hans,

> This mail is mostly just FYI, I've been doing a lot of work
> on $subject lately and the purpose of this mail is to avoid
> people doing double work.

really nice. Thank you for this.

/cut

> Note the rt5651 jack change to fix headset vs headphone
> detection does not work yet, now it sees everything as
> headphones ...

I tried your latest kernel and it works fine detecting my headset.
AFAICT the problem (that I have also with the current driver shipped
in the latest mainline kernel) is that the headset/mic detection _does
not always work fine_. Sometimes the headset is only recognized as
headphones but if you keep trying (usually detaching and attaching
again the jack) then the driver is able to recognize it as headset
(usually after a few tries).

> I probably won't have much time to continue work on this
> today and as said the main purpose of this mail is to get
> you aware of these patches to avoid double work. I hope to
> be able to rebase on top of 4.16-rc1, and do an upstream
> submission of everything except for the rt5640 jack-detect
> code sometime the next week.
>
> Regards,
>
> Hans
>
> p.s.
>
> Carlo or Pierre-Louis can one of you check using e.g.
> the left + right speaker test in gnome-control-panel's
> sound config-applet if that left only goes to the left
> speaker and right only goes to the right speaker?
>
> My bytcr-rt5651 tablet has only one speaker, but I
> here sound for both the left and right speaker tests
> which suggests some right-to-left mixing is happening
> which we don't want on devices with stereo speakers.
> Could be there is some mixing happening outside of the
> codec on this tablet, still it would be good to test
> this.

Just tested this and it works fine on my hardware.

Cheers,

-- 
Carlo Caione  |  +44.7384.69.16.04  |  Endless
