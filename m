From: abraham duenas <aduejazz@gmail.com>
Subject: Re: ALSA UCM
Date: Tue, 9 Nov 2010 10:54:49 -0600
Message-ID: <AANLkTina11GuK4jqP=DtD-OEjTiRtNa_yG0QKy7XDuxs@mail.gmail.com>
References: <AANLkTimFdKg=_KDv8fbSJry6XTEsZqyQz7GhzaPxXDYP@mail.gmail.com>
	<1288865349.3277.14.camel@odin>
	<AANLkTim1Aopc2ALEXoWorPjzua0gGoSef8CpH+At4_cp@mail.gmail.com>
	<1288890598.3277.81.camel@odin>
	<alpine.LNX.2.00.1011041932410.29422@eeebox2.perex-int.cz>
	<1288896461.3277.98.camel@odin>
	<alpine.LNX.2.00.1011041949180.29422@eeebox2.perex-int.cz>
	<1288897628.3277.99.camel@odin>
	<AANLkTikn6Q+6KUpZaDGXuX=bGHrbV_9s91C6u+rS5e22@mail.gmail.com>
	<1289046396.3318.53.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 17151103871
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 17:54:50 +0100 (CET)
Received: by ewy26 with SMTP id 26so907465ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2010 08:54:49 -0800 (PST)
In-Reply-To: <1289046396.3318.53.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello, I think this is missing:

diff --git a/src/ucm/main.c b/src/ucm/main.c
index e233f41..a73595d 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -774,9 +774,9 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
        pthread_mutex_lock(&uc_mgr->mutex);
        if (strcmp(identifier, "_verbs") =3D=3D 0)
                err =3D get_verb_list(uc_mgr, list);
-        else if (strcmp(identifier, "_enadevs"))
+        else if (strcmp(identifier, "_enadevs") =3D=3D 0)
                err =3D get_enabled_device_list(uc_mgr, list);
-        else if (strcmp(identifier, "_enamods"))
+        else if (strcmp(identifier, "_enamods") =3D=3D 0)
                err =3D get_enabled_modifier_list(uc_mgr, list);
         else {
                 str1 =3D strchr(identifier, '/');

And changing the "[" for a "{" in the SectionVerb and SectionDevice like th=
is:
SectionVerb {
        EnableSequence {
                cset "name=3D'DL1 Media Playback Volume' 90"
                cset "name=3D'DL2 Media Playback Volume' 90"
        }
..........
SectionDevice."Headset".0 {
        Comment "SDP4430 3.5mm Headset"

        EnableSequence {
                cset "name=3D'DL1 Mixer Multimedia' 0"
                cset "name=3D'Sidetone Mixer Playback' 1"
                cset "name=3D'HS Right Playback' 0"
                cset "name=3D'HS Left Playback' 0"
                cset "name=3D'MUX_UL11' 9"
                cset "name=3D'MUX_UL10' 10"
        }
...........

I'm getting the expected error ONLY for the last element: listed in
the EnableSequence field:
e.g:
ALSA lib main.c:137:(execute_sequence) cset not yet implemented:
'name=3D'DL2 Media Playback Volume' 90'
ALSA lib main.c:137:(execute_sequence) cset not yet implemented:
'name=3D'MUX_UL10' 10'

i'll keep on digging as time permits :)

On Sat, Nov 6, 2010 at 6:26 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> On Fri, 2010-11-05 at 15:23 -0600, abraham duenas wrote:
>> ok I changed to this form in the SectionDefaults at SDP4430.conf:
>> cset "name=3D'Capture Preamplifier Volume' 0,0"
>> cset "name=3D'Capture Volume' 0,0"
>> cset "name=3D'Aux FM Volume' 0,0"
>> ...
>> and so on.... =A0and on "hifi" is remove all "index=3DX" references...
>>
>> Some things I noticed is that at parse_sequence function in
>> /ucm/parser.c the 'const char *id' never matches 'cset' or 'sleep' or
>> 'exec' when parsing SectionDevice of the verb file. And in
>> "execute_sequence" function of the the /ucm/main.c it never gets into
>> the "list_for_each" cycle which in turn would show me the "
>> uc_error("cset not yet implemented: '%s'", s->data.cset);"
>
> Ok, so either your config is different compared to Jaroslav's or there
> is a bug in the parser. I'd expect you to see the "cset not implemented"
> warning so can you try your Jaroslav's config with your debug trace.
>
> Thanks
>
> Liam
> --
> Freelance Developer, SlimLogic Ltd
> ASoC and Voltage Regulator Maintainer.
> http://www.slimlogic.co.uk
>
>
