From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 8/31] HDA patch_via.c: Change VT1708S &
	VT1702 hp mode controls
Date: Thu, 8 Oct 2009 13:29:27 +0800
Message-ID: <16685ee0910072229q53c3a649g84cfa716aa70d86a@mail.gmail.com>
References: <16685ee0910050725u67cdf3b5g8dcd20275bcf773f@mail.gmail.com>
	<s5hab056fwc.wl%tiwai@suse.de>
	<16685ee0910052144r444996bdqee29f374207cd7@mail.gmail.com>
	<s5hk4z9rs3o.wl%tiwai@suse.de>
	<16685ee0910060855i1e6dc4c5mf2ec443e71745b7@mail.gmail.com>
	<16685ee0910061042u68bb6822p12a37f942ec5bafa@mail.gmail.com>
	<s5hpr90o0we.wl%tiwai@suse.de>
	<16685ee0910062301w1f372f88r24d17e78491bfbbb@mail.gmail.com>
	<s5h1vlfzo3l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A23510391D
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:29:28 +0200 (CEST)
Received: by fxm8 with SMTP id 8so5183134fxm.45
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:29:28 -0700 (PDT)
In-Reply-To: <s5h1vlfzo3l.wl%tiwai@suse.de>
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
Cc: LoganLi@viatech.com.cn, alsa-devel@alsa-project.org, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 7, 2009 at 2:59 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 7 Oct 2009 14:01:51 +0800,
> Li Bo wrote:
>>
>> On Wed, Oct 7, 2009 at 2:03 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Wed, 7 Oct 2009 01:42:50 +0800,
>> > Li Bo wrote:
>> >>
>> >> On Tue, Oct 6, 2009 at 11:55 PM, Li Bo <liboat@gmail.com> wrote:
>> >> > On Tue, Oct 6, 2009 at 1:47 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> >> At Tue, 6 Oct 2009 12:44:28 +0800,
>> >> >> Li Bo wrote:
>> >> >>>
>> >> >>> Hi, Takashi
>> >> >>> =A0 When independent hp switches from
>> >> >>> =A0 =A0 =A0 =A0 =A0 on -> off: hp volume/switch is deactivated
>> >> >>> =A0 =A0 =A0 =A0 =A0 off -> hp volume switch =A0is activated
>> >> >>> =A0 These 2 actions are one-shot setup, so we put "need reboot" t=
o remind user
>> >> >>> =A0 that hp volume/switch update will only take effect after rebo=
ot.
>> >> >>
>> >> >> First off, you don't have to "reboot" at all :)
>> >> >>
>> >> >
>> >> > I also want to kick that "reboot" off:)
>> >> >
>> >> >> And, the activation/deactivation can be done on the fly, so it's no
>> >> >> more "one-shot" action (if implemented properly).
>> >> >>
>> >> >>
>> >> >> Takashi
>> >> >>
>> >> >
>> >> > You mean just act/deact on via_independent_hp_put? I'll try and upd=
ate this,
>> >> > thank you!
>> >> >
>> >> Sorry I don't know how to activate/deactivate on the fly. I toggle ac=
cess'
>> >> SNDRV_CTL_ELEM_ACCESS_INACTIVE bit in via_independent_hp_put, but
>> >> in alsamixer it cannot reflect the change unless restart it. Please
>> >> give some help.
>> >
>> > You simply need to notify the control elements you changed via
>> > snd_ctl_notify().
>> > Then the mixer app will update the status as well.
>> >
>> >
>> > Takashi
>> >
>>
>> I add snd_ctl_notify after access update, but test with results that:
>> =A0 - alsamixer (v1.0.21) will gray/de-grayed the control only after
>> restart the application
>
> Hm, strange. =A0Are you sure that it's notified?
>
>> =A0 - gnome-volume-control will just ignore the access bit and display
>> the control as usual.
>
> Then it's a bug of gnome-volume-control (maybe in gstreamer).
>
>> Maybe we have to backward to snd_ctl_remove implementation.
>
> No, removing is a really bad interface. =A0If the control notification
> is done properly, it's just a matter of application side.
>
> When the control is inactive, you can't change the value, so it's
> anyway safe in the driver perspective.
>
>
> thanks,
>
> Takashi
>
OK, I'll remove "need reboot" text and update access bit on the run.
Following will be update patch
