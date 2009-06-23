From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Subject: Re: Regarding Sound on Acer Aspire 6935G
Date: Tue, 23 Jun 2009 15:05:37 -0300
Message-ID: <d54969c50906231105k251880eahbf82cf74b699c7d8@mail.gmail.com>
References: <4b8c423b0905152051w7443e1b4u4080514a560fbb6c@mail.gmail.com>
	<s5h3a9sm8oa.wl%tiwai@suse.de>
	<d54969c50906221451o6e92044cj3da24df67e55268b@mail.gmail.com>
	<1245707939.441.5.camel@localhost> <s5hfxdrex0w.wl%tiwai@suse.de>
	<1245709097.441.7.camel@localhost> <1245710676.441.9.camel@localhost>
	<d54969c50906221614k5e12f5edt8973f7bb8e69592c@mail.gmail.com>
	<1245712854.441.11.camel@localhost>
	<d54969c50906221623j4fd17c6yb7fc2c9316d11766@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B4C024355
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 20:05:39 +0200 (CEST)
Received: by qyk1 with SMTP id 1so337749qyk.16
	for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2009 11:05:37 -0700 (PDT)
In-Reply-To: <d54969c50906221623j4fd17c6yb7fc2c9316d11766@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Vroon <tony@linx.net>
Cc: Takashi Iwai <tiwai@suse.de>, Karthik Ramgopal <applefreakpeeps@gmail.com>, ALSA development ML <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I had a little free time, so I decided to play a little with alsa. I
copied the mic verbs from the old model to this new one and it seems
to be working fine. Here is the patch for that

diff -wur alsa-driver/sound/pci/hda/patch_realtek.c
alsa-driver-patched/sound/pci/hda/patch_realtek.c
--- alsa-driver/sound/pci/hda/patch_realtek.c	2009-06-22
12:50:12.000000000 -0300
+++ alsa-driver-patched/sound/pci/hda/patch_realtek.c	2009-06-23
14:57:40.511853856 -0300
@@ -1471,6 +1471,10 @@
 static struct hda_verb alc888_acer_aspire_6530g_verbs[] =3D {
 /* Bias voltage on for external mic port */
 	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN | PIN_VREF80},
+/* Front Mic: set to PIN_IN (empty by default) */
+	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+/* Unselect Front Mic by default in input mixer 3 */
+	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0xb)},
 /* Enable unsolicited event for HP jack */
 	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
 /* Enable speaker output */

Now, the only 'broken' thing is jack sensing, it just mutes front, but
not LFE. I guess this is an easy to fix issue.

Emilio

2009/6/22 Emilio L=F3pez <buhitoescolar@gmail.com>
>
> I can test patches if you'd like
>
> 2009/6/22 Tony Vroon <tony@linx.net>
>>
>> On Mon, 2009-06-22 at 20:14 -0300, Emilio L=F3pez wrote:
>> > The mic worked with model=3Dacer-aspire-4930g, maybe you can "copy" the
>> > information from that model or something?
>>
>> Will have to see whether copying both internal-mic related verbs from
>> the 4930g model helps, indeed. I found the arecord message rather
>> disconcerting though.
>> Also, while I have remote access to he 6530g its owner is not feeling
>> well and she can't help me run further tests.
>>
>> Sorry, no further patches tonight.
>>
>> Regards,
>> Tony V.
>>
>> P.S. And I blame my e-mail client for swapping my From address around
>> randomly.
>
