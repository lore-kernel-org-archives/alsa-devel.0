From: Jan Kotas <jank@cadence.com>
Subject: Re: [alsa-devel] [RFC PATCH 17/40] soundwire: bus: use
 runtime_pm_get_sync/pm when enabled
Date: Fri, 26 Jul 2019 07:47:04 +0000
Message-ID: <716D5D19-D494-4F4E-9180-24CB5A575648@global.cadence.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
 <20190726073931.GE16003@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190726073931.GE16003@ubuntu>
Content-Language: en-US
Content-ID: <D6BB97446A953042B06235D0B640B2C9@namprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Jan Kotas <jank@cadence.com>, "slawomir.blauciak@intel.com" <slawomir.blauciak@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I while back I proposed a patch for this, but it went nowhere.

https://patchwork.kernel.org/patch/10887405/
Maybe something similar can be implemented?

Jan

> On 26 Jul 2019, at 09:39, Guennadi Liakhovetski <guennadi.liakhovetski@li=
nux.intel.com> wrote:
>=20
> EXTERNAL MAIL
>=20
>=20
> Hi Pierre,
>=20
> I might be wrong but this doesn't seem right to me. (Supposedly) all RT-P=
M
> functions check for "enabled" internally. The only thing that can happen =
is
> that if RT-PM isn't enabled some of those functions will return an error.
> So, in those cases where the return value of RT-PM functions isn't checke=
d,
> I don't think you need to do anything. Where it is checked maybe do
>=20
> +	if (ret < 0 && pm_runtime_enabled(slave->bus->dev))
>=20
> Thanks
> Guennadi
>=20
> On Thu, Jul 25, 2019 at 06:40:09PM -0500, Pierre-Louis Bossart wrote:
>> Not all platforms support runtime_pm for now, let's use runtime_pm
>> only when enabled.
>>=20
>> Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.co=
m>
>> ---
>> drivers/soundwire/bus.c | 25 ++++++++++++++++---------
>> 1 file changed, 16 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
>> index 5ad4109dc72f..0a45dc5713df 100644
>> --- a/drivers/soundwire/bus.c
>> +++ b/drivers/soundwire/bus.c
>> @@ -332,12 +332,16 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, s=
ize_t count, u8 *val)
>> 	if (ret < 0)
>> 		return ret;
>>=20
>> -	ret =3D pm_runtime_get_sync(slave->bus->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	if (pm_runtime_enabled(slave->bus->dev)) {
>> +		ret =3D pm_runtime_get_sync(slave->bus->dev);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>>=20
>> 	ret =3D sdw_transfer(slave->bus, &msg);
>> -	pm_runtime_put(slave->bus->dev);
>> +
>> +	if (pm_runtime_enabled(slave->bus->dev))
>> +		pm_runtime_put(slave->bus->dev);
>>=20
>> 	return ret;
>> }
>> @@ -359,13 +363,16 @@ int sdw_nwrite(struct sdw_slave *slave, u32 addr, =
size_t count, u8 *val)
>> 			   slave->dev_num, SDW_MSG_FLAG_WRITE, val);
>> 	if (ret < 0)
>> 		return ret;
>> -
>> -	ret =3D pm_runtime_get_sync(slave->bus->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	if (pm_runtime_enabled(slave->bus->dev)) {
>> +		ret =3D pm_runtime_get_sync(slave->bus->dev);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>>=20
>> 	ret =3D sdw_transfer(slave->bus, &msg);
>> -	pm_runtime_put(slave->bus->dev);
>> +
>> +	if (pm_runtime_enabled(slave->bus->dev))
>> +		pm_runtime_put(slave->bus->dev);
>>=20
>> 	return ret;
>> }
>> --=20
>> 2.20.1
>>=20
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__mailman.alsa-2Dpr=
oject.org_mailman_listinfo_alsa-2Ddevel&d=3DDwIBAg&c=3DaUq983L2pue2FqKFoP6P=
GHMJQyoJ7kl3s3GZ-_haXqY&r=3Dg7GAQENVXx_RQdyXHInPMg&m=3DvETGQLSPeGb7K_ZsXv4T=
l3VFfdXzyummTDga97ozJcg&s=3DLiW4SToh5U0zhnkox54oRhJ1u3vFNbBB9nmzRDuCDjI&e=
=3D
