From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Re: Major reworks on patch_via.c (TESTERS WANTED)
Date: Wed, 6 Jul 2011 02:49:30 +0200
Message-ID: <CAPzVeym8F3a8_PWN0H-rh0ei-fTUj-zecH6UierO_9G4qCbZYQ@mail.gmail.com>
References: <s5hvcw04k50.wl%tiwai@suse.de> <s5h8vsu0wkr.wl%tiwai@suse.de>
	<CAPzVey=K7+3FGV6YufNuK3ucf46z62OzTLXHCJVfGpKGfqiShQ@mail.gmail.com>
	<s5hwrfy5hoc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001517592bd021920a04a75bf9dd
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 1829710393F
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jul 2011 02:49:31 +0200 (CEST)
Received: by wwi14 with SMTP id 14so2660213wwi.2
	for <alsa-devel@alsa-project.org>; Tue, 05 Jul 2011 17:49:30 -0700 (PDT)
In-Reply-To: <s5hwrfy5hoc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Raymond Yau <superquad.vortex2@gmail.com>, haraldwelte@viatech.com, lydiawang <lydiawang@viatech.com.cn>
List-Id: alsa-devel@alsa-project.org

--001517592bd021920a04a75bf9dd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2011/7/4 Takashi Iwai <tiwai@suse.de>:
> At Sat, 2 Jul 2011 18:00:27 +0200,
> alex dot baldacchino dot alsasub at gmail dot com wrote:
>>
>> 2011/6/22 Takashi Iwai <tiwai@suse.de>:
>> > At Mon, 20 Jun 2011 17:06:51 +0200,
>> > Takashi Iwai wrote:
>> >>
>> >> Hi,
>> >>
>> >> as there have many problems reported for VIA codecs, I started lookin=
g
>> >> at the driver code, and decided to rework on it.
>> >> [...]
>>
>> I've installed and tested (from tarballs) both snapshot
>> alsa-driver-20110630 and latest version (alsa-driver-snapshot.tar.gz)
>> - up to commit e5e14681404ec27a422d635284bf564dabde3f81 by Lydia Wang,
>> I think.
>>
>> I've found problems with both. That's a quite huge change in the
>> implementation from older code, so I need to study it more in depth to
>> understand it better... At the moment I can only describe the problems
>> and give my first impressions on them.
>>
>> First of all, I can't get sound from the front playback (rear
>> line-out).
> ...
>
> These should be fixed now by Lydia's patch. =A0I updated sound git
> tree and snapshot tarball now. =A0Please check it later.
>

I've been far from my pc yesterday for some reasons, and haven't had
got too much time today as well, but I've gathered latest version of
patch_via.c from
http://git.kernel.org/?p=3Dlinux/kernel/git/tiwai/sound-2.6.git;a=3Dcommit;=
h=3Dbac4b92cf7a444c0af8dd7b269c8791595c44052
and made a few tests in different conditions, with following results:

Booting with both front and hp connected:
- no sound from rear green jack (front pin);
- louder and noisier recording of ongoing playback (gives me an idea
of stereo mixer quality);
- louder sound on hp regardless of independent mode being set on or
off, but when nothing is connected to front pin (0x24) - of course,
since nothing connected to 0x24 means parm =3D=3D AC_PWRST_D3 and HP
Independent mode ON means state of hp pin (0x28) to be disregarded,
thus 0x8 is set to D3 by set_widgets_power_state_vt1718S():


	/* PW0 (24h), AOW0 (8h) */
	parm =3D AC_PWRST_D3;
	set_pin_power_state(codec, 0x24, &parm);
	if (!spec->hp_independent_mode) /* check for redirected HP */
		set_pin_power_state(codec, 0x28, &parm);
	snd_hda_codec_write(codec, 0x8, 0, AC_VERB_SET_POWER_STATE, parm);


Booting with only front pin connected:
- same as above for recording and sound out of hp pin;
- now I get sound from front pin, thus it would seem that some
automuting is triggered at boot-time (and only at boot-time and/or
driver re-load after rmmod'ing - though not tested - since
detaching/attaching connectors after boot-up/after drivers are loaded
doesn't change such behaviour); such didn't happen in older
implementation (before this rework) and, personally, I preferred that
behavior;
- using same stream settings as front when stream channels are less
then line-outs (for exceeding line-outs) works as well.


Independent HP doesn't work, as before, problem (and fix) still being the s=
ame:


--- ./alsa-driver/alsa-kernel/pci/hda/patch_via.c.last	2011-07-05
16:25:35.844001455 +0200
+++ ./alsa-driver/alsa-kernel/pci/hda/patch_via.c	2011-07-05
16:25:23.652001521 +0200
@@ -2974,7 +2974,7 @@ static void set_widgets_power_state_vt17
 				    AC_VERB_SET_POWER_STATE, parm);
 		snd_hda_codec_write(codec, 0x34, 0,
 				    AC_VERB_SET_POWER_STATE, parm);
-		snd_hda_codec_write(codec, 0xc, 0,
+		snd_hda_codec_write(codec, spec->hp_dac_nid, 0,
 				    AC_VERB_SET_POWER_STATE, parm);
 	}
 }



>
>> One notably thing is that the new (for codec VT1718S family) Master
>> control misses a few slaves, mainly:
>> ...
>> - more noticeably, there's no "Headphone Playback Volume" control.
>> ...
>
> Hm, I'll check this with your alsa-info.sh output.
>

Now "Headphone Playback Volume" is back, thanks.

>
>> A final (minor) question/consideration on the code. I've noticed now
>> .put helpers validate data gathered from userspace (typically, passed
>> through ucontrol parameter), which is a good choice to protect against
>> some bug external to the driver; however, if I'm not mistaken,
>> via_mux_enum_put (and corresponding _get) could still be missing
>> something: since any data in ucontrol->id is passed as is to
>> snd_ctl_get_ioffidx, is there any chance that the result could be an
>> invalid index?
>
> No, such an invalid id will be filtered out in the upper layer.
>
>
> thanks,
>
> Takashi
>


Thanks for your clarification.

Attaching alsa-info.sh output for my last test (with the above changes
to make Independent HP work)

Regards,

Alex

--001517592bd021920a04a75bf9dd
Content-Type: application/x-gzip; name="alsa-info.tar.gz"
Content-Disposition: attachment; filename="alsa-info.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gpr1pchj0

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
iTdU2EVWl4CrsMuJNxXYdZHRJuAq7HLi6yrsIptPwBXYDTnxDRV2UYpMwFXY5cQ3VdhFGTYBV2Cv
y2yeKP3dlJkNUfp7XWbzROnvpsxsiNLf63LiVf5el5kNUfp7XU68yt/rMrMhSn9vyIlX+XtdZvNE
6e8NOfEqf6/LbJ4o/b0hJ17l73VZiiRKf2/IiVf5e12WIonS31sym9eV/t6SmY2u9PeWzOZ1pb+3
ZGajK/29LSde5e8tmdnoSn9vy4lX+XtLZja60t/bcuJV/t6S2byu9Pe2nHiVv7dkNq8r/b0tJ17l
7y1ZitSV/t6WE6/y95YsReoqfyfSjpmh8ncinPJKwFXYZTZvqPydCGfMEnAVdjnxCn8nwgm3BFyF
XU68wt+JcL4uAVdhlxOv8HciHccZKn8n0nGcofJ3Ih3HGSp/J9JxnKHydyIdxxkqfyfScZyh8nci
HccZyvyORB4X0j8U4xCRvUbOmAbxDdGJaz3tdtn7uIIh8vkd/7m3lnUvTrq/a9pvcKATJ4yQP0Ls
0n734F/ogxUMH6yAJrdVQ8SqaeytVgh32Ju2rmdv3bpJ74qzosJ+Zei6cMqWjV5NB3HlsIPILslf
QX8H+DB3psRHMnzpzezr4vnGMeoZxg8XGbIPF6vhIZ34dWLX+ZeLzXAZSTFOXl+Gl8aidS+PDs4v
D0taPuhefPx0efQyStZ3dTmRhUJSKCTcmMdsV4hqK+avjEp+8s0jUHK7m72iDk44K+wFczeadsBO
7h46GG1d7W/tbileG7eloXg/Cr4c5F0Hbc12xd/iCxTGE9+jXhSyMmisk+55v53ucb8dP2yMk/oJ
YfzoIIOtCLpy2IoPZEcBKwBhES25NM5zg7ZOrTCiwdY2XxphTaxB8ubADprc87Xi6XftPz5flTYJ
+UqX9Du7TL3pmK3KSBfEJOtVwmS9GgIjGTsRnGY1MKohk+mQVchdZwvvmuY/btB1jTR26ni4Dz99
70bAQfZAlpSJlGoxmfEjNSd0FAFd8cmlc3sXqUmH7xlwrpapo2tQEuME7+AZHyjf/AL1q/m+ODh9
YY4NouKY7YTQJLHq8poTcSyqX80xb+M703L2oNdXp2vmpgkfRF+EcSGAgvP40ZUq/lP2V2I73fBy
KRlx0ZQkAnkgr80y/+Xiam7T/Qu+M/OOn8b/qtLPcgycHB+9ZeqdF0+brx9Y4qW7lWyvqp6SEpTI
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
--001517592bd021920a04a75bf9dd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001517592bd021920a04a75bf9dd--
