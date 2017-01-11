From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH v3 1/2] ASoC: core: Add API to use DMI name
 in sound card long name
Date: Wed, 11 Jan 2017 14:32:11 +0800
Message-ID: <5875D16B.8040002@linux.intel.com>
References: <cover.1484030246.git.mengdong.lin@linux.intel.com>
 <2c6136c012b7f94dd2fb35fd5def8195abdc0113.1484030246.git.mengdong.lin@linux.intel.com>
 <s5h8tqjmlvc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F4F32669B2
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2017 07:29:03 +0100 (CET)
In-Reply-To: <s5h8tqjmlvc.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org


On 01/10/2017 03:09 PM, Takashi Iwai wrote:
> On Tue, 10 Jan 2017 07:42:49 +0100,
> mengdong.lin@linux.intel.com wrote:
>>
>> +/**
>> + * snd_soc_set_dmi_name() - Register DMI names to card
>> + * @card: The card to register DMI names
>> + * @flavour: The flavour "differentiator" for the card amongst its peers.
>> + *
>> + * An Intel machine driver may be used by many different devices but are
>> + * difficult for userspace to differentiate, since machine drivers ususally
>> + * use their own name as the card name (short name) and leave the card long
>> + * name blank. To differentiate such devices and fix bugs due to lack of
>> + * device-specific configurations, this function allows DMI info to be used
>> + * as the sound card long name, in the format of
>> + * "vendor.product.version.board"
>> + * (Character '.' are used to separate different DMI fields here).
>> + * This will help the userspace to load the correct UCM (Use Case Manager)
>> + * configuration.
>> + *
>> + * Possible card long names may be:
>> + * DellInc..XPS139343.01.0310JH
>> + * ASUSTeKCOMPUTERINC..T100TA.1.0.T100TA
>> + * Circuitco.MinnowboardMaxD0PLATFORM.D0.MinnowBoardMAX
>> + * (Please note DMI can also include '.' like"Inc." so you may see double '.
> '
>> + * sometimes)
>
> Looking at the examples above, I wonder whether the dot is the best
> choice as the separator.  Might other letters (e.g. ":" or "=") would
> be clearer?  The colon might be bad if it were combined with the
> alsa-lib plugin syntax, but I guess it won't happen?
>

Hi Takashi,

I found we cannot use ":" as separator. It's because we want to use the 
card long name as the name of the directory to store UCM configuration 
files for this card, and Autoconf cannot support ":" in the directory name.

Both "=" and "-" can work, which would you suggest to use?
I've not observed "-" or "=" in DMI fields till now, and I guess "=" is 
less likely to be used by vendors.

Thanks
Mengdong
