From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [Q] ASoC: What's the real meaning of
	SND_SOC_DAIFMT_NB_NF?
Date: Fri, 24 Feb 2012 16:09:39 +0200
Message-ID: <4F479A23.6010307@ti.com>
References: <CACKLOr1sDSEFCiAsRO-vKrk7f+r=_Ex9irog1NKDmXn7LJFCDw@mail.gmail.com>
	<20120223151934.GB4553@opensource.wolfsonmicro.com>
	<CACKLOr23+DPp=XZ=RJEPgKYyvw3UOxkWR8xtzYG9Y9NWcicJSg@mail.gmail.com>
	<20120223161446.GA7245@opensource.wolfsonmicro.com>
	<CACKLOr10yUYpMSrebnLvMkc=XQLUXNDxwM+P6U8ysH_Xre3Tmw@mail.gmail.com>
	<4F474B97.6020407@ti.com>
	<CACKLOr14EHqGWcYCfLK0WXiVZsewDVyFPV2tpfYJK4tBZKMUXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id DAFD1104295
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 15:10:03 +0100 (CET)
Received: by mail-lpp01m010-f45.google.com with SMTP id i5so3943984lah.18
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 06:09:43 -0800 (PST)
In-Reply-To: <CACKLOr14EHqGWcYCfLK0WXiVZsewDVyFPV2tpfYJK4tBZKMUXg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
List-Id: alsa-devel@alsa-project.org

On 02/24/2012 01:05 PM, javier Martin wrote:
>> I don't think it is going to break. I would guess that the channels are
>> swapped on these machines at the moment. If you correct the CPU dai
>> driver the only thing that will happen is that the channels will jump in
>> their correct place.
> =

> That would be true for stereo. However, mono should not be working right =
now.

The notion of mono in I2S, Left/Right Justified formats is not really
valid. They are stereo protocols by design. DSP_A/B is used with mono
audio (which often referred as PCM).
It is the responsibility of the codec/cpu drivers to interpret the
standards correctly, and configure themselves accordingly. Take a look
at the Wolfson codec documentation they are really good in this matter
(what I2S, DSP/PCM, and other coding means in real life).
You can look at the omap-mcbsp driver for an example, but configuring
the FS/BC polarity in the format selection (without taking a look at the
INV mask) does not seam to be correct.

-- =

P=E9ter
