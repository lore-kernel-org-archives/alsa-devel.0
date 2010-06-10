From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Mixer volume/decibel mapping
Date: Thu, 10 Jun 2010 08:08:37 +0800
Message-ID: <AANLkTink38d7BlCxenX9HI7Ujz0v9Qr4xO_BEGRQ9ChB@mail.gmail.com>
References: <201005191834.57919.vand2@gmx.de>
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
	<AANLkTikWaBVuo-Vo8LIN6jS19cuPv4nDZbgYKzzZeLWg@mail.gmail.com>
	<201005211018.41802.vand2@gmx.de>
	<AANLkTikylA_oo6GBKuLHewVX9oMCNjQMeS90HThDR47K@mail.gmail.com>
	<4C0CB996.5010202@gmx.de>
	<AANLkTinTV_MnU-rBOrLc66YhGFbP9SJVZ2p5DFlcS16T@mail.gmail.com>
	<4C0DDE4D.9070201@gmx.de>
	<AANLkTimP9WxU1Ho4TsM6u4tCTYpkDyBBrx6W-9z92V2E@mail.gmail.com>
	<4C0F4418.20805@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A544103968
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Jun 2010 02:08:39 +0200 (CEST)
Received: by pxi3 with SMTP id 3so2879906pxi.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Jun 2010 17:08:38 -0700 (PDT)
In-Reply-To: <4C0F4418.20805@gmx.de>
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

2010/6/9 Sebastian H. <vand2@gmx.de>

> Am 09.06.2010 07:39, schrieb Raymond Yau:
> > 2010/6/8 Sebastian H. <vand2@gmx.de>
> >>>>
> >>>
> >>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4883
> >>>
> >>> Pekka Lampila reported that when he set -40dB and only get back
> -9999999
> >> by
> >>> his program alsa_mixer_test.c
> >>>
> >>> I don't have emu10k1 so don't know whether this is a bug of alsa-lib or
> >> not
> >>
> >> I also get a big jump from -39.60dB to -99999.99 dB for some emu10k1
> >> sliders when I move them to the minimum although their advertised
> >> minimum is -40dB. This looks like a way to express log ( 0 ).
> >>
> >
> > Do you ream snd_mixer_selem_get_Playback_dB_range() return 40dB but
> max_dB -
> > min_dB = 99999.99 dB ?
>
> e.g. snd_mixer_selem_get_playback_dB_range() for
> "Wave Surround" returns -40.00 to 0.00 dB and the dB values returned by
>
> snd_mixer_selem_get_playback_dB (
>         elem, SND_MIXER_SCHN_MONO, &_db_value );
>
> are all in this range except for when the volume ist set to 0.
> At this and only this volume the returned dB value is out of range with
> -99999.99 dB. For vol=1 the dB value is -39.60.
>
>
accoding to the forumla ,  1/100 is -40dB but 0x1571f82/0x8000000 is not 1%
so this is driver bug

 /* EMU10k1/EMU10k2 DSP control db gain */
 static const DECLARE_TLV_DB_SCALE(snd_emu10k1_db_scale1, -4000, 40, 1);
 static const DECLARE_TLV_DB_LINEAR(snd_emu10k1_db_linear, TLV_DB_GAIN_MUTE,
0);


 277 /* dB gain = (float) 20 * log10( float(db_table_value) / 0x8000000 ) */

static const u32 db_table[101] = {
      0x00000000, 0x01571f82, 0x01674b41, 0x01783a1b, 0x0189f540,
      0x019c8651, 0x01aff763, 0x01c45306, 0x01d9a446, 0x01eff6b8,
      0x0207567a, 0x021fd03d, 0x0239714c, 0x02544792, 0x027061a1,
      0x028dcebb, 0x02ac9edc, 0x02cce2bf, 0x02eeabe8, 0x03120cb0,
      0x0337184e, 0x035de2df, 0x03868173, 0x03b10a18, 0x03dd93e9,
      0x040c3713, 0x043d0cea, 0x04702ff3, 0x04a5bbf2, 0x04ddcdfb,
      0x0518847f, 0x0555ff62, 0x05966005, 0x05d9c95d, 0x06206005,
      0x066a4a52, 0x06b7b067, 0x0708bc4c, 0x075d9a01, 0x07b6779d,
      0x08138561, 0x0874f5d5, 0x08dafde1, 0x0945d4ed, 0x09b5b4fd,
      0x0a2adad1, 0x0aa58605, 0x0b25f936, 0x0bac7a24, 0x0c3951d8,
      0x0ccccccc, 0x0d673b17, 0x0e08f093, 0x0eb24510, 0x0f639481,
      0x101d3f2d, 0x10dfa9e6, 0x11ab3e3f, 0x12806ac3, 0x135fa333,
      0x144960c5, 0x153e2266, 0x163e6cfe, 0x174acbb7, 0x1863d04d,
      0x198a1357, 0x1abe349f, 0x1c00db77, 0x1d52b712, 0x1eb47ee6,
      0x2026f30f, 0x21aadcb6, 0x23410e7e, 0x24ea64f9, 0x26a7c71d,
      0x287a26c4, 0x2a62812c, 0x2c61df84, 0x2e795779, 0x30aa0bcf,
      0x32f52cfe, 0x355bf9d8, 0x37dfc033, 0x3a81dda4, 0x3d43c038,
      0x4026e73c, 0x432ce40f, 0x46575af8, 0x49a8040f, 0x4d20ac2a,
      0x50c335d3, 0x54919a57, 0x588dead1, 0x5cba514a, 0x611911ea,
      0x65ac8c2f, 0x6a773c39, 0x6f7bbc23, 0x74bcc56c, 0x7a3d3272,
       0x7fffffff, };
