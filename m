From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ASoC: Allow drivers to specify how
 many bits are significant on a DAI
Date: Tue, 17 Jan 2012 17:08:02 +0100
Message-ID: <4F159CE2.4090306@ti.com>
References: <1326739267-9678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F15377B.6080108@ti.com>
	<20120117113848.GE2944@opensource.wolfsonmicro.com>
	<4F157264.5020102@ti.com>
	<20120117131950.GF2944@opensource.wolfsonmicro.com>
	<4F15833B.2000808@ti.com>
	<20120117145646.GG2944@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75]) by alsa0.perex.cz (Postfix) with ESMTP id F2466244A7
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 17:08:07 +0100 (CET)
Received: by mail-yx0-f174.google.com with SMTP id m6so276592yen.5
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 08:08:05 -0800 (PST)
In-Reply-To: <20120117145646.GG2944@opensource.wolfsonmicro.com>
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

On 01/17/2012 03:56 PM, Mark Brown wrote:
> On Tue, Jan 17, 2012 at 03:18:35PM +0100, Peter Ujfalusi wrote:
> =

>> It is mostly true. DAC33 can be configured to operate internally 16bit
>> or 24msbit/32bit for example.
> =

> Well, if it's doing something more complicated that doesn't fit in the
> framework then it shouldn't be doing that.

What do you mean? If user plays 16bit audio we configure the codec in
16bit mode. If it is opened in 24msbit/32 mode it is configured accordingly.

>> It does not give any useful information for application that the codec
>> will upsample the 16bit data internally to 24 bits. It does not really
>> matter for them since all 16bit data will be used by the codec.
> =

> Oh, I dunno - I'm sure someone could think of a use for it.

Sure it might be good to know, but it is something we do not have
control over. There's a datasheet if someone is interested.
Even if you could select the algorithm for the in HW resampling it could
be configured via kcontrol, or via qos.
For application it does not matter.

>> True, the CPU side mostly passes the data as it is, it does not care
>> about msbits. For McPDM it is different since the internal FIFO in 24bit
>> long word lines, so if application would use all 32bit we it will loose
> =

> Right, like I say that's because it's got most of a DAC in it.

The McPDM does not have codec, the internal FIFO has this layout which
dictates the 24msbit. It just cuts the 8lsb.

> =

>> 8bit lsb. This can make difference for PA when applying the digital gain
>> in SW.
> =

> Well, it saves it a bit of effort but that's about it.

This is not a point. If it does it's internal digital volume on the full
32bit resolution from which the HW just discards 8bits we will loose
resolution. If PA knows that out of the 32bit only the 24bit msbit is
going to be used it can apply the gain correctly.
If we tell PA that the codec internally works in 24bit, and we play
16bit audio (in 16bit mode) PA needs to apply the gain in 16bit
resolution. The information about the codec working internally in 24bit
irrelevant.

-- =

P=E9ter
