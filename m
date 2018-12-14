From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC 2/2] ASoC: Add MICFIL SoC Digital Audio
 Interface driver.
Date: Fri, 14 Dec 2018 14:09:00 -0600
Message-ID: <f3a0f305-dc96-f8b9-3c57-e45256326e2f@linux.intel.com>
References: <1544433661-32496-1-git-send-email-cosmin.samoila@nxp.com>
 <1544433661-32496-3-git-send-email-cosmin.samoila@nxp.com>
 <20181212181414.GE6920@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id DA08826798A
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 21:09:03 +0100 (CET)
In-Reply-To: <20181212181414.GE6920@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Cosmin Samoila <cosmin.samoila@nxp.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "robh@kernel.org" <robh@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, "gabrielcsmo@gmail.com" <gabrielcsmo@gmail.com>
List-Id: alsa-devel@alsa-project.org


On 12/12/18 12:14 PM, Mark Brown wrote:
>> +static irqreturn_t voice_detected_fn(int irq, void *devid)
>> +{
>> +	struct fsl_micfil *micfil = (struct fsl_micfil *)devid;
>> +	struct device *dev = &micfil->pdev->dev;
>> +	int ret;
>> +
>> +	/* disable hwvad */
>> +	ret = disable_hwvad(dev, true);
>> +	if (ret)
>> +		dev_err(dev, "Failed to disable HWVAD module\n");
>> +
>> +	/* notify userspace that voice was detected */
>> +	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
>> +
>> +	return IRQ_HANDLED;
>> +}
> So, this looks like it's intended to be used for keyword detection type
> applications (though without the offload DSP that those tend to have).
> What the other implementations I've seen have ended up doing is using a
> compressed audio stream to return the audio data to userspace, allowing
> the audion stream to be paused when no audio is detected.  Your approach
> here is a bit more manual and may be more sensible for systems without
> the offload DSP however the decision to go outside ALSA and use a
> kobject needs to be thought about a bit, we'd want to ensure that
> there's a standard way of handling hardware like this so applications
> can work as consistently as possible with them.

There's no mention of any buffer so it's likely plain vanilla VAD here. 
We've seen two choices to warn userspace of a acoustic event, either use 
a uevent or a kcontrol. I believe we ended-up chosing the latter on the 
Intel side in the past and that was also the plan for SOF.

In terms of configurations for the PDM we have completely different 
settings since we pass explicit coefficients while this solution passes 
qualifiers (cut-off, quality, etc), not sure if there is any point in 
trying to unify those parameters.
