From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Fix wrong detection of
 "Headphone+LO" or "Speaker+LO"
Date: Tue, 03 Mar 2015 17:02:19 +0100
Message-ID: <54F5DB0B.8020507@canonical.com>
References: <54f5ce0b.08a2b775.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000804020101000107050907"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B32326154F
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 17:02:20 +0100 (CET)
In-Reply-To: <54f5ce0b.08a2b775.bm000@wupperonline.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?windows-1252?Q?Ingo_Br=FCckl?= <ib@wupperonline.de>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, superquad.vortex2@gmail.com
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000804020101000107050907
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable



On 2015-03-03 16:04, Ingo Br=FCckl wrote:
> David Henningsson wrote on Tue, 03 Mar 2015 14:24:28 +0100:
>
>> If I understand correctly, you have three DACs, one internal speaker,
>> one headphone jack, and three jacks that are both used for 5.1 surroun=
d
>> and line out/mic/line in. Is this correct?
>
> This is correct. In addition I have a front mic jack.

Could you upload/pastebin your alsa-info somewhere? Then we could run it=20
through the emulator and reproduce the problem.

>> How do the DACs get assigned in this case? One would assume that you'd
>> get 02 -> Front LO, HP, Speaker, 03 -> Rear LO, 04 -> CLFE LO.
>
> With my private patch to enforce multi-io I seem to lose the internal s=
peaker
> which isn't bad because it isn't connected (and probably never won't be=
).

Since you're using private patches you're somewhat out on "unsupported"=20
ground, but anyhow...

>
> You are right concerning the remaining assignments:
>
> multi_outs =3D 14/0/0/0 : 2/3/4/0 (type LO)
>    out path: depth=3D3 '02:0c:14'
> multi_ios(2) =3D 1a/18 : 3/4
>    mio path: depth=3D3 '03:0d:1a'
>    mio path: depth=3D3 '04:0e:18'
> hp_outs =3D 1b/0/0/0 : 2/0/0/0
>    hp  path: depth=3D3 '02:0c:1b'
> spk_outs =3D 15/0/0/0 : 0/0/0/0
>
>> And then the volume/mute control for DAC node 02 would be called "PCM"
>> (since both hp_lo_shared and spk_lo_shared are true), but in fact it w=
ould
>> be more appropriate to call it "Front".
>
> I've got a Master that would only affect the Front (PCM) and a PCM that
> affected Surround/CLFE which was very unpleasant.
>
> With the patch I'm getting a real Master (for all Front/Surround/CLFE) =
and a
> separate Front Volume Control in addition to Surround, Center and LFE w=
hich
> is exactly how it should be.

Hmm. What do you think of the attached patch - would it work as well? It=20
removes the part that returns early for all three, letting it fall=20
through to the part that returns "Front" etc.

--=20
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------000804020101000107050907
Content-Type: text/x-patch;
 name="pfx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pfx.patch"

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index b680b4e..9f0be7c 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1100,11 +1100,9 @@ static const char *get_line_out_pfx(struct hda_codec *codec, int ch,
 		if (!ch && cfg->speaker_outs && cfg->hp_outs) {
 			bool hp_lo_shared = !path_has_mixer(codec, spec->hp_paths[0], ctl_type);
 			bool spk_lo_shared = !path_has_mixer(codec, spec->speaker_paths[0], ctl_type);
-			if (hp_lo_shared && spk_lo_shared)
-				return spec->vmaster_mute.hook ? "PCM" : "Master";
-			if (hp_lo_shared)
+			if (hp_lo_shared && !spk_lo_shared)
 				return "Headphone+LO";
-			if (spk_lo_shared)
+			if (spk_lo_shared && !hp_lo_shared)
 				return "Speaker+LO";
 		}
 	}

--------------000804020101000107050907
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000804020101000107050907--
