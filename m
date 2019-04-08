From: Jan Kotas <jank@cadence.com>
Subject: Re: [PATCH] soundwire: fix pm_runtime_get_sync return code checks
Date: Mon, 8 Apr 2019 07:12:03 +0000
Message-ID: <92538D7E-C628-40AC-AFE9-52C97B3BC42D@global.cadence.com>
References: <20190405072655.25995-1-jank@cadence.com>
 <367316fa-9d92-2dfc-32c4-3e0e8c76ef43@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <367316fa-9d92-2dfc-32c4-3e0e8c76ef43@linux.intel.com>
Content-Language: en-US
Content-ID: <D0FA97D6FAC454499E72DEAB5204999D@namprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jan Kotas <jank@cadence.com>, "vkoul@kernel.org" <vkoul@kernel.org>, "sanyog.r.kale@intel.com" <sanyog.r.kale@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org



> On 5 Apr 2019, at 17:04, Pierre-Louis Bossart <pierre-louis.bossart@linux=
.intel.com> wrote:
>=20
> On 4/5/19 2:26 AM, Jan Kotas wrote:
>>=20
>> =20
>>  	ret =3D pm_runtime_get_sync(slave->bus->dev);
>> -	if (ret < 0)
>> +	if (ret < 0 && ret !=3D -EACCES)
>>=20
> There was a patch submitted on 3/28 by Srinivas Kandagatla who suggested =
an alternate solution for exactly the same code.
>=20
> +	if (pm_runtime_enabled(slave->bus->dev)) {
> +		ret =3D pm_runtime_get_sync(slave->bus->dev);
> +		if (ret < 0)
> +			return ret;
>=20
> I am far from an expert on pm_runtime but Srinivas' solution looks more e=
legant to me.

Hello Pierre,

Please take a look at this patch, that was my inspiration:
https://lists.linuxfoundation.org/pipermail/linux-pm/2011-June/031930.html

I also took a look, and it seems the value returned by=20
pm_runtime_get_syncis simply ignored in a lot of places,=20
so checking its value may be excessive.

Regards,
Jan=
