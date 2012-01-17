From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ASoC: Allow drivers to specify how
 many bits are significant on a DAI
Date: Tue, 17 Jan 2012 14:06:44 +0100
Message-ID: <4F157264.5020102@ti.com>
References: <1326739267-9678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F15377B.6080108@ti.com>
	<20120117113848.GE2944@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69]) by alsa0.perex.cz (Postfix) with ESMTP id 3EE7A24366
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 14:06:56 +0100 (CET)
Received: by mail-gy0-f176.google.com with SMTP id g2so686328ghb.7
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 05:06:48 -0800 (PST)
In-Reply-To: <20120117113848.GE2944@opensource.wolfsonmicro.com>
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

On 01/17/2012 12:38 PM, Mark Brown wrote:
>> Might be not an issue to say that we have 24msbit on the 8bit sample,
>> but it does not sound right.
> =

> It shouldn't hurt and it is potentially useful to the application to
> know that things will be converted up by the hardware; unless there's a
> great reason to do so I'd rather not hide the information.

I can only speak in behalf of OMAP, twl4030, tlv320dac33 here, but the
24msbit only applies to 32bit samples. In case of 16 bit the samples are
not converted in any way, they are processed as 16 bit data.
So if we say 24msbit for 16bit sample we are not correct. It is correct
for 32bit sample.
I would think most of the codecs/cpus are working in a same way.

-- =

P=E9ter
