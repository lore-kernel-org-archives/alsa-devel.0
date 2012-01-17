From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ASoC: Allow drivers to specify how
 many bits are significant on a DAI
Date: Tue, 17 Jan 2012 18:55:29 +0100
Message-ID: <4F15B611.2080808@ti.com>
References: <1326739267-9678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F15377B.6080108@ti.com>
	<20120117113848.GE2944@opensource.wolfsonmicro.com>
	<4F157264.5020102@ti.com>
	<20120117131950.GF2944@opensource.wolfsonmicro.com>
	<4F15833B.2000808@ti.com>
	<20120117145646.GG2944@opensource.wolfsonmicro.com>
	<4F159CE2.4090306@ti.com>
	<20120117164452.GJ2944@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog121.obsmtp.com (na3sys009aog121.obsmtp.com
	[74.125.149.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 5078F103A4A
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 18:55:35 +0100 (CET)
Received: by mail-gy0-f170.google.com with SMTP id r13so429924ghr.15
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 09:55:32 -0800 (PST)
In-Reply-To: <20120117164452.GJ2944@opensource.wolfsonmicro.com>
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

On 01/17/2012 05:44 PM, Mark Brown wrote:
>> Sure it might be good to know, but it is something we do not have
>> control over. There's a datasheet if someone is interested.
> =

> The datasheet isn't terribly machine parseable.

True, and the information that the chip internally works in 24 bit mode
is irrelevant. Why would any application care when it plays 16bit sample
that the HW will internally convert it to 24 bit?

>> Even if you could select the algorithm for the in HW resampling it could
>> be configured via kcontrol, or via qos.
>> For application it does not matter.
> =

> I don't recall suggesting configuring the hardware algorithm here?

For what other reason application would use the fact that the 16bit
sample will converted to 24bit by the HW other that you might want to
influence the algorithm used by the HW when it does it?

>> This is not a point. If it does it's internal digital volume on the full
>> 32bit resolution from which the HW just discards 8bits we will loose
>> resolution. If PA knows that out of the 32bit only the 24bit msbit is
>> going to be used it can apply the gain correctly.
> =

> This isn't a correctness thing really, it's just that it's doing more
> work than it needs to because nothing is going to pay attention to the
> the lower bits it outputs.  A gain applied with 24 bits just has an
> output with a bit less resolution than one applied with 32 bits but it
> shouldn't be substantially different.

Yeah, but it is not correct. If it does not know this we have 8bit
'latency' in gain control. Pulse can change the gain which will have no
effect.
But I'm not arguing against the constraint on the 32bit sample for
24msbits...

>> If we tell PA that the codec internally works in 24bit, and we play
>> 16bit audio (in 16bit mode) PA needs to apply the gain in 16bit
>> resolution. The information about the codec working internally in 24bit
>> irrelevant.
> =

> I can't think why Pulse might want to use it.  On the other hand it's
> not going to hurt to tell it.

If you look at this:
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 24
  buffer_size  : 24000
  period_size  : 6000
  period_time  : 125000

It just does not feel right.
What if application takes this literally, goes and applies the digital
gain on a 16bit sample with 24bit resolution?
I know the application need to be fixed, but no application expect to be
told that out of the 16bit they can use 24bit..

I'm not convinced that this is a good idea. We should apply the
constraints on the sample size where it actually make sense.
IMHO.

-- =

P=E9ter
