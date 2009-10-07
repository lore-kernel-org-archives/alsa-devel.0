From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 14/31] HDA patch_via.c: Add Jack detect
	feature for VT1708.
Date: Wed, 7 Oct 2009 13:56:35 +0800
Message-ID: <16685ee0910062256l6747526erfd71ed2c6927974d@mail.gmail.com>
References: <16685ee0910050727q4288fc76hdde23b431232d073@mail.gmail.com>
	<s5h7hv96fis.wl%tiwai@suse.de>
	<16685ee0910052206ge80ec18yb0546282c4a9945f@mail.gmail.com>
	<s5hhbudrrgb.wl%tiwai@suse.de>
	<20091006121740.GI17195@prithivi.gnumonks.org>
	<s5hws383dfv.wl%tiwai@suse.de>
	<16685ee0910060827t1ab399dek67447a1f635a72c9@mail.gmail.com>
	<s5hzl841qoy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 5150E24433
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 07:56:36 +0200 (CEST)
Received: by fxm8 with SMTP id 8so4226679fxm.45
	for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2009 22:56:36 -0700 (PDT)
In-Reply-To: <s5hzl841qoy.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, LoganLi@viatech.com.cn, Harald Welte <laforge@gnumonks.org>, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 6, 2009 at 11:34 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 6 Oct 2009 23:27:35 +0800,
> Li Bo wrote:
>>
>> On Tue, Oct 6, 2009 at 8:38 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Tue, 6 Oct 2009 14:17:40 +0200,
>> > Harald Welte wrote:
>> >>
>> >> Hi all,
>> >>
>> >> On Tue, Oct 06, 2009 at 08:01:40AM +0200, Takashi Iwai wrote:
>> >>
>> >> > > As you describe, we implement it with self-reschedule workqueue, =
acting
>> >> > > like a timer.
>> >> > > Is there some advice to implement timer-like task, I tested =A0wi=
th timer and
>> >> > > it will crash the driver.
>> >> >
>> >> > Right, you can't call it in a softirq.
>> >> >
>> >> > A few problems, however:
>> >> > - present variable should be in struct via_spec, instead of a static
>> >> > =A0 variable in update_hp_jack_state().
>> >>
>> >> I agree
>> >> > - This mechanism is unconditionally invoked on VT1708 although, in
>> >> > =A0 theory, you can have a hardware that doesn't need HP jack detec=
tion
>> >>
>> >> Yes, Logan/Li/Lydia: If we generate this kind of workaround with a ti=
mer,
>> >> it should only be used on those particular chips that absolutely need=
 it.
>> >
>> > As far as I see, the code is only for VT1708, so it's already specific
>> > to the codec chip. =A0But, even with this chip, you might have a pin
>> > configuration that doesn't need the HP jack detection.
>> >
>>
>> Yes, it's only for VT1708, and HP exists on most cases, and so HP jack d=
etection
>> are needed.
>> And present will put into via_spec.
>
> If it's restricted only during the opened (better running) PCM stream,
> it's not too bad. =A0But, it'd be even better to check the availability
> of HP jack.
>
Sorry about analog loopback is not considered, I think analog loopback
mute/unmute
callback should also be added, is that OK?

>> >> > - Waking up each 100ms for the *whole* time is really bad regarding
>> >> > =A0 the power-saving; can't it be optimized?
>> >>
>> >> I would personally actually suggest to simply not support headphone p=
lug events
>> >> in case you are using such a [buggy?] chipset that does not support t=
hem.
>> >>
>> >> I mean, what do you gain from that event? It's not something super-im=
portant.
>> >>
>> >> waking up unconditionally every 100ms is really a too high burden on =
the
>> >> battery life.
>> >>
>> >> Another option might be to make it a module load time parameter, so p=
eople
>> >> can choose if they actually want to pay the high power/batyery price =
for this
>> >> small feature.
>> >
>> > Yes.
>> >
>> > Basically, if we can drop the analog-loopback feature, the HP jack
>> > probing can be simplified very much. =A0The probing is needed only when
>> > the PCM is opened/prepared and running. =A0It can be implemented in a
>> > similar way for the volume-update procedure at PCM trigger.
>> > And, during PCM running, (relatively) high-frequent polling isn't so
>> > critical.
>> >
>> >
>> > thanks,
>> >
>> > Takashi
>> >
>>
>> I know that jack detect on VT1708 that do not support unsolicited
>> response is weird, but
>> =A0it's for customer request (and so are some other patches:), we just
>> have to do something.
>>
>> I think it's good in open/close callback, I'll update.
>>
>> About self-reschedule workqueue, maybe there are some other choices,
>> or should we keep
>> using it?
>
> A delayed workqueue is OK. =A0But, it should check some flag before
> rescheduling itself. =A0Also, don't forget about suspend/resume.
>
>
> thanks,
>
> Takashi
>
Thank you, I will rewrite like this.
