From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 0/5] ALSA/HDA: abort probe when DMICs
	are detected
Date: Wed, 31 Jul 2019 10:33:36 -0500
Message-ID: <ba35154d-5620-bb3e-40c8-ede417d98a2a@linux.intel.com>
References: <20190729155151.14055-1-pierre-louis.bossart@linux.intel.com>
 <s5hmuguqpjk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A75D3F80214
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2019 17:33:40 +0200 (CEST)
In-Reply-To: <s5hmuguqpjk.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Curtis Malainey <cujomalainey@google.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Daniel Drake <drake@endlessm.com>, Hui Wang <hui.wang@canonical.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 7/31/19 8:52 AM, Takashi Iwai wrote:
> On Mon, 29 Jul 2019 17:51:46 +0200,
> Pierre-Louis Bossart wrote:
>>
>> This is the second take on same problem of detecting when the HDaudio
>> legacy driver can be used and when the SST or SOF drivers are
>> required.
>>
>> The previous attempt based on a the PCI Class information was a
>> resounding failure and broke audio on Linus' laptop, so we need
>> additional information to avoid enabling a DSP-based driver without a
>> good reason to do so.
>>
>> This patchset suggests the use of the NHLT information which *in
>> theory* exposes DMIC endpoints. The legacy HDaudio driver cannot
>> handle DMICs and will not provide any capture capabilities. Since it's
>> typically the first one to probe due to the Makefile order, aborting
>> the probe will let the PCI subsystem look for the next driver which
>> hopefully will support this capability.
>>
>> I tested this patch on 5 devices (SKL, KBL, APL, GLK, WHL), three
>> without DMICs and two with, and the detection seems to work as
>> planned. Additional testing by Canonical and Endless folks did not
>> expose any issues.
>>
>> Changes since v3 (Feedback from Cezary)
>> Code cleanups (spaces and unnecessary inits)
>> Flipped test statement to return on errors and reduce indentation
>> Removed ACPI leak by adding missing ACPI_FREE()
>>
>> Changes since v2 (Feedback from Takahi and Cezary)
>> Added comment in Kconfig to alert the user to the dependency on ACPI
>>
>> Changes since v1 (Feedback from Takashi):
>> Squashed patch3 in patch2
>> Changed log to dbg_info
>> Fixed module parameter handling
>>
>> Changes since RFC:
>> Cosmetic code improvements
>> Moved intel-nhlt.h to include/sound
>> Moved intel-nhlt.c to sound/hda
>> Removed SOC prefixes
>> Added full-support for vendor-defined geometries
>> Added Kconfig and kernel module parameter to opt-in
>>
>> Pierre-Louis Bossart (5):
>>    ASoC: Intel: Skylake: move NHLT header to common directory
>>    ALSA: hda: move parts of NHLT code to new module
>>    ALSA: hda: intel-nhlt: handle NHLT VENDOR_DEFINED DMIC geometry
>>    ASoC: Intel: Skylake: use common NHLT module
>>    ALSA: hda/intel: stop probe if DMICS are detected on Skylake+
>>      platforms
> 
> Applied all five patches now.  Thanks.
> 
> Mark, the patches are found in topic/hda-dmic branch of sound git
> tree, which are based on 5.3-rc1.  If ASoC tree needs these changes,
> feel free to pull the branch into yours.

Thank you Takashi.

I will need to use these patches for SOF to dynamically change the 
topology file name depending on how many DMICs are detected for HDaudio 
platforms, if at all. The current solution requires the user to rename 
files and it's just not scalable.
