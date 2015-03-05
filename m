From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: [PATCH] ALSA: hda - Make path_has_mixer() tristate
Date: Thu, 05 Mar 2015 11:20:50 +0100
Message-ID: <54f82ff9.6d7e8dc1.bm001@wupperonline.de>
References: <s5h385lq8yx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutD.wup.tal.de (moutd.wup.tal.de [213.240.144.30])
 by alsa0.perex.cz (Postfix) with ESMTP id CBB6B260481
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 11:31:23 +0100 (CET)
In-Reply-To: <s5h385lq8yx.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, superquad.vortex2@gmail.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote on Wed, 04 Mar 2015 12:48:38 +0100:

> At Tue, 03 Mar 2015 12:20:02 +0100,
> Ingo Br=FCckl wrote:
>>
>> ... in order to distinguish whether there is no ctl or no path at all.
>>
>> It is used as !path_has_mixer() which means that it is true even if
>> there is no path at all. For headphone or speaker outs without path,
>> because they don't have a DAC assign to them, this would give a false
>> positive result.

> Do you mean the code checking hp_lo_shared and spk_lo_shared in
> get_line_out_pfx()?

Exactly.

> How can they be no path?

This is due to me forcing a mutli-io config even if there is no DAC for the
speaker (please see the "Intel HDA / ALC662 analog surround problem" thread=
):

=3D=3D> Best config: lo_type=3D0, wired=3D0, mio=3D1
multi_outs =3D 14/0/0/0 : 2/3/4/0 (type LO)
multi_ios(2) =3D 1a/18 : 3/4
hp_outs =3D 1b/0/0/0 : 2/0/0/0
spk_outs =3D 15/0/0/0 : 0/0/0/0

I would love the auto-parser to assign the speaker to node 0x02 (or simply
disable the speaker), but unfortunately I'm not getting a surround config
with the current code, but only:

=3D=3D> lo_type=3D0, wired=3D1, mio=3D0
multi_outs =3D 14/0/0/0 : 2/0/0/0 (type LO)
hp_outs =3D 1b/0/0/0 : 4/0/0/0
spk_outs =3D 15/0/0/0 : 3/0/0/0

This is unsatisfactory.

Concerning my path_has_mixer() tristate patch: Raymond stated that
path_has_mixer() does not imply shared volume. Although I'm not familiar
enough with all this, I would agree that if there happens to be no path at
all, there isn't any sharing also.

Ingo
