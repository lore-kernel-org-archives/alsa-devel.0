From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH 00/12] ASoC: intel: add device_link to HDMI
	audio
Date: Thu, 11 Apr 2019 12:24:13 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D195281880C@SHSMSX103.ccr.corp.intel.com>
References: <1554975299-25343-1-git-send-email-libin.yang@intel.com>
 <s5hftqosvix.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A4E1DF80716
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2019 14:24:17 +0200 (CEST)
In-Reply-To: <s5hftqosvix.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Thursday, April 11, 2019 6:10 PM
>To: Yang, Libin <libin.yang@intel.com>
>Cc: alsa-devel@alsa-project.org; broonie@kernel.org; pierre-
>louis.bossart@linux.intel.com
>Subject: Re: [PATCH 00/12] ASoC: intel: add device_link to HDMI audio
>
>On Thu, 11 Apr 2019 11:34:47 +0200,
>libin.yang@intel.com wrote:
>>
>> From: Libin Yang <libin.yang@intel.com>
>>
>> This patchset add the device_link between the machine devices of intel
>> boards and HDMI audio codec. This can make sure that display audio
>> power domain is always turned on before operating on the HDMI audio
>> codecs.
>>
>> patch 2 adds the helper functions in a new created header file.
>> However skl_hda_dsp_generic doesn't use these helper functions because
>> skl_hda_dsp_generic is a special driver, the add link and delete link
>> operations are in different source code files.
>> If it includes the header file, there is compiling warning.
>
>Now I took a look at the core implementation, and wonder whether we may
>drop the device_link_del() call if we create the link with
>DL_FLAG_AUTOREMOVE_CONSUMER?  If that works, you don't have to track
>the link pointer, so it can be dropped as well; i.e. the only addition would be
>just the extra call of device_link_add() for each machine driver.

In the machine drivers, each dai_link will call device_link_add(). So I use
the link pointer to check whether it is already created or not to avoid
creating the link several times. Like the below code:
+       if (!(*link))
+               *link = device_link_add(consumer, supplier, DL_FLAG_RPM_ACTIVE);

Regards,
Libin

>
>
>thanks,
>
>Takashi
>
>>
>> Libin Yang (12):
>>   ASoC: intel: skl_hda_dsp_generic: add device_link to HDMI audio
>>   ASoC: intel: boards: define some general functions for hdac_hdmi
>>   ASoC: intel: bxt_da7219_max98357a: add device_link to HDMI audio
>>   ASoC: intel: bxt_rt298: add device_link to HDMI audio
>>   ASoC: intel: glk_rt5682_max98357a: add device_link to HDMI audio
>>   ASoC: intel: kbl_da7219_max98357a: add device_link to HDMI audio
>>   ASoC: intel: kbl_da7219_max98927: add device_link to HDMI audio
>>   ASoC: intel: kbl_rt5660: add device_link to HDMI audio
>>   ASoC: intel: kbl_rt5663_max98927 add device_link to HDMI audio
>>   ASoC: intel: kbl_rt5663_rt5514_max98927 add device_link to HDMI audio
>>   ASoC: intel: skl_nau88l25_max98357a add device_link to HDMI audio
>>   ASoC: intel: skl_nau88l25_ssm4567 add device_link to HDMI audio
>>
>>  sound/soc/intel/boards/bxt_da7219_max98357a.c      | 14 +++++++
>>  sound/soc/intel/boards/bxt_rt298.c                 | 14 ++++++-
>>  sound/soc/intel/boards/glk_rt5682_max98357a.c      | 14 +++++++
>>  sound/soc/intel/boards/hdac_hdmi_common.h          | 46
>++++++++++++++++++++++
>>  sound/soc/intel/boards/kbl_da7219_max98357a.c      | 14 +++++++
>>  sound/soc/intel/boards/kbl_da7219_max98927.c       | 14 +++++++
>>  sound/soc/intel/boards/kbl_rt5660.c                | 14 ++++++-
>>  sound/soc/intel/boards/kbl_rt5663_max98927.c       | 14 ++++++-
>>  .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 14 ++++++-
>>  sound/soc/intel/boards/skl_hda_dsp_common.c        | 22 +++++++++++
>>  sound/soc/intel/boards/skl_hda_dsp_common.h        |  1 +
>>  sound/soc/intel/boards/skl_hda_dsp_generic.c       | 12 ++++++
>>  sound/soc/intel/boards/skl_nau88l25_max98357a.c    | 36
>++++++++++++++++-
>>  sound/soc/intel/boards/skl_nau88l25_ssm4567.c      | 36
>++++++++++++++++-
>>  14 files changed, 259 insertions(+), 6 deletions(-)  create mode
>> 100644 sound/soc/intel/boards/hdac_hdmi_common.h
>>
>> --
>> 2.7.4
>>
