From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 14/31] HDA patch_via.c: Add Jack detect
	feature for VT1708.
Date: Thu, 8 Oct 2009 13:26:43 +0800
Message-ID: <16685ee0910072226u6c0e6c72g98cfc95f31fdf926@mail.gmail.com>
References: <16685ee0910050727q4288fc76hdde23b431232d073@mail.gmail.com>
	<s5h7hv96fis.wl%tiwai@suse.de>
	<16685ee0910052206ge80ec18yb0546282c4a9945f@mail.gmail.com>
	<s5hhbudrrgb.wl%tiwai@suse.de>
	<20091006121740.GI17195@prithivi.gnumonks.org>
	<s5hws383dfv.wl%tiwai@suse.de>
	<16685ee0910060827t1ab399dek67447a1f635a72c9@mail.gmail.com>
	<s5hzl841qoy.wl%tiwai@suse.de>
	<16685ee0910062256l6747526erfd71ed2c6927974d@mail.gmail.com>
	<s5hzl83y9cl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B88B1038DB
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:26:44 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1453208bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:26:43 -0700 (PDT)
In-Reply-To: <s5hzl83y9cl.wl%tiwai@suse.de>
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

On Wed, Oct 7, 2009 at 3:03 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 7 Oct 2009 13:56:35 +0800,
> Li Bo wrote:
>>
>> On Tue, Oct 6, 2009 at 11:34 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Tue, 6 Oct 2009 23:27:35 +0800,
>> > Li Bo wrote:
>> >>
>> >> On Tue, Oct 6, 2009 at 8:38 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> > At Tue, 6 Oct 2009 14:17:40 +0200,
>> >> > Harald Welte wrote:
>> >> >>
>> >> >> Hi all,
>> >> >>
>> >> >> On Tue, Oct 06, 2009 at 08:01:40AM +0200, Takashi Iwai wrote:
>> >> >>
>> >> >> > > As you describe, we implement it with self-reschedule workqueu=
e, acting
>> >> >> > > like a timer.
>> >> >> > > Is there some advice to implement timer-like task, I tested =
=A0with timer and
>> >> >> > > it will crash the driver.
>> >> >> >
>> >> >> > Right, you can't call it in a softirq.
>> >> >> >
>> >> >> > A few problems, however:
>> >> >> > - present variable should be in struct via_spec, instead of a st=
atic
>> >> >> > =A0 variable in update_hp_jack_state().
>> >> >>
>> >> >> I agree
>> >> >> > - This mechanism is unconditionally invoked on VT1708 although, =
in
>> >> >> > =A0 theory, you can have a hardware that doesn't need HP jack de=
tection
>> >> >>
>> >> >> Yes, Logan/Li/Lydia: If we generate this kind of workaround with a=
 timer,
>> >> >> it should only be used on those particular chips that absolutely n=
eed it.
>> >> >
>> >> > As far as I see, the code is only for VT1708, so it's already speci=
fic
>> >> > to the codec chip. =A0But, even with this chip, you might have a pin
>> >> > configuration that doesn't need the HP jack detection.
>> >> >
>> >>
>> >> Yes, it's only for VT1708, and HP exists on most cases, and so HP jac=
k detection
>> >> are needed.
>> >> And present will put into via_spec.
>> >
>> > If it's restricted only during the opened (better running) PCM stream,
>> > it's not too bad. =A0But, it'd be even better to check the availability
>> > of HP jack.
>> >
>> Sorry about analog loopback is not considered, I think analog loopback
>> mute/unmute
>> callback should also be added, is that OK?
>
> Honestly, I think we can remove the analog-loopback part completely
> for VT1708 + HP-jack. =A0If the loopback is inevitably needed, you can add
> a check of codec "hint" interface to determine whether to build the
> HP-jack detection or not at probing.
> About hints, look at snd_hda_get_bool_hint() and HD-Audio.txt.
>
>
> thanks,
>
> Takashi
>
OK, I add hp detect to prepare/cleanup, and check hint
"analog_loopback_hp_detect"
before adding it to analog mute/unmute.
Following will be the update patch
