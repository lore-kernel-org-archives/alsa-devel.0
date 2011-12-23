From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] hda - is_jack_detectable()
Date: Fri, 23 Dec 2011 10:37:15 +0800
Message-ID: <CAN8cciaeA72ku+s1WWC3aJ21sXEV3B=yDDpZF2X7VXK+mUO6VA@mail.gmail.com>
References: <CAN8cciZ4z5Jx9oHxoSt2K=NoOsOVMFjmaZjxPCXSDD05J5NdVA@mail.gmail.com>
	<CAN8ccia3XSQ0TxD2CqH7bSv=stf4Z8qbdeo=sOt_NUZ5+GNM=w@mail.gmail.com>
	<4EB05EA1.1060701@canonical.com> <s5hy5vzknvk.wl%tiwai@suse.de>
	<CAN8cciZYTq7MCu18nF6ovJa9Km61HUjyBiRfFP3E4gp60i0yhA@mail.gmail.com>
	<s5h8vntl7ix.wl%tiwai@suse.de>
	<CAN8cciacfUwDh4+oK7sBnRDhyoh-rLrFxYnnZUHnNiZxn1P3Yw@mail.gmail.com>
	<s5hy5vplqn2.wl%tiwai@suse.de> <s5hpqh1lopc.wl%tiwai@suse.de>
	<CAN8ccibAoNQfDNWJ-zE_DGH6mc-ipmmdhBDQW+fjOMT8xHcD+Q@mail.gmail.com>
	<s5h4ny76naa.wl%tiwai@suse.de>
	<CAN8cciYT=tvXVzCyMjEpf=FKMA0OqTvqxtgEkEPJwbGfxH+hBA@mail.gmail.com>
	<s5hr516lqw8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BCCF2103F54
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 03:37:15 +0100 (CET)
Received: by wgbdr1 with SMTP id dr1so12099212wgb.20
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 18:37:15 -0800 (PST)
In-Reply-To: <s5hr516lqw8.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/11/17, Takashi Iwai <tiwai@suse.de>:
> At Wed, 16 Nov 2011 15:14:17 +0800,
> Raymond Yau wrote:
>>
>> 2011/11/14 Takashi Iwai <tiwai@suse.de>:
>
>> >
>> > The lack of the initial pin-state of kclts was fixed in a different
>> > patch now.  But, the need of 200ms delay worries me whether it's
>> > needed generically at each pin-sense reading or it's just only for the
>> > initial reading.
>> >
>> > Does the pin-sense reading work in general after loading the driver
>> > stably?
>> >
>> >
>> >
>>
>> Presence detect bit is alway correct, without the delay.
>>
>> the only issue is the impedance measurement of the plugged jacks at
>> computer boot need a delay 200ms
>>
>> For the user application to know the impedance ,
>> it seem the client application have to issue
>> 1) set_pin_sense
>> 2) delay
>> 3) get_pin_sense to get the correct impedance of the attached device
>>
>> just like my modified hda-jack-sense-test in previous email
>>
>> Can it measure the impedance of the jacks of your computer ?
>
> It seems that this doesn't work machines here with Realtek codecs.
> So, this must be pretty depending on the codec chip.
>
> Anyway, currently there is no use of impedance, and the jack presence
> can be detected immediately without delay, we can keep the code as
> is now.
>

How can I add the new hda-jack detect to patch_analog.c ?

Only ad1988 use  snd_hda_parse_pin_def_config() to parse the pin,
other ad198x codecs are used model since snd_hda_jack_add_ctls()
require those pin info from autocfg

The auto model of ad1988 use init_verbs ad1988_6stack_init which
cannot handle those 3 stack motherboard asus m2n

What is the reason to call snd_hda_jack_report_sync() at the end of
unsol event handler ?
