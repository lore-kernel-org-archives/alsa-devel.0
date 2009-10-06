From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 8/31] HDA patch_via.c: Change VT1708S &
	VT1702 hp mode controls
Date: Wed, 7 Oct 2009 01:42:50 +0800
Message-ID: <16685ee0910061042u68bb6822p12a37f942ec5bafa@mail.gmail.com>
References: <16685ee0910050725u67cdf3b5g8dcd20275bcf773f@mail.gmail.com>
	<s5hab056fwc.wl%tiwai@suse.de>
	<16685ee0910052144r444996bdqee29f374207cd7@mail.gmail.com>
	<s5hk4z9rs3o.wl%tiwai@suse.de>
	<16685ee0910060855i1e6dc4c5mf2ec443e71745b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B667103830
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 19:42:52 +0200 (CEST)
Received: by bwz25 with SMTP id 25so12885942bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2009 10:42:50 -0700 (PDT)
In-Reply-To: <16685ee0910060855i1e6dc4c5mf2ec443e71745b7@mail.gmail.com>
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

On Tue, Oct 6, 2009 at 11:55 PM, Li Bo <liboat@gmail.com> wrote:
> On Tue, Oct 6, 2009 at 1:47 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> At Tue, 6 Oct 2009 12:44:28 +0800,
>> Li Bo wrote:
>>>
>>> Hi, Takashi
>>> =A0 When independent hp switches from
>>> =A0 =A0 =A0 =A0 =A0 on -> off: hp volume/switch is deactivated
>>> =A0 =A0 =A0 =A0 =A0 off -> hp volume switch =A0is activated
>>> =A0 These 2 actions are one-shot setup, so we put "need reboot" to remi=
nd user
>>> =A0 that hp volume/switch update will only take effect after reboot.
>>
>> First off, you don't have to "reboot" at all :)
>>
>
> I also want to kick that "reboot" off:)
>
>> And, the activation/deactivation can be done on the fly, so it's no
>> more "one-shot" action (if implemented properly).
>>
>>
>> Takashi
>>
>
> You mean just act/deact on via_independent_hp_put? I'll try and update th=
is,
> thank you!
>
Sorry I don't know how to activate/deactivate on the fly. I toggle access'
SNDRV_CTL_ELEM_ACCESS_INACTIVE bit in via_independent_hp_put, but
in alsamixer it cannot reflect the change unless restart it. Please
give some help.


>>>
>>> On Mon, Oct 5, 2009 at 11:04 PM, Takashi Iwai <tiwai@suse.de> wrote:
>>> > At Mon, 5 Oct 2009 22:25:15 +0800,
>>> > Li Bo wrote:
>>> >>
>>> >> [ALSA] HDA VIA: Change VT1708S & VT1702 hp mode controls
>>> >>
>>> >> For VT1708S and VT1702, deactivate "Headphone Playback Volume" and
>>> >> "Headphone Playback Mute" control if "Independent HP" mode is OFF.
>>> >> and rename VT1702 "Independent HP" text.
>>> >>
>>> >> Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
>>> >> @@ -3342,11 +3359,13 @@
>>> >>
>>> >> =A0static int vt1702_auto_create_hp_ctls(struct via_spec *spec, hda_=
nid_t pin)
>>> >> =A0{
>>> >> - =A0 =A0 int err;
>>> >> -
>>> >> + =A0 =A0 int err, i;
>>> >> + =A0 =A0 struct hda_input_mux *imux;
>>> >> + =A0 =A0 static const char *texts[] =3D { "ON (need reboot)",
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0"OFF (need reboot)",
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0NULL};
>>> >
>>> > These texts look very strange...
>>> >
>>> >
>>> > Takashi
>>> >
>>>
>>
>
