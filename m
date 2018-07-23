From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH] ASoC: AMD: Add a fix voltage regulator for
 DA7219 and ADAU7002
Date: Mon, 23 Jul 2018 10:56:44 +0530
Message-ID: <50343cff-bad4-7677-851f-f0b818ae7b29@amd.com>
References: <1532068715-2992-1-git-send-email-akshu.agrawal@amd.com>
 <20180720121816.GD10784@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680051.outbound.protection.outlook.com [40.107.68.51])
 by alsa0.perex.cz (Postfix) with ESMTP id E09DA26763C
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2018 07:27:12 +0200 (CEST)
In-Reply-To: <20180720121816.GD10784@sirena.org.uk>
Content-Language: en-US
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
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, djkurtz@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org



On 7/20/2018 5:48 PM, Mark Brown wrote:
> On Fri, Jul 20, 2018 at 02:38:11PM +0800, Akshu Agrawal wrote:
> =

>>  static int cz_probe(struct platform_device *pdev)
>>  {
>>  	int ret;
>>  	struct snd_soc_card *card;
>>  	struct acp_platform_info *machine;
>> +	static bool regulators_registered;
>> +
>> +	if (!regulators_registered) {
>> +		ret =3D platform_device_register(&acp_da7219_regulator);
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "Failed to register regulator: %d\n",
>> +				ret);
>> +			return ret;
>> +		}
>> +		regulators_registered =3D true;
>> +	}
> =

> You should be unregistering the regulator in your remove function, not
> doing this hack here.  I'd also expect to see the card made the parent
> of the device that gets registered.
> =


This approach shows inconsistencies and in some boot cycles da7219 fails
to get regulator. Form the logs (below) it shows time gap between the
time we call =93platform_device_register(&acp_da7219_regulator);=94 and when
the regulator actually gets registered.

[   12.594237] regulator registered
**print after calling =93platform_device_register(&acp_da7219_regulator);=
=94
...
[   13.583689] da7219 i2c-DLGS7219:00: i2c-DLGS7219:00 supply VDD not
found, using dummy regulator
[   13.593818] da7219 i2c-DLGS7219:00: i2c-DLGS7219:00 supply VDDMIC not
found, using dummy regulator
[   13.603242] da7219 i2c-DLGS7219:00: i2c-DLGS7219:00 supply VDDIO not
found, using dummy regulator
[   13.612626] da7219 i2c-DLGS7219:00: Invalid VDDIO voltage
**Above DA7219 gets probed and does not find the regulator**
...
[   13.750894] reg_fixed_voltage_probe: Supply -> reg-fixed-1.8V
[   13.766746] reg-fixed-1.8V supplying 1800000uV
**Regulator actually gets registered**

Alternate and consistent approach to this is pushed by Daniel here:
https://patchwork.kernel.org/patch/10539485/

Thanks,
Akshu
