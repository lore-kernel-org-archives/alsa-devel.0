From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Mixer volume/decibel mapping
Date: Tue, 25 May 2010 16:36:06 +0200
Message-ID: <4BFBE056.9000706@ladisch.de>
References: <201005191834.57919.vand2@gmx.de>	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>	<4BF629B3.9020904@ladisch.de>	<201005210951.36495.peter.ujfalusi@nokia.com>	<4BF658C6.4030404@ladisch.de>	<AANLkTik7mD1DAVWkOwM7sNu0EfgGApvzX9WRXWBOO4PI@mail.gmail.com>	<4BFB8E3E.3010209@ladisch.de>
	<AANLkTin7CGFuW_fhHEbhaDB77DLbKoTvck7YvuzVzGUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 8157D245CD
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 16:36:53 +0200 (CEST)
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DC7D9F85E3
	for <alsa-devel@alsa-project.org>; Tue, 25 May 2010 10:36:08 -0400 (EDT)
Received: from [10.1.2.19] (srv004.schk01.int.dmc-one.com [85.232.8.141])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9B3D5592EE
	for <alsa-devel@alsa-project.org>; Tue, 25 May 2010 10:36:07 -0400 (EDT)
In-Reply-To: <AANLkTin7CGFuW_fhHEbhaDB77DLbKoTvck7YvuzVzGUw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> I have doubt about DECLARE_TLV_DB_LINEAR(ak4396_db_scale, TLV_DB_GAIN_MUTE, 0);
> 
> since the datasheet mention that dB range is only -48dB to 0dB
> 
> ATT = 20 log10 (ATT_DATA / 255) [dB]
> 
> How can AK4396 has scale of -inf DB to 0dB in the driver code  ?

When ATT_DATA = 0, there is no output, which is an attenuation of -inf.
The next value, ATT_DATA = 1, results in ATT = -48 dB.

> BTW , if ymf7xx (DSP) only accept 16 bit digital PCM data and output to
> 18-20 bit AC97 codec ,

The DSP uses more precise values internally.

> how can the per stream volume control has a scale -inf dB to 0dB ?

multiplication factor 0:  dB = 20 log10(0) = -inf
multiplication factor 1:  dB = 20 log10(1) = 0

This is true regardless of the precision of the multiplier.  Even a one-
bit factor behaves like this; in fact, this would describe a mute switch.


HTH
Clemens
