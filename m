From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Mixer volume/decibel mapping
Date: Tue, 25 May 2010 21:51:18 +0800
Message-ID: <AANLkTin7CGFuW_fhHEbhaDB77DLbKoTvck7YvuzVzGUw@mail.gmail.com>
References: <201005191834.57919.vand2@gmx.de>
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
	<4BF629B3.9020904@ladisch.de>
	<201005210951.36495.peter.ujfalusi@nokia.com>
	<4BF658C6.4030404@ladisch.de>
	<AANLkTik7mD1DAVWkOwM7sNu0EfgGApvzX9WRXWBOO4PI@mail.gmail.com>
	<4BFB8E3E.3010209@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id BE4D424588
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 15:51:19 +0200 (CEST)
Received: by pvc22 with SMTP id 22so3173036pvc.38
	for <alsa-devel@alsa-project.org>; Tue, 25 May 2010 06:51:18 -0700 (PDT)
In-Reply-To: <4BFB8E3E.3010209@ladisch.de>
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
List-Id: alsa-devel@alsa-project.org

2010/5/25 Clemens Ladisch <clemens@ladisch.de>

> Raymond Yau wrote:
> > 2010/5/21 Clemens Ladisch <clemens@ladisch.de>
> > > DB_LINEAR means that the mixer control value is a multiplier for the
> > > PCM sample value, as James wrote.  A DB_LINEAR mapping has
> > > 0 =3D=3D -infinity dB, full scale =3D=3D 0 dB, and the mapping betwee=
n mixer
> > > control values and corresponding dB values it _not_ linear.
> >
> > pci/oxygen/oxygen.c:static const DECLARE_TLV_DB_LINEAR(ak4396_db_scale,
> TLV_DB_GAIN_MUTE, 0);
> > pci/oxygen/hifier.c:static const DECLARE_TLV_DB_LINEAR(ak4396_db_scale,
> TLV_DB_GAIN_MUTE, 0);
> >
> > Refer to AK4396 datasheet
> >
> > Output Volume
> >
> > The AK4396 includes channel independent digital output volumes (ATT) wi=
th
> > 256 levels at linear step including MUTE.
> > These volumes are in front of the DAC and can attenuate the input data
> from
> > 0dB to =9648dB and mute.
> >
> > dB range is -48dB to 0dB only
> >
> > ATT7-0: Attenuation Level
> >         ATT =3D 20 log10 (ATT_DATA / 255) [dB]
> >         FFH : 0dB (Default)
> >         00H : Mute
>
> This is the section of the datasheet on which the above declarations are
> based.
>
> Now if you have some remark or question, you should remember to include
> it in your mail.
>
>
> Regards,
> Clemens
>

I have doubt about DECLARE_TLV_DB_LINEAR(ak4396_
db_scale, TLV_DB_GAIN_MUTE, 0);

since the datasheet mention that dB range is only -48dB to 0dB ,  DR and S/N
is only 120dB

ATT =3D 20 log10 (ATT_DATA / 255) [dB]

How can AK4396 has scale of -inf DB to 0dB in the driver code  ?

BTW , if ymf7xx (DSP) only accept 16 bit digital PCM data and output to
18-20 bit AC97 codec , how can the per stream volume control has a scale
-inf dB to 0dB ?

inf dB may occur  when  DSP accept floating point

however  the storage of Float pointing is still finite , the min dB of DSP
accept FLOAT64 should in theory lower than the min dB of those DSP accept
FLOAT32
