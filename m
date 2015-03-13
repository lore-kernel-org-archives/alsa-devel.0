From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Intel SST on a Bay Trail tablet
Date: Fri, 13 Mar 2015 12:03:45 +0530
Message-ID: <20150313063345.GC32000@intel.com>
References: <20150223183913.fb262011d6300425da7f34be@ao2.it>
 <20150303151621.c6fc3cfa308aed62484b87a0@ao2.it>
 <54F5CB3D.7020100@linux.intel.com>
 <20150304170218.7b397993ce670902800109f1@ao2.it>
 <20150312144503.5e1d556e408a0b166e20058d@ao2.it>
 <5501A30E.2000408@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 4876C26055F
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 07:37:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5501A30E.2000408@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, Antonio Ospite <ao2@ao2.it>, Ramesh Babu K V <Ramesh.Babu@intel.com>, Omair Mohammed Abdullah <omair.m.abdullah@intel.com>, Harsha Priya <priya.harsha@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 12, 2015 at 04:30:38PM +0200, Jarkko Nikula wrote:
> Hi
> 
> On 03/12/2015 03:45 PM, Antonio Ospite wrote:
> >>Do you confirm that the ADMA0F28 and SSPX0000 devices I mentioned in the
> >>original mail are not necessary in the DSDT?
> >[...]
> >
> I don't know what their function is. I've seen them only in newer
> DSDT tables. I guess Windows 8.1 uses them for power management etc
> or it has separate drivers for DMA and SSP ports.
> 
> >Ping.
> >
> >Can anyone comment on this and my other questions in the previous email
> >regarding the DSP firmware?
> >
> Vinod, Ramesh: Do you know would it be possible to run that Android
> ELF firmware that is installed in the Teclast with the newer stack
> in sound/soc/intel/sst?
Sorry havent followed the thread, but we should be able to use the upstream
firware.
The ELF binary and the upstream ones are similar, we decided sometime back
to not use ELF for future dev so we didnt upstream that part.

-- 
~Vinod
