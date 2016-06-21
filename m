From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: intel: fix build when ACPI is not
 enabled
Date: Tue, 21 Jun 2016 09:43:45 +0530
Message-ID: <20160621041345.GW16910@localhost>
References: <575A0362.2080604@infradead.org> <20160613042233.GX16910@localhost>
 <575ECB6C.7050102@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B7E552656F5
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2016 06:06:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <575ECB6C.7050102@infradead.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 13, 2016 at 08:04:12AM -0700, Randy Dunlap wrote:
> On 06/12/16 21:22, Vinod Koul wrote:
> > On Thu, Jun 09, 2016 at 05:01:38PM -0700, Randy Dunlap wrote:
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >>
> >> kconfig tools generate the following warning when CONFIG_ACPI is not
> >> enabled:
> >>
> >> warning: (SND_SOC_INTEL_BYTCR_RT5640_MACH && SND_SOC_INTEL_BYTCR_RT5651_MACH && SND_SOC_INTEL_CHT_BSW_RT5672_MACH && SND_SOC_INTEL_CHT_BSW_RT5645_MACH && SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH) selects SND_SST_IPC_ACPI which has unmet direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC && ACPI)
> >>
> >> causing these build errors:
> >>
> >> In file included from ../sound/soc/intel/atom/sst/sst_acpi.c:40:0:
> >> ../include/acpi/acpi_bus.h:65:20: error: conflicting types for 'acpi_evaluate_dsm'
> >>  union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const u8 *uuid,
> >> In file included from ../sound/soc/intel/atom/sst/sst_acpi.c:31:0:
> >> ../include/linux/acpi.h:676:34: note: previous definition of 'acpi_evaluate_dsm' was here
> >>  static inline union acpi_object *acpi_evaluate_dsm(acpi_handle handle,
> >>
> >> I am told that ACPI is a requirement for these drivers, so make that
> >> explicit. Also end help text sentences with a period.
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc:	Jie Yang <yang.jie@linux.intel.com>
> >> Cc:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >> Cc:	alsa-devel@alsa-project.org
> >> ---
> >>  sound/soc/intel/Kconfig |   12 ++++++------
> >>  1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >> Should SND_SOC_INTEL_SST and possibly other similar drivers get this
> >> same change?
> > 
> > The SND_SST_IPC_ACPI has depends on ACPI.
> > 
> > Can you send me your config for this.
> 
> Attached.

Thanks,

I was able to test this and tried few things. The SND_SST_IPC_ACPI has
depends but someone can still selecta ACPI machine and cause these errors so
I have moved the onus on machines and thus removed the depends and moved to
all the ACPI machines. The PCI ones don't care about this so they are okay.

Thanks for reporting, patches are posted now.

-- 
~Vinod
