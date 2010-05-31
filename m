From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Problem with snd_hda_intel from 05-27-2010 snapshot
Date: Mon, 31 May 2010 22:43:40 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005312241260.5693@eeebox2.perex-int.cz>
References: <AANLkTilIX_UnMYcg8LAqkndS80nFppblW6erTm2e7o5X@mail.gmail.com>
	<AANLkTinLbTMrYBhg6KO826slsugfEcU0_wYqukSQpQw2@mail.gmail.com>
	<alpine.LNX.2.00.1005270931570.6856@eeebox2.perex-int.cz>
	<AANLkTinvfYyOHzQrEfcBrDvDMW3Fc93oYrUHOcABm0Oa@mail.gmail.com>
	<alpine.LNX.2.00.1005290822040.6856@eeebox2.perex-int.cz>
	<AANLkTin1b34S7HeeHTppZkomIZ0Ka-xkC6viZt2Jfr1o@mail.gmail.com>
	<alpine.LNX.2.00.1005301733300.6856@eeebox2.perex-int.cz>
	<AANLkTim5L_klj1g-8hwnsftuR4x_GwESH_AOdeb4_XzT@mail.gmail.com>
	<alpine.LNX.2.00.1005312028520.5693@eeebox2.perex-int.cz>
	<AANLkTinOXLzkeqjLfrRXKxOp4jSBf3FMVcNanHa0ya0k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-2133176555-1275338620=:5693"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 15AD6245C1
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 22:43:41 +0200 (CEST)
In-Reply-To: <AANLkTinOXLzkeqjLfrRXKxOp4jSBf3FMVcNanHa0ya0k@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: VDR User <user.vdr@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-2133176555-1275338620=:5693
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 31 May 2010, VDR User wrote:

> On Mon, May 31, 2010 at 11:30 AM, Jaroslav Kysela <perex@perex.cz> wrote:
>> Thanks. Could you try this patch?
>>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 170610e..ac3dbab 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -1910,7 +1910,7 @@ static int azx_position_ok(struct azx *chip, struc=
t
>> azx_dev *azx_dev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (WARN_ONCE(!azx_dev->period_bytes,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0"hda-intel: zero azx_dev->period_bytes"))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1; /* thi=
s shouldn't happen! */
>> - =C2=A0 =C2=A0 =C2=A0 if (wallclk <=3D azx_dev->period_wallclk &&
>> + =C2=A0 =C2=A0 =C2=A0 if (wallclk < (azx_dev->period_wallclk * 3) / 2 &=
&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pos % azx_dev->period_bytes > a=
zx_dev->period_bytes / 2)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* NG - it's belo=
w the first next period boundary */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return bdl_pos_ad=
j[chip->dev_index] ? 0 : -1;
>>
>> -----
>
> I've got a bit of a strange result.  With the above patch (and the
> wallclk logging patch from your previous email), sound does not work.
> However, it _does_ start working only if I `echo 29 >
> /proc/asound/card1/pcm3p/xrun_debug`.  I tested these results with a
> reboot in between each attempt just to make sure I'm working with a
> clean boot.  I can't imagine what's causing this weird condition.  Any
> ideas?

Try to disable jiffies check (value 25 for xrun_debug). Please, post your=
=20
log for value 29 for inspection. Thanks.

 =09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-2133176555-1275338620=:5693
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-2133176555-1275338620=:5693--
