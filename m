From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 8/31] HDA patch_via.c: Change VT1708S &
	VT1702 hp mode controls
Date: Tue, 6 Oct 2009 23:55:01 +0800
Message-ID: <16685ee0910060855i1e6dc4c5mf2ec443e71745b7@mail.gmail.com>
References: <16685ee0910050725u67cdf3b5g8dcd20275bcf773f@mail.gmail.com>
	<s5hab056fwc.wl%tiwai@suse.de>
	<16685ee0910052144r444996bdqee29f374207cd7@mail.gmail.com>
	<s5hk4z9rs3o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id B95691039A9
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 17:55:01 +0200 (CEST)
Received: by fxm8 with SMTP id 8so3706699fxm.45
	for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2009 08:55:01 -0700 (PDT)
In-Reply-To: <s5hk4z9rs3o.wl%tiwai@suse.de>
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

On Tue, Oct 6, 2009 at 1:47 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 6 Oct 2009 12:44:28 +0800,
> Li Bo wrote:
>>
>> Hi, Takashi
>> =A0 When independent hp switches from
>> =A0 =A0 =A0 =A0 =A0 on -> off: hp volume/switch is deactivated
>> =A0 =A0 =A0 =A0 =A0 off -> hp volume switch =A0is activated
>> =A0 These 2 actions are one-shot setup, so we put "need reboot" to remin=
d user
>> =A0 that hp volume/switch update will only take effect after reboot.
>
> First off, you don't have to "reboot" at all :)
>

I also want to kick that "reboot" off:)

> And, the activation/deactivation can be done on the fly, so it's no
> more "one-shot" action (if implemented properly).
>
>
> Takashi
>

You mean just act/deact on via_independent_hp_put? I'll try and update this,
thank you!

>>
>> On Mon, Oct 5, 2009 at 11:04 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Mon, 5 Oct 2009 22:25:15 +0800,
>> > Li Bo wrote:
>> >>
>> >> [ALSA] HDA VIA: Change VT1708S & VT1702 hp mode controls
>> >>
>> >> For VT1708S and VT1702, deactivate "Headphone Playback Volume" and
>> >> "Headphone Playback Mute" control if "Independent HP" mode is OFF.
>> >> and rename VT1702 "Independent HP" text.
>> >>
>> >> Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
>> >> @@ -3342,11 +3359,13 @@
>> >>
>> >> =A0static int vt1702_auto_create_hp_ctls(struct via_spec *spec, hda_n=
id_t pin)
>> >> =A0{
>> >> - =A0 =A0 int err;
>> >> -
>> >> + =A0 =A0 int err, i;
>> >> + =A0 =A0 struct hda_input_mux *imux;
>> >> + =A0 =A0 static const char *texts[] =3D { "ON (need reboot)",
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"OFF (need reboot)",
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0NULL};
>> >
>> > These texts look very strange...
>> >
>> >
>> > Takashi
>> >
>>
>
