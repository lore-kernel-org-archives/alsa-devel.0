From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Allow complete
 shutdown of McASP when not in use
Date: Wed, 4 Mar 2015 12:12:36 +0200
Message-ID: <54F6DA94.2000702@ti.com>
References: <1425392792-12659-1-git-send-email-peter.ujfalusi@ti.com>
 <20150303150742.GZ21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id B4E27264EFF
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 11:12:39 +0100 (CET)
In-Reply-To: <20150303150742.GZ21293@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

On 03/03/2015 05:07 PM, Mark Brown wrote:
> On Tue, Mar 03, 2015 at 04:26:32PM +0200, Peter Ujfalusi wrote:
> =

>> @@ -553,6 +554,7 @@ static int __davinci_mcasp_set_clkdiv(struct snd_soc=
_dai *dai, int div_id,
>>  		return -EINVAL;
>>  	}
>>  =

>> +	pm_runtime_put_sync(mcasp->dev);
> =

> Why the _put_sync()s?  I know it's more symmetrical but I don't see a
> need to wait and it means we may be able to avoid some unneeded power
> cycles.

True, the _sync can be dropped. I guess I used it just for symmetry ;)

> =

>> @@ -1078,6 +1082,9 @@ static int davinci_mcasp_suspend(struct snd_soc_da=
i *dai)
>>  	u32 reg;
>>  	int i;
>>  =

>> +	if (!dai->active)
>> +		pm_runtime_get_sync(mcasp->dev);
>> +
>>  	for (i =3D 0; i < ARRAY_SIZE(context_regs); i++)
>>  		context->config_regs[i] =3D mcasp_get_reg(mcasp, context_regs[i]);
>>  =

>> @@ -1094,6 +1101,8 @@ static int davinci_mcasp_suspend(struct snd_soc_da=
i *dai)
>>  		context->xrsr_regs[i] =3D mcasp_get_reg(mcasp,
>>  						DAVINCI_MCASP_XRSRCTL_REG(i));
>>  =

>> +	pm_runtime_put_sync(mcasp->dev);
>> +
> =

> On first glance this looks unbalanced without the active check in the
> put case.  I'd also need to check if runtime resume works OK in suspend
> context, I guess it must but there were issues in the past (the more
> common idiom is to not suspend if we're already runtime powered down but
> obviously here we're actually doing extra work).

McASP is only going to loose it's context when the whole device goes to
suspend. In this case I need to save the registers which I need to restore =
in
resume time.

> I see there's actually a balanced put in the resume path...  I see
> what's going on here but I'm thinking that perhaps something more
> explicit that calls the ops directly and checks pm_runtime_is_enabled()
> might be clearer?

The issue with the pm_runtime_is_enabled() is going to be in the resume pat=
h,
as I did get_sync() it will return true at the end all the time.

In order to save/restore McASP register the IP need to be enabled.

-If we suspend/resume while no audio was running:
dai->active is false, pm_runtime is disabled when the davinci_mcasp_suspend=
()
is called. So I need to get_sync(), save context and put_sync() so we are in
balance.
In resume, dai->active is false, pm_runtime is disabled, so I again need to
get_sync(), restore registers and put_sync() so we are in balance again and
mcasp stay disabled.

-If we suspend/resume while audio was running:
dai->active is true, pm_runtime is enabled when the davinci_mcasp_suspend()=
 is
called. I don't need the get_sync(), save context and put_sync() so I relea=
se
all the resources needed for McASP. runtime_pm will be disabled.
In resume dai->active is true, pm_runtime is disabled. I need to get_sync(),
restore registers and since dai->active is true I should not put_sync() to
keep McASP enabled and be able to resume the audio.

I think this hassle is needed if I want to achieve what subject describes.

> Unconditionally do the power down/up at the end with
> a direct call outside of runtime PM and then make the checks at the
> top/bottom be "if it's runtime suspended then...".  That's also more
> direct about what's actually being checked and hence less risk that some
> future changes would go wrong.
> =



-- =

P=E9ter
