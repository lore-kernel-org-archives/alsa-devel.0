From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 0/8] ASoC: Prepare Sound Open Firmware
 (SOF) driver integration
Date: Thu, 19 Oct 2017 22:18:49 +0100
Message-ID: <1508447929.2004.13.camel@loki>
References: <20171012234945.30318-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 59DEE26705A
 for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2017 23:18:59 +0200 (CEST)
In-Reply-To: <20171012234945.30318-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2017-10-12 at 18:49 -0500, Pierre-Louis Bossart wrote:
> The Sound Open Firmware work [1] is progressing quickly and drivers
> for the 1.0 release will soon be submitted upstream. Before we do so,
> there is a new to reshuffle the ACPI integration and Intel
> Kconfig/Makefiles. 
> 
> We already have three incompatible drivers (BYT/HSW/BDW, Atom/BYT/CHT,
> SKL+) for historical reasons, blindly adding yet another one would be
> silly.  We need to avoid having the same ACPI routines and machine
> tables duplicated in 3 locations (soc/intel/common, soc/atom/sst and
> the upcoming soc/sof).
> 
> The ACPI routines should be part of sound/soc since there is no real
> hardware dependency (ACPI is not limited to Intel).
> 
> The ACPI table definitions and quirks are moved to a soc/intel/common module
> so that when new HIDs or quirks are added "legacy" and the SOF drivers
> are updated at once.
> 
> The Makefiles/Kconfig are also modified to select the SOC(s) first and
> the machine driver(s) second. The existing code only exposes machine
> drivers which precludes reuse of machine drivers when SOF platform
> drivers are selected. SOF drivers will be exposed in parallel to the
> 'Intel SST' ones (with an exclusive choice needed), but machine
> drivers will be shared.
> 
> These patches apply on top of broonie/for-next + all the patches I
> submitted this week (no dependency on SOF). For people with allergic
> reactions to patches over email, the code is here:
> https://github.com/plbossart/sound/commits/topic/acpi-updates6
> 
> This patchset does not address the case where two drivers are selected
> for the same ACPI HID. I just don't know of any technical solution to
> that problem.
> 
> changes since initial RFC:
> rebased to v4.14-rc2, used kernel style doc for machine descriptors,
> removed useless fields, split tables for each SOC
> corrected missing newlines
> 
> Pierre-Louis Bossart (8):
>   ASoC: move ACPI common code out of Intel/sst tree
>   ASoC: Intel: common: use c99 syntax for ACPI/machine tables
>   ASoC: ACPI: add new fields for SOF support
>   ASoC: Intel: move all ACPI match tables to common module
>   ASoC: Intel: add SOF firmare/topology file information
>   ASoC: Intel: move machine drivers to dedicated KConfig
>   ASoC: Intel: reorder boards Kconfig by chronological order
>   ASoC: Intel: clarify Kconfig dependencies

All

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
