From: Mark Goldstein <goldstein.mark@gmail.com>
Subject: Re: pci/hda/patch_via.c - broken between 2.6.36 and
 2.6.37 (bisected)
Date: Mon, 21 Feb 2011 08:55:38 +0200
Message-ID: <AANLkTimxPgGE1EPyyMCtQ4s=iW1dSJudONVY4-FPUakJ@mail.gmail.com>
References: <ijqrmf$tlg$1@dough.gmane.org>
	<AANLkTin4TQvLwZX_mjhHq66STrsrXJu9a+bvsiSdxXub@mail.gmail.com>
	<AANLkTikAqHaDRuFn6dXUrJ7ngmVoHLg8aHKU=LCosHOW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C54B224671
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 07:55:59 +0100 (CET)
Received: by gye5 with SMTP id 5so203032gye.38
	for <alsa-devel@alsa-project.org>; Sun, 20 Feb 2011 22:55:59 -0800 (PST)
In-Reply-To: <AANLkTikAqHaDRuFn6dXUrJ7ngmVoHLg8aHKU=LCosHOW@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 21, 2011 at 5:01 AM, Raymond Yau
<superquad.vortex2@gmail.com> wrote:
> 2011/2/20 Mark Goldstein <goldstein.mark@gmail.com>
>
>>
>> I think the Mic part might be the same problem I had. I found out that
>> the following code:
>>
>> static void via_auto_init_analog_input(struct hda_codec *codec)
>> {
>> =A0 =A0 =A0 struct via_spec *spec =3D codec->spec;
>> =A0 =A0 =A0 const struct auto_pin_cfg *cfg =3D &spec->autocfg;
>> =A0 =A0 =A0 unsigned int ctl;
>> =A0 =A0 =A0 int i;
>>
>> =A0 =A0 =A0 for (i =3D 0; i < cfg->num_inputs; i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hda_nid_t nid =3D cfg->inputs[i].pin;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spec->smart51_enabled && is_smart51_pins=
(spec, nid))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctl =3D PIN_OUT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (i =3D=3D AUTO_PIN_MIC)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^^^^^^^^^^^^^^^^^^^^^^^^^
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctl =3D PIN_VREF50;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctl =3D PIN_IN;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_write(codec, nid, 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AC_V=
ERB_SET_PIN_WIDGET_CONTROL, ctl);
>> =A0 =A0 =A0 }
>> }
>>
>> configures correctly only the first MIC (in my case it was Rear MIC).
>> Front Mic pin was configured as HiZ.
>> Changing the underlined condition to
>>
>> else if (cfg->input[i].type =3D=3D AUTO_PIN_MIC)
>>
>> resolved the issue for me. (In alsa driver 1.0.23 this code was
>> different, it checked that i <=3D FRONT_MIC index).
>>
>
> This may fix your vt1708s smart51 since only rear mic and line in are
> retasked
>
>
> static int is_smart51_pins(struct via_spec *spec, hda_nid_t pin)
> {
> =A0 =A0const struct auto_pin_cfg *cfg =3D &spec->autocfg;
> =A0 =A0int i;
> =A0 =A0 =A0 =A0if (cfg->line_outs !=3D 1)
> =A0 =A0 =A0 =A0return 0;
> =A0 =A0for (i =3D 0; i < cfg->num_inputs; i++) {
> =A0 =A0 =A0 =A0if (pin =3D=3D cfg->inputs[i].pin) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch(cfg->inputs[i].type=
){
> =A0 =A0 =A0 =A0 =A0 =A0case AUTO_PIN_LINE_IN:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case AUTO_PIN_MIC:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (
> strncmp(hda_get_autocfg_input_label(spec->codec,cfg,i),"Rear Mic",8) =3D=
=3D 0 )
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0}
> =A0 =A0return 0;
> }
>
> http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dcommit;h=3D1564b2878=
f5cf160f60af99d4dbca1dd7809ee8a
>
> Smart 5.1 is for 3-jacks model, to reuse input pins as outputs.
> While off, they act as "line out" / "line in" / "mic in".
> While on, they acts as "line out" / "back left/right" / "center/lfe".

Hi Raymond,
I've always had spart5.1 disabled and still Front Mic PIN has been
configured as High Impedance and did not work until I changed the code
as I described.

What I see in this function (is_smart51_pins) is that pin type is
checked the same way I tried, that is cfg->inputs[i].type is compared
to AUTO_PIN_MIC and not "i" itself as in the code of
via_auto_init_analog_input.

So should the via_auto_init_analog_input be fixed? What do you think?

BTW for some reason I can't see the link included in your mail, I'm
getting: 403 Forbidden - No such project

Thank you & regards,
-- =

Mark Goldstein
