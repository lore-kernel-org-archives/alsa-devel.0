From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 20/21] ASoC: codecs: Enable AB8500 CODEC for Device Tree
Date: Thu, 26 Jul 2012 15:15:01 +0100
Message-ID: <501150E5.6010503@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org> <1343298534-13611-21-git-send-email-lee.jones@linaro.org> <20120726115055.GD3099@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120726115055.GD3099@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, sameo@linux.intel.com, olalilja@yahoo.se, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Sorry missed this:

>>   	{
>>   		.name =3D "ab8500-codec",
>> +		.of_compatible =3D "stericsson,ab8500-codec",
>>   	},
>
> Why are we doing this?  The MFD cells are a totally Linux specific
> thing, there's no reason to represent them in the device tree unless
> they're in some way reusable and the "ab8500-codec" name suggests tha=
t's
> unlikely.  Just put the properties on the parent node and instantiate
> the MFD cell as normal.

We have all of the AB8500 devices into the Device Tree to accurately=20
represent the hardware. We will also be passing configuration=20
information into the AB8500 Codec from Device Tree. The only reason=20
we're still registering them using the MFD API is to overcome addressin=
g=20
issues encountered earlier. Each 'device' still belongs in the 'device'=
=20
tree.

If we were to take this Device Tree and use it on something non-Linux,=20
that OS will still need to know about each of the AB8500 devices and=20
every associated configuration option. Only in Linux do we continue to=20
register them though a different API, which doesn't affect any other OS=
=2E

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
