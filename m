From: Kim Therkelsen <kim_t26@hotmail.com>
Subject: Found bug in latest sound/pci/hda/patch_realtek.c from
 git, the bug is about jack sensing
Date: Mon, 22 Nov 2010 09:32:19 +0000
Message-ID: <SNT118-W17A55A7EAF6B07908236C08F3D0@phx.gbl>
References: <SNT118-W4512A0BF475F1EDBB13C678F360@phx.gbl>,
	<014C164B4D7B4B75AEF2A9B4B4291CAE@realtek.com.tw>
	<SNT118-W2992EBC62DD01C5069BF0D8F370@phx.gbl>,
	<6CB62B4DD6084764975D523294A5B643@realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from snt0-omc4-s9.snt0.hotmail.com (snt0-omc4-s9.snt0.hotmail.com
	[65.55.90.212]) by alsa0.perex.cz (Postfix) with ESMTP id A0ABF103893
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 10:32:25 +0100 (CET)
In-Reply-To: <6CB62B4DD6084764975D523294A5B643@realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: kailang@realtek.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi, =


I think I have found a bug in patch_realtek.c. I have a 272X codec in my la=
ptop and have discovered that it is only reported through the ALSA driver A=
PI when my headphone minijack is disconnected and not when it is connected.
This is happening because alc_report_jack(...) is only called when the mini=
jack connector is disconnected and not when it is connected.
In order to make jack sensing work properly i modified patch_realtek.c and =
added alc_report_jack(codec,=A0spec->autocfg.hp_pins[i]); at line 1132 (see=
 code below).

The code shown below is from:
http://git.kernel.org/?p=3Dlinux/kernel/git/next/linux-next.git;a=3Dblob;f=
=3Dsound/pci/hda/patch_realtek.c;h=3D2363f1893e8873dbe3508039e1ec5a11d72e20=
7a;hb=3Dbf1b022588eba78c990fd58fd2471cd92c2c5683

1118 static=A0void=A0alc_automute_speaker(struct=A0hda_codec=A0*codec,=A0in=
t=A0pinctl)
1119 {
1120 =A0=A0=A0=A0=A0=A0=A0=A0struct=A0alc_spec=A0*spec=A0=3D=A0codec->spec;
1121 =A0=A0=A0=A0=A0=A0=A0=A0unsigned=A0int=A0mute;
1122 =A0=A0=A0=A0=A0=A0=A0=A0hda_nid_t=A0nid;
1123 =A0=A0=A0=A0=A0=A0=A0=A0int=A0i;
1124 =

1125 =A0=A0=A0=A0=A0=A0=A0=A0spec->jack_present=A0=3D=A00;
1126 =A0=A0=A0=A0=A0=A0=A0=A0for=A0(i=A0=3D=A00;=A0i=A0<=A0ARRAY_SIZE(spec-=
>autocfg.hp_pins);=A0i++)=A0{
1127 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0nid=A0=3D=A0spec->auto=
cfg.hp_pins[i];
1128 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if=A0(!nid)
1129 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0break;
1130 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if=A0(snd_hda_jack_det=
ect(codec,=A0nid))=A0{
1131 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0spec->jack_present=A0=3D=A01;
//ADDED BY KT:=A0=A0=A0=A0 alc_report_jack(codec,=A0spec->autocfg.hp_pins[i=
]);

1132 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0break;
1133 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
1134 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0alc_report_jack(codec,=
=A0spec->autocfg.hp_pins[i]);
1135 =A0=A0=A0=A0=A0=A0=A0=A0}
1136 =

1137 =A0=A0=A0=A0=A0=A0=A0=A0mute=A0=3D=A0spec->jack_present=A0?=A0HDA_AMP_=
MUTE=A0:=A00;
1138 =A0=A0=A0=A0=A0=A0=A0=A0/*=A0Toggle=A0internal=A0speakers=A0muting=A0*/
1139 =A0=A0=A0=A0=A0=A0=A0=A0for=A0(i=A0=3D=A00;=A0i=A0<=A0ARRAY_SIZE(spec-=
>autocfg.speaker_pins);=A0i++)=A0{
1140 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0nid=A0=3D=A0spec->auto=
cfg.speaker_pins[i];
1141 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if=A0(!nid)
1142 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0break;
1143 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if=A0(pinctl)=A0{
1144 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0snd_hda_codec_write(codec,=A0nid,=A00,
1145 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0AC_VERB_SET_PIN_WIDGET_CONTROL,
1146 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0spec->jack_present=A0?=A00=A0:=A0PIN=
_OUT);
1147 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}=A0else=A0{
1148 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0snd_hda_codec_amp_stereo(codec,=A0nid,=A0HDA_OUTPUT,=A00,
1149 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0HDA_AMP_MUTE,=A0mute);
1150 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
1151 =A0=A0=A0=A0=A0=A0=A0=A0}
1152 }
Best regards,
Kim Therkelsen
 		 	   		  =
