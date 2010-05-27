From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Mixer volume/decibel mapping
Date: Thu, 27 May 2010 08:20:45 +0800
Message-ID: <AANLkTinridxynoJ2ujHnHJav2sO0YvEZK4ttaMckjxcE@mail.gmail.com>
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
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id ACADA10399F
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 02:20:47 +0200 (CEST)
Received: by pvc22 with SMTP id 22so4047477pvc.38
	for <alsa-devel@alsa-project.org>; Wed, 26 May 2010 17:20:46 -0700 (PDT)
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
>
>
> > BTW , if ymf7xx (DSP) only accept 16 bit digital PCM data and output to
> > 18-20 bit AC97 codec ,
>
> The DSP uses more precise values internally.
>

DSP use more precise values internally only increase the number of step ( dB
per step is much finer resolution , the dB range is limited to the number of
bits of the input digital signral and output digital signal which pass
through ac97 link

There seem to be no hardware can provide infinte dB range
