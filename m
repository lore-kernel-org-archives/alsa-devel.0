From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 01/19] ASoC: Intel: fix ACPI probe
 regression with Atom DPCM driver
Date: Fri, 18 Dec 2015 09:26:12 -0600
Message-ID: <56742594.1040402@linux.intel.com>
References: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1450406156-22246-2-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5hd1u4t48f.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 61F3826598D
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 16:26:27 +0100 (CET)
In-Reply-To: <s5hd1u4t48f.wl-tiwai@suse.de>
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
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, broonie@kernel.org, jack.yu@realtek.com
List-Id: alsa-devel@alsa-project.org

On 12/18/2015 04:56 AM, Takashi Iwai wrote:
> On Fri, 18 Dec 2015 03:35:38 +0100,
> Pierre-Louis Bossart wrote:
>>
>> Commit 5f3d57ebdda4de30e00e2d7c45b5247e5410fe6b introduced a
> 
> Please give the subject not only the commit ID.  (And I can't find
> this ID in linux-next tree.)

My bad, cherry-pick on my development branch changed the ID. Thanks for pointing this out.
It is in Mark's for-next branch (which is what all these patches apply against)

commit 95f098014815b330838b1173d3d7bcea3b481242
Author: Vinod Koul <vinod.koul@intel.com>
Date:   Thu Nov 5 21:34:11 2015 +0530

    ASoC: Intel: Move apci find machine routines


> 
>> regression in ACPI probe of the DPCM driver.
>> Fix by conditionally compiling sst-acpi when the DPCM driver
>> is not selected
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>  sound/soc/intel/common/Makefile | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
>> index 3b9332e..668fdee 100644
>> --- a/sound/soc/intel/common/Makefile
>> +++ b/sound/soc/intel/common/Makefile
>> @@ -1,5 +1,10 @@
>>  snd-soc-sst-dsp-objs := sst-dsp.o
>> +ifneq ($(CONFIG_SND_SST_IPC_ACPI),)
>> +snd-soc-sst-acpi-objs := sst-match-acpi.o
>> +else
>>  snd-soc-sst-acpi-objs := sst-acpi.o sst-match-acpi.o
>> +endif
>> +
> 
> A simpler version is like
> 
> snd-soc-sst-acpi-objs := sst-match-acpi.o
> snd-soc-sst-acpi-$(CONFIG_SND_SST_IPC_ACPI) += sst-acpi.o
> 
> 
> Takashi
> 
