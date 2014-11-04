From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 0/5] ASoC: Intel: ACPI support and
	machines
Date: Tue, 04 Nov 2014 10:09:40 +0200
Message-ID: <545889C4.5000509@linux.intel.com>
References: <1415079068-4979-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id CEB492605EB
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 09:11:10 +0100 (CET)
In-Reply-To: <1415079068-4979-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 11/04/2014 07:31 AM, Vinod Koul wrote:
> This is second rev of patch series which fixes the modules split as
> discussed in ML. The core part is now module along with PCI and ACPI one.
> Added fix reported by Dan as well. Also added the BYTCR machine driver
>
> Subhransu S. Prusty (1):
>    ASoC: Intel: add BYTCR machine driver with RT5640
>
> Vinod Koul (4):
>    ASoC: Intel: mrfld - remove unnecessary check for pointer
>    ASoC: Intel: mrfld - create separate module for pci part
>    ASoC: Intel: mrfld - add shim save restore
>    ASoC: Intel: mrfld- add ACPI module
>
I think there is need to have some consolidation with current byt-rt5640 
and byt-max98090. Since existing drivers and this set are using the same 
ACPI IDs "80860F28" for the ADSP and "10EC5640" codec ACPIID for the 
machine driver probing these drivers won't work together.

One difference at the moment is that byt-rt5640 machines out there have 
differences in audio routings but those are not too difficult to handle 
in the same machine driver.

Bigger question how to handle platform part? I.e. can these use the same 
drivers and ADSP firmware? If they can, is the firmware available for 
distributions to take?

Optimally all machines out there would use the same drivers and get 
support for compressed audio but meanwhile we should not break existing 
machines.

-- 
jarkko
