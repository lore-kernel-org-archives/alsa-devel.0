From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 02/14] ASoC: SOF: Add Sound Open
 Firmware KControl support
Date: Wed, 12 Dec 2018 09:01:25 -0600
Message-ID: <e352861d-b34d-9ad2-ae16-6e51a52ce3d5@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-3-pierre-louis.bossart@linux.intel.com>
 <s5hftv3urib.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hftv3urib.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


On 12/12/18 1:35 AM, Takashi Iwai wrote:
> On Tue, 11 Dec 2018 22:23:06 +0100,
> Pierre-Louis Bossart wrote:
>> +int snd_sof_enum_get(struct snd_kcontrol *kcontrol,
>> +		     struct snd_ctl_elem_value *ucontrol)
>> +{
> ....
>> +	/* read back each channel */
>> +	for (i = 0; i < channels; i++)
>> +		ucontrol->value.integer.value[i] = cdata->chanv[i].value;
> enum type needs to access ucontrol->value.enumerated.item[i].
> This has a different size, hence using integer.value[] would be broken
> on BE archs.
oops. likely a copy/paste...
>
>> +int snd_sof_enum_put(struct snd_kcontrol *kcontrol,
>> +		     struct snd_ctl_elem_value *ucontrol)
>> +{
> ....
>> +	/* update each channel */
>> +	for (i = 0; i < channels; i++)
>> +		cdata->chanv[i].value = ucontrol->value.integer.value[i];
> Ditto.
same here
>
>> +int snd_sof_bytes_get(struct snd_kcontrol *kcontrol,
>> +		      struct snd_ctl_elem_value *ucontrol)
>> +{
> ....
>> +	size = data->size + sizeof(*data);
>> +	if (size > be->max) {
>> +		dev_err(sdev->dev, "error: DSP sent %zu bytes max is %d\n",
>> +			size, be->max);
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	/* copy back to kcontrol */
>> +	memcpy(ucontrol->value.bytes.data, data, size);
> I *hope* that the data size max was already examined not to exceed
> ucontrol data array size beforehand.  But a sanity check to catch a
> buffer overflow here won't hurt.
> Ditto for *_put().
i think we do just that in the 'if' case just above the memcpy, but 
we'll double-check.
>
>> +int snd_sof_bytes_ext_put(struct snd_kcontrol *kcontrol,
>> +			  const unsigned int __user *binary_data,
>> +			  unsigned int size)
>> +{
>> +	struct soc_bytes_ext *be =
>> +		(struct soc_bytes_ext *)kcontrol->private_value;
>> +	struct snd_sof_control *scontrol = be->dobj.private;
>> +	struct snd_sof_dev *sdev = scontrol->sdev;
>> +	struct sof_ipc_ctrl_data *cdata = scontrol->control_data;
>> +	struct snd_ctl_tlv header;
>> +	struct snd_ctl_tlv __user *tlvd =
>> +		(struct snd_ctl_tlv __user *)binary_data;
> Don't drop const.

Ah, I added this cast to make a sparse warning go away, not sure why the 
const was removed.

I'll double-check again, thanks.

>
>> +	int ret;
>> +	int err;
>> +	int max_size = SOF_IPC_MSG_MAX_SIZE -
>> +		sizeof(const struct sof_ipc_ctrl_data);
>> +
>> +	ret = pm_runtime_get_sync(sdev->dev);
>> +	if (ret < 0) {
>> +		dev_err(sdev->dev, "error: bytes_ext put failed to resume %d\n",
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	/* The beginning of bytes data contains a header from where
>> +	 * the length (as bytes) is needed to know the correct copy
>> +	 * length of data from tlvd->tlv.
>> +	 */
>> +	if (copy_from_user(&header, tlvd, sizeof(const struct snd_ctl_tlv))) {
>> +		ret = -EFAULT;
>> +		goto out;
>> +	}
>> +	/* The maximum length that can be copied is limited by IPC max
>> +	 * length and topology defined length for ext bytes control.
>> +	 */
>> +	max_size = (be->max < max_size) ? be->max : max_size;
>> +	if (header.length > max_size) {
>> +		dev_err(sdev->dev, "error: Bytes data size %d exceeds max %d.\n",
>> +			header.length, max_size);
>> +		ret = -EINVAL;
>> +		goto out;
> Here user can pass a malicious data, and printing the error at each
> time would flood the kernel log.  The error message can be dropped or
> make debug, or use ratelimited version.
> Ditto for the rest checks.
Good point, we'll fix this.
