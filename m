From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCHv2] 0/5 Intel SST Low level drivers.
Date: Mon, 17 Feb 2014 13:31:59 +0000
Message-ID: <1392643919.2390.20.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5449E261B19
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 14:32:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, "Nikula, Jarkko" <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

Changes from V1 :-

o Fixed firmware_release() usage.
o Removed HSW tristate in Kconfig (it's part of the next series)
o Block alloc now iterative instead of recursive.
o Fixed symbols to be GPL
o Locked update_bits() now simplified.
o unified type's used in mailbox IO.
o Made sst_get_thread_context() and a few other small functions inline.
o Moved FW files to be read from intel/ sub directory.

One other change I've made that was not part of review comments is that
I've removed the DMA FW loader for the time being. I've been made aware
a new effort is almost ready that allows registration of ACPI devices
that have multiple sub devices in the ACPI space (e.g. ADSP has DMA and
SSP devices alongside the DSP). I'll then re-submit the DMA FW loader as
a separate patch using the new ACPI infrastructure. In the mean time the
driver can safely use memcopy for FW loading.

Liam 
