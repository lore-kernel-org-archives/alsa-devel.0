From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5] ASoC: Apply msbits constraint for
 sample size bigger than the msbits
Date: Thu, 19 Jan 2012 13:40:35 +0100
Message-ID: <4F180F43.40706@ti.com>
References: <1326899114-26979-1-git-send-email-peter.ujfalusi@ti.com>
	<20120118152905.GP8732@opensource.wolfsonmicro.com>
	<4F16F6B0.7030707@ti.com>
	<20120118174648.GQ8732@opensource.wolfsonmicro.com>
	<4F17D3F5.3020901@ti.com>
	<20120119104800.GC3178@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog114.obsmtp.com (na3sys009aog114.obsmtp.com
	[74.125.149.211])
	by alsa0.perex.cz (Postfix) with ESMTP id BE881103BF6
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 13:40:40 +0100 (CET)
Received: by mail-gy0-f171.google.com with SMTP id g18so90989910ghb.30
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 04:40:38 -0800 (PST)
In-Reply-To: <20120119104800.GC3178@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 01/19/2012 11:48 AM, Mark Brown wrote:
> On Thu, Jan 19, 2012 at 09:27:33AM +0100, Peter Ujfalusi wrote:
> =

>> Are you going to take the for version of patch, or should I resend it?
>> I can add a comment to explain that we bail out, and not checking the
>> sample sizes lower than the requested msbits, if it helps.
> =

> I'd just replace it with a continue on sizes we don't want, much
> simpler.

If I can do this (bits =3D=3D 24):
i =3D 0
check (i < ARRAY_SIZE(sample_sizes))
check (sample_sizes[i] <=3D bits)
 apply constraint
i++
check (i < ARRAY_SIZE(sample_sizes))
check (sample_sizes[i] <=3D bits)
 go out

--------------------------------------
I will not do this (bits =3D=3D 24):
static int sample_sizes[] =3D {
	8, 16, 24, 32,
};

i =3D 0
check (i < ARRAY_SIZE(sample_sizes))
check (sample_sizes[i] > bits)
i++
check (i < ARRAY_SIZE(sample_sizes))
check (sample_sizes[i] > bits)
i++
check (i < ARRAY_SIZE(sample_sizes))
check (sample_sizes[i] > bits)
i++
check (i < ARRAY_SIZE(sample_sizes))
check (sample_sizes[i] > bits)
 apply constraint
i++
check (i < ARRAY_SIZE(sample_sizes))
 go out

--------------------------------------
nor this (bits =3D=3D 24):
static int sample_sizes[] =3D {
	32, 24, 16, 8,
};

i =3D 0
check (i < ARRAY_SIZE(sample_sizes))
check (sample_sizes[i] <=3D bits)
 apply constraint
i++
check (i < ARRAY_SIZE(sample_sizes))
check (sample_sizes[i] <=3D bits)
i++
check (i < ARRAY_SIZE(sample_sizes))
check (sample_sizes[i] <=3D bits)
i++
check (i < ARRAY_SIZE(sample_sizes))
check (sample_sizes[i] <=3D bits)
i++
check (i < ARRAY_SIZE(sample_sizes))
 go out

-- =

P=E9ter
