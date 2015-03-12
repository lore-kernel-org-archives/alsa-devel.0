From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: Intel SST on a Bay Trail tablet
Date: Thu, 12 Mar 2015 16:30:38 +0200
Message-ID: <5501A30E.2000408@linux.intel.com>
References: <20150223183913.fb262011d6300425da7f34be@ao2.it>	<20150303151621.c6fc3cfa308aed62484b87a0@ao2.it>	<54F5CB3D.7020100@linux.intel.com>	<20150304170218.7b397993ce670902800109f1@ao2.it>
 <20150312144503.5e1d556e408a0b166e20058d@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BA5B72658A7
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 15:32:49 +0100 (CET)
In-Reply-To: <20150312144503.5e1d556e408a0b166e20058d@ao2.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Antonio Ospite <ao2@ao2.it>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Ramesh Babu K V <Ramesh.Babu@intel.com>, Omair Mohammed Abdullah <omair.m.abdullah@intel.com>, Harsha Priya <priya.harsha@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi

On 03/12/2015 03:45 PM, Antonio Ospite wrote:
>> Do you confirm that the ADMA0F28 and SSPX0000 devices I mentioned in the
>> original mail are not necessary in the DSDT?
> [...]
>
I don't know what their function is. I've seen them only in newer DSDT 
tables. I guess Windows 8.1 uses them for power management etc or it has 
separate drivers for DMA and SSP ports.

> Ping.
>
> Can anyone comment on this and my other questions in the previous email
> regarding the DSP firmware?
>
Vinod, Ramesh: Do you know would it be possible to run that Android ELF 
firmware that is installed in the Teclast with the newer stack in 
sound/soc/intel/sst?

-- 
Jarkko
