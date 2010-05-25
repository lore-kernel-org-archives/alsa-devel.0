From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Mixer volume/decibel mapping
Date: Wed, 26 May 2010 07:00:22 +0800
Message-ID: <AANLkTim77m6JMHSGCGJUN2h-3_Gsv7v7Afu7sbmhaK5_@mail.gmail.com>
References: <201005191834.57919.vand2@gmx.de>
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
	<4BF629B3.9020904@ladisch.de>
	<201005210951.36495.peter.ujfalusi@nokia.com>
	<4BF658C6.4030404@ladisch.de>
	<AANLkTik7mD1DAVWkOwM7sNu0EfgGApvzX9WRXWBOO4PI@mail.gmail.com>
	<4BFB8E3E.3010209@ladisch.de>
	<AANLkTin7CGFuW_fhHEbhaDB77DLbKoTvck7YvuzVzGUw@mail.gmail.com>
	<4BFBE056.9000706@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id E6EB424590
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 01:00:23 +0200 (CEST)
Received: by pwj9 with SMTP id 9so3448457pwj.38
	for <alsa-devel@alsa-project.org>; Tue, 25 May 2010 16:00:23 -0700 (PDT)
In-Reply-To: <4BFBE056.9000706@ladisch.de>
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
> > I have doubt about DECLARE_TLV_DB_LINEAR(ak4396_db_scale,
> TLV_DB_GAIN_MUTE, 0);
> >
> > since the datasheet mention that dB range is only -48dB to 0dB
> >
> > ATT = 20 log10 (ATT_DATA / 255) [dB]
> >
> > How can AK4396 has scale of -inf DB to 0dB in the driver code  ?
>
> When ATT_DATA = 0, there is no output, which is an attenuation of -inf.
> The next value, ATT_DATA = 1, results in ATT = -48 dB.
>

But snd_mixer_selem_get_playback_dB_range() does not return 48dB
**
