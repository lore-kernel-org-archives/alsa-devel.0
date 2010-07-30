From: Adrian Pardini <pardo.bsso@gmail.com>
Subject: Re: [PATCH - usb: Headphone support for cm6206 2/2]
	usb: adds headphone source and mute controls to cm6206
Date: Fri, 30 Jul 2010 11:51:32 -0300
Message-ID: <AANLkTinz1nppFqi-DnzevEPFrmWN+m41=hOVWdUYfXhK@mail.gmail.com>
References: <201007201942.28942.pardo.bsso@gmail.com>
	<201007201944.29990.pardo.bsso@gmail.com>
	<s5hmxt9p2vp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 357EF103963
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 16:51:36 +0200 (CEST)
Received: by bwz4 with SMTP id 4so856848bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Jul 2010 07:51:36 -0700 (PDT)
In-Reply-To: <s5hmxt9p2vp.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 30/07/2010, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 20 Jul 2010 19:44:29 -0300,
> Adrian Pardini wrote:
>>
>> +static int snd_cm6206_headphone_source_get(struct snd_kcontrol *kcontrol,
>> struct snd_ctl_elem_value *ucontrol)
>
> Try to avoid too long lines.  Once when you feed your patch to
> scripts/checkpatch.pl, you'll see it :)
>

Ah, I forgot that step. Yes, it promptly complained.

>> +static int snd_cm6206_headphone_source_put(struct snd_kcontrol *kcontrol,
>> struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
>> +	struct usb_device *dev = mixer->chip->dev;
>> +
>
> Remove a blank line here.
>

done.


>> +	u16 reg2 = mixer->cm6206reg2;
>
> I think the corresponding change in mixer.h is missing?
>

Yes, it's missing. Is ok to cache the register value there? I'm doing
it that way because it doesn't interfere with other functions of the
board and also haven't managed yet to read it with an usb transfer.

>> +	u16 idx = kcontrol->private_value = ucontrol->value.integer.value[0];
>> +
>> +	reg2 = (u16)((((1<<7) | (idx<<5))<<8) | (reg2 & 0x1800));
>
> We are no lispers.  Please reduce parentheses.  Also avoid unnecessary
> cast.

ok, is something like this more acceptable?

reg2 = ((1<<7 | idx<<5)<<8) | (reg2 & 0x1800);



Thanks a lot for your time.


-- 
Adrian.
http://elesquinazotango.com.ar
http://www.noalcodigodescioli.blogspot.com/
