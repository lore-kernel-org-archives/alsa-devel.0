From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: sst-acpi: Fix Oops in case of
 missing firmware
Date: Tue, 25 Feb 2014 14:42:20 +0000
Message-ID: <1393339340.2300.17.camel@loki>
References: <1393339067-10307-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A5A52655DE
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 15:42:49 +0100 (CET)
In-Reply-To: <1393339067-10307-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2014-02-25 at 16:37 +0200, Jarkko Nikula wrote:
> I swear I tested missing firmware in commit e5161d7987f1 ("ASoC: Intel:
> sst-acpi: Request firmware before SST platform driver probing").
> 
> Unfortunately same wasn't done in commit 6dda27cbbd1d ("ASoC: Intel:
> sst-acpi: Add support for multiple machine drivers per platform") which
> will cause NULL pointer dereference in sst_acpi_fw_cb() when printing the
> error since sst_acpi->mach is not set.
> 
> Fix this obvious error by setting the sst_acpi->mach in sst_acpi_probe().
> 
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
