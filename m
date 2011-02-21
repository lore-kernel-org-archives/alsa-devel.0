From: Mark Goldstein <goldstein.mark@gmail.com>
Subject: Re: pci/hda/patch_via.c - broken between 2.6.36 and
 2.6.37 (bisected)
Date: Mon, 21 Feb 2011 10:43:57 +0200
Message-ID: <AANLkTinDJ7k3pXqg7ZP5pcGVXUt+xWYRTv-pa4_=J15b@mail.gmail.com>
References: <ijqrmf$tlg$1@dough.gmane.org>
	<AANLkTin4TQvLwZX_mjhHq66STrsrXJu9a+bvsiSdxXub@mail.gmail.com>
	<4D6223CD.4060900@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E31F24141
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 09:44:18 +0100 (CET)
Received: by gye5 with SMTP id 5so232404gye.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 00:44:17 -0800 (PST)
In-Reply-To: <4D6223CD.4060900@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 21, 2011 at 10:35 AM, David Henningsson
<david.henningsson@canonical.com> wrote:
> On 2011-02-20 12:06, Mark Goldstein wrote:
>>
>> I think the Mic part might be the same problem I had. I found out that
>> the following code:
>>
>> static void via_auto_init_analog_input(struct hda_codec *codec)
>> {
>> =A0 =A0 =A0 =A0struct via_spec *spec =3D codec->spec;
>> =A0 =A0 =A0 =A0const struct auto_pin_cfg *cfg =3D&spec->autocfg;
>> =A0 =A0 =A0 =A0unsigned int ctl;
>> =A0 =A0 =A0 =A0int i;
>>
>> =A0 =A0 =A0 =A0for (i =3D 0; i< =A0cfg->num_inputs; i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hda_nid_t nid =3D cfg->inputs[i].pin;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (spec->smart51_enabled&& =A0is_smart51=
_pins(spec, nid))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctl =3D PIN_OUT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (i =3D=3D AUTO_PIN_MIC)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0^^^^^^^^^^^^^^^^^^^^^=
^^^^
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctl =3D PIN_VREF50;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctl =3D PIN_IN;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_write(codec, nid, 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0A=
C_VERB_SET_PIN_WIDGET_CONTROL, ctl);
>> =A0 =A0 =A0 =A0}
>> }
>>
>> configures correctly only the first MIC (in my case it was Rear MIC).
>> Front Mic pin was configured as HiZ.
>> Changing the underlined condition to
>>
>> else if (cfg->input[i].type =3D=3D AUTO_PIN_MIC)
>>
>> resolved the issue for me. (In alsa driver 1.0.23 this code was
>> different, it checked that i<=3D FRONT_MIC index).
>>
>> I'm also just the user of alsa driver, so can't decide whether this is
>> the proper fix. Maybe someone of knowledgeable developers could check
>> it.
>
> It looks like the proper fix to me. If you like the fame and fortune ;-) =
of
> having a commits in the kernel, I encourage you to submit a patch. Rememb=
er
> to have proper "Cc: stable@kernel.org" and "Signed-off-by" lines in the t=
he
> patch header, and to cc Takashi on the resulting email.
>
> If not, I'll be happy to do it for you. It seems like an important fix to
> me.
>
> --
> David Henningsson, Canonical Ltd.
> http://launchpad.net/~diwic
>

David,

I've never dealt with submitting patches, so probably it'll be better
(and definitely faster) if you could do it.

Thank you,
-- =

Mark Goldstein
