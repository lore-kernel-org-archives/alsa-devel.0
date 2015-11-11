From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: ASoC Sound Driver I2S over LPE,
 Intel Baytrail SoC. MinnowBoard Max
Date: Wed, 11 Nov 2015 09:50:20 -0600
Message-ID: <564363BC.1010705@linux.intel.com>
References: <CAGOuWmvw39beNdaLgdBGXk9rNWw9vwbFfQNSBw50KLYpGa_AHA@mail.gmail.com>
 <56423D44.60505@linux.intel.com>
 <CAGOuWmv6c+jOKjzYJNbAiMXQQP=vrT_4i8yWrPB9X_F6ek=h8g@mail.gmail.com>
 <CAGOuWmsw8OKOxLEF0bXGY8-JSdJRxFjvgm1WTHGrL700xSRR-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id DEC182604D6
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 16:50:23 +0100 (CET)
In-Reply-To: <CAGOuWmsw8OKOxLEF0bXGY8-JSdJRxFjvgm1WTHGrL700xSRR-g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Pogrebinsky <michael.pogrebinsky@daqri.com>
Cc: John Hawley <john.hawley@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/10/15 8:18 PM, Michael Pogrebinsky wrote:
> Hi Pierre,
> I downloaded 4.3 stable kernel, and I applied all the commits in the repo
> you forwarded to me.
> I'm running into an issue, where after doing those instructions:
> "iasl -tc dsdt_minnow.dsl
>
> mv dsdt_minnow.hex include/

This is only needed if you modified dsdt_minnow.dsl. if you did, can you 
provide the log of iasl to make sure the .hex file generation goes well.

> the options following options need to be set in the .config
> for the tables to be taken into account:
>
> CONFIG_ACPI_CUSTOM_DSDT_FILE=dsdt_minnow.hex
> CONFIG_ACPI_CUSTOM_DSDT=y"

yes

> I am not able to boot the kernel.

did you try with the unmodified .hex file but those two options set?

Another thing to look at is that you need to enable the LPSS (and 
specifically I2C6) and disable HDAudio in the boot menu.
