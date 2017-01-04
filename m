From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 0/2] ASoC: Add support for rt5640 sound
 card found on HP Pavilion x2 10-p000 tablet.
Date: Wed, 4 Jan 2017 10:41:44 -0600
Message-ID: <37a424af-0ae9-5ccb-1e06-6ac224baaaa2@linux.intel.com>
References: <cover.1483531270.git.neko@nya.ai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A8ED1267098
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 17:41:48 +0100 (CET)
In-Reply-To: <cover.1483531270.git.neko@nya.ai>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandrov Stansilav <neko@nya.ai>, alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

On 1/4/17 6:22 AM, Alexandrov Stansilav wrote:
> Inside DSDT table there is record for this soundcard:
>
>             Device (RTKC)
>             {
>                 Name (_ADR, Zero)  // _ADR: Address
>                 Name (_HID, "10EC3276")  // _HID: Hardware ID
>                 Name (_CID, "10EC3276")  // _CID: Compatible ID
>                 Name (_DDN, "ALC3276")  // _DDN: DOS Device Name
>                 Name (_SUB, "103C827C")  // _SUB: Subsystem ID
>                 Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
>
> original bugreport: https://bugzilla.kernel.org/show_bug.cgi?id=187621
>
> v2: Splited patch to codec and sst parts
>
>  sound/soc/codecs/rt5640.c           | 1 +
>  sound/soc/intel/atom/sst/sst_acpi.c | 2 ++
>  2 files changed, 3 insertions(+)

The commit message is a tad long but the patch is legit
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
