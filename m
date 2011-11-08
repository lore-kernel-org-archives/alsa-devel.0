From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Why my linux OS has only 8 sound cards ? How can I
	modify it ?
Date: Tue, 8 Nov 2011 07:43:26 -0800
Message-ID: <CA+55aFwtfDu5PdBSAazMSPrni=Pv9cpE110=tfKXM8rCa4H6Kw@mail.gmail.com>
References: <8c87f06b-dbfc-4035-8e5b-044e598939ae@i13g2000prg.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C951A103928
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 16:43:47 +0100 (CET)
Received: by wwf27 with SMTP id 27so666274wwf.20
	for <alsa-devel@alsa-project.org>; Tue, 08 Nov 2011 07:43:47 -0800 (PST)
In-Reply-To: <8c87f06b-dbfc-4035-8e5b-044e598939ae@i13g2000prg.googlegroups.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Chris Shen <chris2shen@gmail.com>
List-Id: alsa-devel@alsa-project.org

Chris - you need to pick a better set of people to ask. A mailing
list, right maintainer etc.

Takashi, any idea? Do we have some 8-sound-card limit somewhere?

I do see that we have that odd

        if (card && card->number >=3D 8)
                return 0; /* ignore silently */

in sound/core/sound_oss.c: snd_register_oss_device(), but it has no
comments. The thing goes back to 2005 with the commit log entry of
"[ALSA] dynamic minors (6/6): increase maximum number of sound cards",
but the value '8'isn't explained.

                Linus


On Tue, Nov 8, 2011 at 12:30 AM, Chris Shen <chris2shen@gmail.com> wrote:
> Hi,everyone!
> =A0 My =A0version of kernel is linux-2.6.35 .And my board has 10 sounds
> cards.After system was up,I used the comand "aplay -l ".Then console
> would display this:
> **** List of PLAYBACK Hardware Devices ****
> card 0: imx3stack [imx-3stack], device 0: WM8731 WM8731-0 []
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> card 1: default [C-Media USB Headphone Set =A0], device 0: USB Audio
> [USB Audio]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> card 2: default_1 [C-Media USB Headphone Set =A0], device 0: USB Audio
> [USB Audio]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> card 3: default_2 [C-Media USB Headphone Set =A0], device 0: USB Audio
> [USB Audio]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> card 4: default_3 [C-Media USB Headphone Set =A0], device 0: USB Audio
> [USB Audio]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> card 5: default_4 [C-Media USB Headphone Set =A0], device 0: USB Audio
> [USB Audio]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> card 6: default_5 [C-Media USB Headphone Set =A0], device 0: USB Audio
> [USB Audio]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> card 7: default_6 [C-Media USB Headphone Set =A0], device 0: USB Audio
> [USB Audio]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> card 8: default_7 [C-Media USB Headphone Set =A0], device 0: USB Audio
> [USB Audio]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> card 9: default_8 [C-Media USB Headphone Set =A0], device 0: USB Audio
> [USB Audio]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> But,when I used the command "ls /dev/dsp*" ,the console display:
> /dev/dsp =A0 /dev/dsp2 =A0/dev/dsp4 =A0/dev/dsp6
> /dev/dsp1 =A0/dev/dsp3 =A0/dev/dsp5 =A0/dev/dsp7
> when the board is up ,I found have this err "unable to register OSS
> mixer device 8:0" and "unable to register OSS mixer device 9:0" .
> I think the kernel's max sound cards is 8 .How can I modify it ?
> Thank you!
>
