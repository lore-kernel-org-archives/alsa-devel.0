From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ASoC: Allow drivers to specify how
 many bits are significant on a DAI
Date: Tue, 17 Jan 2012 15:18:35 +0100
Message-ID: <4F15833B.2000808@ti.com>
References: <1326739267-9678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F15377B.6080108@ti.com>
	<20120117113848.GE2944@opensource.wolfsonmicro.com>
	<4F157264.5020102@ti.com>
	<20120117131950.GF2944@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog109.obsmtp.com (na3sys009aog109.obsmtp.com
	[74.125.149.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 6155524616
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 15:18:54 +0100 (CET)
Received: by mail-gy0-f173.google.com with SMTP id g20so1023080ghb.32
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 06:18:38 -0800 (PST)
In-Reply-To: <20120117131950.GF2944@opensource.wolfsonmicro.com>
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

On 01/17/2012 02:19 PM, Mark Brown wrote:
> For the CODECs if you look at what they're doing you'll probably find
> that the device is actually operating at a fixed sample size internally
> and converting the data somehow at the interface (zero extension being
> one option when converting up, but more fancy approaches are also
> possible).  This is fairly obvious when you think about how things are
> likely to be implemented in hardware, it's going to increase complexity
> a lot to be able to genuinely switch the entire chip from one sample
> size to another.

It is mostly true. DAC33 can be configured to operate internally 16bit
or 24msbit/32bit for example.
But none of this matters really for application. If the codec works
internally with 32/64 or whatever, it does not matter for the
application. What matters is that if it sends data in 32bit only 24msb
will be actually going to be taken, and the rest will be ignored at the
interface level. What happens within the codec is out of the scope.
Applications like PulseAudio can do digital volume control. For them it
is important to know if they can operate on the full 32 bit, or only the
24msbit will be taken into account by the HW at interface level.
It does not give any useful information for application that the codec
will upsample the 16bit data internally to 24 bits. It does not really
matter for them since all 16bit data will be used by the codec.

> On the CPU side specifying significant bits would normally only be
> appropriate on PDM interfaces as they have most of a DAC or ADC in them
> to move between the sampled and PDM formats.  I'd be surprised to see
> anything else setting these flags, most of the hardware is just passing
> the data straight through.

True, the CPU side mostly passes the data as it is, it does not care
about msbits. For McPDM it is different since the internal FIFO in 24bit
long word lines, so if application would use all 32bit we it will loose
8bit lsb. This can make difference for PA when applying the digital gain
in SW.

-- =

P=E9ter
