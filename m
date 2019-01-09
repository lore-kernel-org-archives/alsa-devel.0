From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 09/14] ASoC: SOF: Add firmware loader
 support
Date: Wed, 9 Jan 2019 15:24:43 -0600
Message-ID: <271a3645-b6d0-4be3-ff78-94a8f1271c54@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-10-pierre-louis.bossart@linux.intel.com>
 <20190109210233.GU10405@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190109210233.GU10405@sirena.org.uk>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Thanks for the reviews Mark, much appreciated.

+int snd_sof_load_firmware_memcpy(struct snd_sof_dev *sdev)
>> +{
>> +	struct snd_sof_pdata *plat_data =3D dev_get_platdata(sdev->dev);
>> +	const char *fw_filename;
>> +	int ret;
> This never actually calls the load_firmware() operation for the DSP
> AFAICT?

it's actually the implementation of the load_firmware callback, see e.g. =

for Baytrail/Broadwell

/*Firmware loading */
 =A0=A0=A0 .load_firmware=A0=A0=A0 =3D snd_sof_load_firmware_memcpy,

>
>> +	ret =3D request_firmware(&plat_data->fw, fw_filename, sdev->dev);
>> +
>> +	if (ret < 0) {
>> +		dev_err(sdev->dev, "error: request firmware failed err: %d\n",
>> +			ret);
>> +		return ret;
>> +	}
> I'd suggest logging the name of the firmware we tried to load, users
> will thank you.
yes indeed, thanks for the suggestion, will add this right away.
>
>> +	/* create fw_version debugfs to store boot version info */
>> +	if (sdev->first_boot) {
>> +		ret =3D snd_sof_debugfs_buf_create_item(sdev, &sdev->fw_version,
>> +						      sizeof(sdev->fw_version),
>> +						      "fw_version");
>> +
>> +		if (ret < 0) {
>> +			dev_err(sdev->dev, "error: cannot create debugfs for fw_version\n");
>> +			return ret;
>> +		}
>> +	}
> As Andy said elsewhere debugfs stuff like that probably shouldn't be
> fatal.
yes, we've fixed this already.
