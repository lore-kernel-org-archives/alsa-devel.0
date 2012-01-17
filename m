From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ASoC: Allow drivers to specify how
 many bits are significant on a DAI
Date: Tue, 17 Jan 2012 19:51:29 +0100
Message-ID: <4F15C331.1020701@ti.com>
References: <1326739267-9678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F15377B.6080108@ti.com>
	<20120117113848.GE2944@opensource.wolfsonmicro.com>
	<4F157264.5020102@ti.com>
	<20120117131950.GF2944@opensource.wolfsonmicro.com>
	<4F15833B.2000808@ti.com>
	<20120117145646.GG2944@opensource.wolfsonmicro.com>
	<4F159CE2.4090306@ti.com>
	<20120117164452.GJ2944@opensource.wolfsonmicro.com>
	<4F15B611.2080808@ti.com>
	<20120117181709.GM2944@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
	[74.125.149.140])
	by alsa0.perex.cz (Postfix) with ESMTP id C9B5E103A5D
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 19:51:36 +0100 (CET)
Received: by mail-yx0-f179.google.com with SMTP id l11so2321254yen.24
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 10:51:32 -0800 (PST)
In-Reply-To: <20120117181709.GM2944@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 01/17/2012 07:17 PM, Mark Brown wrote:
> Off the top of my head it may decide that if it happens to have 24 bit
> data then passing it straight through was sensible.  But frankly I'm
> just working on the basis that if it's more effort to hide information
> than to provide it then providing it seems like the way forwards.  I've
> certainly got no intention of writing any code here myself unless
> there's some issue found.

We have the sample formats (S16_LE, S32_LE, etc) to tell application
about the supported level of bit depth.
They can choose to use 16bit if that is better for them, or choose
32bit. They make the decision based on the sample is playing,
configuration, whatever.
It does not help them if we tell when they use 16bit audio: hey, but you
could use 24bit.
When they use 32bit on the other hand it make sense to let them know
that out of the 32bit only the 24msb will be used, so they can align
their processing accordingly (if they care).

>> Yeah, but it is not correct. If it does not know this we have 8bit
>> 'latency' in gain control. Pulse can change the gain which will have no
>> effect.
> =

> Which will have the same overall effect as if it doesn't do anything
> based on knowing the resolution.

But we still 'loose' 8bits. It might be not a big loss at the end when
PA for example applies the gain, but for sure we will loose resolution
(8bit worth).

My only problem is to say this to application: "out of 8/16bit you
should use 24msb". AFAIK this is the meaning of the constraint. This
constraint makes sense for 32bit samples: "out of 32bit you should use
24msb".

-- =

P=E9ter
