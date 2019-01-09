From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 08/14] ASoC: SOF: Add DSP HW abstraction
 operations
Date: Wed, 9 Jan 2019 15:37:26 -0600
Message-ID: <739d6933-0846-49c2-aa85-c3e869521881@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-9-pierre-louis.bossart@linux.intel.com>
 <20190109205129.GS10405@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190109205129.GS10405@sirena.org.uk>
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


On 1/9/19 2:51 PM, Mark Brown wrote:
> On Tue, Dec 11, 2018 at 03:23:12PM -0600, Pierre-Louis Bossart wrote:
>
>> +int snd_sof_pci_update_bits_unlocked(struct snd_sof_dev *sdev, u32 offs=
et,
>> +				     u32 mask, u32 value)
>> +{
>> +	bool change;
>> +	unsigned int old, new;
>> +	u32 ret =3D ~0; /* explicit init to remove uninitialized use warnings =
*/
> This looks a lot like you want to write regmap_pci_config...

I think you made that note for the v2 a long time ago, not sure if I =

replied at the time.

We only use this for 4 cases (power/clock gating on/off, traffic class, =

etc) and only during the hardware initialization. This is similar to the =

legacy and Skylake driver, I don't see a significant benefit with a regmap?

intel/hda-ctrl.c:=A0=A0=A0=A0=A0=A0 snd_sof_pci_update_bits(sdev, PCI_CGCTL=
, =

PCI_CGCTL_MISCBDCGE_MASK, val);
intel/hda-ctrl.c:=A0=A0=A0=A0=A0=A0 snd_sof_pci_update_bits(sdev, PCI_CGCTL=
, =

PCI_CGCTL_ADSPDCGE, val);
intel/hda-ctrl.c:=A0=A0=A0=A0=A0=A0 snd_sof_pci_update_bits(sdev, PCI_PGCTL=
, =

PCI_PGCTL_ADSPPGD, val);
intel/hda-dsp.c:=A0=A0=A0=A0=A0=A0=A0 snd_sof_pci_update_bits(sdev, PCI_PGC=
TL,
intel/hda-dsp.c:=A0=A0=A0=A0=A0=A0=A0 snd_sof_pci_update_bits(sdev, PCI_TCS=
EL, 0x07, 0);

>
>> +/* control */
>> +static inline int snd_sof_dsp_run(struct snd_sof_dev *sdev)
>> +{
>> +	if (sdev->ops->run)
>> +		return sdev->ops->run(sdev);
>> +
>> +	return 0;
>> +}
> Do we really want to return 0 for all these ops if they're not
> implemented?  For some that seems sensible but there's others where it
> seems like the caller might want to know they got ignored and an error
> code like -ENOTSUPP might be better.
Good point indeed. There are a set of ops that are really mandatory, we =

should rework this instead. Thanks for the comment.
