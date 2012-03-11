From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] Initialize volumes of HD-audio slave ctls
Date: Sun, 11 Mar 2012 08:57:33 +0800
Message-ID: <CAN8ccian-zVTgyuMYCB6ouAcMitrCNbDhq96Rc=BgvTEjeNvkg@mail.gmail.com>
References: <s5haa3ryuxb.wl%tiwai@suse.de>
	<CAN8cciZNJvo_60b3icNT61+oy9n1U0Qy33u+T98OexPKwrL__A@mail.gmail.com>
	<s5h8vjanuk0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 5D8892439C
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 01:57:34 +0100 (CET)
Received: by werg1 with SMTP id g1so2288921wer.38
	for <alsa-devel@alsa-project.org>; Sat, 10 Mar 2012 16:57:34 -0800 (PST)
In-Reply-To: <s5h8vjanuk0.wl%tiwai@suse.de>
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

2012/3/9, Takashi Iwai <tiwai@suse.de>:
> At Fri, 9 Mar 2012 07:04:23 +0800,
> Raymond Yau wrote:
>>
>> 2012/3/8, Takashi Iwai <tiwai@suse.de>:
>> > Hi,
>> >
>> > the patch below is an attempt to initialize the volume / mutes of
>> > slave controls (such as "Headphone", "Speaker") with vmaster in
>> > HD-audio, so that the sound can come out only by changing the master
>> > volume/mute.
>> >
>> > We have thought that such initializations could be done well in
>> > alsactl init, but it seems that not everyone installs the latest and
>> > greatest alsactl, and there is always a risk that any new controls may
>> > be added before alsactl is updated and released.  Since the master
>> > volume is set muted, the risk by this change should be low.
>> >
>> > patch_cirrus.c still doesn't support this because it's handling
>> > vmaster by itself, but it can be fixed later, too.
>> >
>> > If anyone has a concern by this, please let me know.
>> >
>>
>> Can you explain the dB calculation of the volume controls when there
>> is a "virtual master" ?
>>
>> The Documentation only mention that all the slaves must have the same dB
>> range
>
> Well, more exactly, it'd work if the volume step is the same and the
> volume range of the first slave covers the all range.
>
>

patch_analog.c current only use DAC1

Is there any reason not to use DAC0 for ad1884 and ad1984 ?

This allow a separate volume control for "Headphone" and "Speaker"
