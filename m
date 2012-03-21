From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
	protection mode
Date: Wed, 21 Mar 2012 10:03:34 +0200
Message-ID: <4F698B56.6030502@ti.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
	<4F68AE51.808@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from psmtp.com (na3sys009aog131.obsmtp.com [74.125.149.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 1723E1043E2
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 09:03:44 +0100 (CET)
Received: by mail-lb0-f171.google.com with SMTP id ge1so730886lbb.30
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 01:03:37 -0700 (PDT)
In-Reply-To: <4F68AE51.808@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/20/2012 06:20 PM, Jarkko Nikula wrote:
> On 03/20/2012 01:13 PM, Peter Ujfalusi wrote:
>> Certain application can experience underrun right after the playback sta=
rt.
>> This is caused by the McBSP FIFO/sDMA integration:
>> The sDMA will push samples to the FIFO till it has threshold amount of f=
ree
>> slots available in the FIFO. If the application picks period size which =
is
>> smaller than the FIFO size, and it did not prepared multiple periods, or
>> it did not set the start_threshold for the stream to cover the FIFO size
>> the hw pointer will move forward, which is causing the underrun.
>>
>> Add a sysfs entry for McBSP ports: period_protection.
>> If this property is set the driver will place the constraint agains the
>> period size, and not for the buffer size. To ensure that we do not hit
>> underrun, the period size constraint will be increased with the requested
>> number of frames (the period size will be FIFO size + period_protection).
>>
>> As default the period_protection is disabled.
>>
> I don't think this is going to solve the actual problem here where
> custom asound.conf was required.

I also suggested to use custom asound.conf. For Pandora it does exist,
but the argument was that it need to be specifically created/copied to
any new OS being ported to the HW.

> IMHO custom sysfs is even worse option and very hard to remove afterwards.

Well, for system integration's point of view I would prefer the sysfs
file. If this is needed by the distribution/use case it can be enabled,
disabled in runtime. In my view it poses less hassle for distributions.

> And defaulting this new setting for Pandora might break e.g. MER or MeeGo=
 on N900.

I would not default this behavior for the exact same reasons. It was
planed to be optional.

> I didn't check this but would it be possible to either put restriction
> to start-delay (I think Grazvydas said he has experimental code for
> that?) or make sure that minimum buffer size must be higher than FIFO +
> 1 period (or something like that)?

The start_threshold is sw_param, driver should not touch it. In fact it
is way above the driver layer.

-- =

P=E9ter
